import 'dart:math';

class Cell {
  bool border;
  String type;

  int value;
  int hintv;
  int hinth;

  Cell({
    this.type = '',
    this.border = false,
    this.value = 0,
    this.hintv = 0,
    this.hinth = 0,
  });

  @override
  String toString() {
    return type == 'hint' ? 'Hint $hintv $hinth' : 'Num $value';
  }

  bool isHint() {
    return type == 'hint';
  }
}

extension ListGetExtension<T> on List<T> {
  T? tryGet(int index) => index < 0 || index >= length ? null : this[index];
}

typedef Row = List<Cell>;
typedef Board = List<Row>;
typedef BoardCheck = List<List<bool>>;
typedef BoardCalc = List<List<Map<int, bool>?>>;
typedef CellFunc = void Function(int x, int y, Cell cell);
typedef CheckFunc = bool Function(int x, int y, Cell cell);

int randomInt(int bound) {
  return Random().nextInt(bound);
}

List<List<T>> array2d<T>(
    int width,
    int height,
    T Function(int, int) fn,
    ) {
  return List.generate(width, (x) {
    return List.generate(height, (y) {
      return fn(x, y);
    });
  });
}

BoardCheck checkBoard(Board board) {
  return board.map((
      Row row,
      ) {
    return List.filled(row.length, false);
  }).toList();
}

BoardCalc calcBoard(Board board) {
  return board.map((
      Row row,
      ) {
    return List<Map<int, bool>?>.generate(
      row.length,
          (int index) => null,
    );
  }).toList();
}

void for2d(Board board, CellFunc fn) {
  board.asMap().forEach((int y, Row row) {
    row.asMap().forEach((int x, Cell cell) {
      fn(x, y, cell);
    });
  });
}

void for2dType(
    Board board,
    String type,
    CellFunc fn,
    ) {
  for2d(
    board,
        (int x, int y, Cell cell) {
      if (cell.type == type) {
        fn(x, y, cell);
      }
    },
  );
}

(int, int, int) forNumGroup(
    Board board,
    int x,
    int y,
    int xoffs,
    int yoffs,
    CellFunc fn,
    int len,
    ) {
  x += xoffs;
  y += yoffs;

  Cell? cell = board.tryGet(y)?.tryGet(x);
  if (cell != null && cell.type == 'num') {
    fn(x, y, cell);
    return forNumGroup(
      board,
      x,
      y,
      xoffs,
      yoffs,
      fn,
      ++len,
    );
  }
  return (len, x, y);
}

Board makeBoard(
    int w,
    int h,
    double density,
    ) {
  Board board;
  bool badBoard;
  int tries = 10;
  do {
    badBoard = false;
    try {
      board = randomBoard(w, h, density);
      fixBoard(board);
      calcNums(board);
      return board;
    } catch (err) {
      print('Warning: $err');
      tries--;
      if (tries == 0) {
        throw Exception('No more tries');
      }
      badBoard = true;
    }
  } while (badBoard);
}

void calcNums(Board board) {
  BoardCalc seenrow = calcBoard(board);
  BoardCalc seencol = calcBoard(board);
  // group numbers together
  for2dType(
    board,
    'hint',
        (int x, int y, Cell cell) {
      void groupCells(
          int xoff,
          int yoff,
          BoardCalc arr,
          Map<int, bool>? seen,
          ) {
        forNumGroup(
          board,
          x,
          y,
          xoff,
          yoff,
              (int x, int y, Cell cell) => arr[y][x] = seen,
          0,
        );
      }

      groupCells(1, 0, seenrow, {});
      groupCells(0, 1, seencol, {});
    },
  );

  // calculate number for each cell
  for2dType(board, 'num', (int x, int y, Cell cell) {
    int value = randomInt(9) + 1;
    int origValue = value;
    Map<int, bool> row = seenrow[y][x]!;
    Map<int, bool> col = seencol[y][x]!;
    while ((row[value] ?? false) || (col[value] ?? false)) {
      value = (value % 9) + 1; // increment and wrap from 9->1
      if (value == origValue) {
        throw Exception('Number collision');
      }
    }
    row[value] = col[value] = true;
    cell.value = value;
  });

// // total hints
  for2dType(board, 'hint', (x, y, cell) {
    int totalCells(int xoff, int yoff) {
      int total = 0;
      forNumGroup(board, x, y, xoff, yoff, (int x, int y, Cell cell) {
        total += cell.value;
      }, 0);
      return total;
    }

    cell.hintv = totalCells(0, 1);
    cell.hinth = totalCells(1, 0);
  });
}

