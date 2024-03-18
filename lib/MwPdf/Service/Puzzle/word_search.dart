import 'dart:math';

class WordSearchBuilder {
  List<List<String>> grid = [];
  final List<String> words;
  List<Option> placements = [];

  final int size;

  late final Random rng;
  final int? seed;

  WordSearchBuilder({
    this.size = 13,
    this.words = const [],
    this.seed,
  });

  void create() {
    rng = Random(seed);
    grid = List.generate(
        size,
        (i) => List.generate(
              size,
              (i) => '.',
            ));
    placements = [];
    for (String word in words) {
      placeWord(word.toUpperCase());
    }
    // placeWord('MELONE');
    // placeWord('BANANE');
    // placeWord('APFEL');
    // placeWord('PFIRSICH');
    // placeWord('NEKTARINE');
    // placeWord('GRAPEFRUIT');
    // placeWord('ZITRONE');
    // placeWord('HIMBEERE');
    // placeWord('KIWI');
    // placeWord('ERDBEERE');

    for (int y = 0; y < size; y++) {
      for (int x = 0; x < size; x++) {
        if (grid[y][x] == '.') {
          grid[y][x] = String.fromCharCode(rng.nextInt(26) + 65);
        }
      }
    }
  }

  void placeWord(
    String word,
  ) {
    int len = word.length;
    if (len > size) {
      return;
    }

    List<String> letters = word.split('');
    List<Option> options = [];

    int minOverlaps = 0;
    for (int dir = 0; dir < 8; dir++) {
      Offset p1 = fieldOffset1(len, dir);
      Offset p2 = fieldOffset2(len, dir);
      Offset d = delta(dir);
      for (int y = 0; y < size; y++) {
        for (int x = 0; x < size; x++) {
          if (x >= p1.x && x <= p2.x && y >= p1.y && y <= p2.y) {
            int tx = x;
            int ty = y;
            bool possible = true;
            int overlaps = 0;
            for (String letter in letters) {
              bool i = grid[ty][tx] == letter;
              if (grid[ty][tx] == '.' || i) {
                if (i) {
                  overlaps++;
                }
              } else {
                possible = false;
              }
              tx += d.x;
              ty += d.y;
            }
            if (possible) {
              options.add(
                Option(
                  word: word,
                  direction: dir,
                  offset: Offset(x, y),
                  end: Offset(x + (d.x * (len - 1)), y + (d.y * (len - 1))),
                  overlaps: overlaps,
                ),
              );
              minOverlaps = min(
                minOverlaps,
                overlaps,
              );
            }
          }
        }
      }
    }

    // options.removeWhere((Option o) => o.overlaps > minOverlaps);

    if (options.isNotEmpty) {
      options.shuffle(rng);
      Option option = options[0];
      placements.add(option);
      int tx = option.offset.x;
      int ty = option.offset.y;
      Offset d = delta(option.direction);
      for (String letter in letters) {
        grid[ty][tx] = letter;
        tx += d.x;
        ty += d.y;
      }
    }
  }

  Offset fieldOffset1(
    int l,
    int dir,
  ) {
    switch (dir) {
      case Direction.horizontal:
        return Offset(0, 0);
      case Direction.diagonal:
        return Offset(0, 0);
      case Direction.vertical:
        return Offset(0, 0);
      case Direction.diagonalUpBack:
        return Offset(l - 1, 0);
      case Direction.horizontalBack:
        return Offset(l - 1, 0);
      case Direction.diagonalBack:
        return Offset(l - 1, l - 1);
      case Direction.verticalBack:
        return Offset(0, l - 1);
      case Direction.diagonalUp:
        return Offset(0, l - 1);
    }
    return Offset(0, 0);
  }

  Offset fieldOffset2(
    int l,
    int dir,
  ) {
    switch (dir) {
      case Direction.horizontal:
        return Offset(size - l, size);
      case Direction.diagonal:
        return Offset(size - l, size - l);
      case Direction.vertical:
        return Offset(size, size - l);
      case Direction.diagonalUpBack:
        return Offset(size, size - l);
      case Direction.horizontalBack:
        return Offset(size, size);
      case Direction.diagonalBack:
        return Offset(size, size);
      case Direction.verticalBack:
        return Offset(size, size);
      case Direction.diagonalUp:
        return Offset(size - l, size);
    }
    return Offset(0, 0);
  }

  Offset delta(int dir) {
    switch (dir) {
      case Direction.horizontal:
        return Offset(1, 0);
      case Direction.diagonal:
        return Offset(1, 1);
      case Direction.vertical:
        return Offset(0, 1);
      case Direction.diagonalUpBack:
        return Offset(-1, 1);
      case Direction.horizontalBack:
        return Offset(-1, 0);
      case Direction.diagonalBack:
        return Offset(-1, -1);
      case Direction.verticalBack:
        return Offset(0, -1);
      case Direction.diagonalUp:
        return Offset(1, -1);
    }
    return Offset(0, 0);
  }
}

class Direction {
  static const int horizontal = 0;
  static const int diagonal = 1;
  static const int vertical = 2;
  static const int diagonalUpBack = 3;
  static const int horizontalBack = 4;
  static const int diagonalBack = 5;
  static const int verticalBack = 6;
  static const int diagonalUp = 7;
}

class Option {
  final String word;
  final int direction;
  final Offset offset;
  final Offset end;
  final int overlaps;

  Option({
    this.word = '',
    this.direction = Direction.horizontal,
    this.offset = const Offset(0, 0),
    this.end = const Offset(0, 0),
    this.overlaps = 0,
  });

  @override
  String toString() {
    return '$direction $offset $overlaps';
  }
}

class Offset {
  final int x;
  final int y;

  const Offset(this.x, this.y);

  @override
  String toString() {
    return '$x/$y';
  }
}