void fixBoard(Board board) {
  // print('fixBoard');
  bool fixAgain = false;
  void fixDir(int xoffs, int yoffs) {
    for2dType(
      board,
      'hint',
          (x, y, cell) {
        // print('+++');
        var (len, ex, ey) = forNumGroup(
          board,
          x,
          y,
          xoffs,
          yoffs,
              (
              int x,
              int y,
              Cell cell,
              ) {},
          0,
        );
        // print('$len $ex $ey');
        if (len == 1) {
          // print('???');
          Cell? endcell = board.tryGet(ey)?.tryGet(ex);
          fixAgain = true;
          if (endcell == null ||
              endcell.border ||
              (Random().nextDouble() < 0.5 && !cell.border)) {
            cell.type = 'num';
          } else {
            endcell.type = 'num';
          }
        } else if (len > 9) {
          // print('###');
          int rndx(int a, int b) {
            return (a + (b - a) * Random().nextDouble()).floor();
          }

          board[rndx(y + yoffs, ey)][rndx(x + xoffs, ex)].type = 'hint';
        }
      },
    );
  }

  do {
    fixAgain = false;
    fixDir(0, 1);
    fixDir(1, 0);
  } while (fixAgain);

  // ---------------

  // continuity check
  // pass 1: count cells, mark not seen, find some number
  int cx = 0, cy = 0;
  int cellCount = 0;
  BoardCheck seen = checkBoard(board);
  for2dType(
    board,
    'num',
        (x, y, cell) => (cx, cy, cellCount) = (x, y, cellCount + 1),
  );

  // pass 2: flood fill from the number, and count
  int seenCount = 0;
  void floodFill(int x, int y) {
    void fillNeighbour(int x, int y) {
      Cell? cell = board.tryGet(y)?.tryGet(x);
      if (cell != null && cell.type == 'num' && !seen[y][x]) {
        seen[y][x] = true;
        ++seenCount;
        floodFill(x, y);
      }
    }

    fillNeighbour(x - 1, y);
    fillNeighbour(x + 1, y);
    fillNeighbour(x, y - 1);
    fillNeighbour(x, y + 1);
  }

  floodFill(cx, cy);
  if (cellCount > seenCount) {
    throw Exception('non-continuous board');
  }
}

Board randomBoard(
    int w,
    int h,
    double density,
    ) {
  Board board = array2d(w + 2, h + 2, (int x, int y) {
    if (x == 0 || x == w + 1 || y == 0 || y == h + 1) {
      return Cell(
        type: 'hint',
        border: true,
      );
    } else {
      return Cell(
        type: 'num',
      );
    }
  });

  bool isHint(int x, int y) {
    return board[y][x].type == 'hint';
  }

  bool isValid(
      int x,
      int y,
      ) {
    return [
      [1, 0],
      [0, 1],
      [0, -1],
      [-1, 0]
    ].every((List<int> offset) {
      int xoff = offset[0];
      int yoff = offset[1];
      return isHint(x + xoff, y + yoff) || !isHint(x + xoff * 2, y + yoff * 2);
    });
  }

  int tries = 500;
  for (int i = 0; i < (density * w * h);) {
    int x = randomInt(w) + 1;
    int y = randomInt(w) + 1;
    // print(' - $i $x $y');
    Cell cell = board[y][x];
    if (!isHint(x, y) && isValid(x, y)) {
      cell.type = 'hint';
      ++i;
    }
    tries--;
    if (tries == 0) {
      throw Exception('Hmmm');
    }
  }

  return board;
}