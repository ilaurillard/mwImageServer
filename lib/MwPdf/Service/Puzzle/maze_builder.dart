List<List<Cell>> generate({
  int size = 8,
  bool closed = true,
  int seed = 1,
}) {
  RndFunc random = mulberry32(seed);
  List<List<Cell>> maze = [];
  Iterable<int> r = range(size);

  // Populate maze with empty cells:
  for (int y = 0; y < size; y += 1) {
    List<Cell> row = r.map((x) {
      return Cell(
        x: x,
        y: y,
        top: closed || y > 0,
        left: closed || x > 0,
        bottom: closed || y < (size - 1),
        right: closed || x < (size - 1),
        set: 0,
      );
    }).toList();
    maze.add(row);
  }

  initial(maze).asMap().forEach((y, row) {
    row = populateMissingSets(row, random);
    row = mergeRandomSetsIn(row, random);
    addSetExits(row, maze[y + 1], random);
  });

  List<Cell> lastRow = last(maze).toList();
  lastRow = populateMissingSets(lastRow, random);
  lastRow = mergeRandomSetsIn(lastRow, random, probability: 1);

  maze.first.first.left = false;
  maze.last.last.right = false;

  return maze;
}

class Cell {
  int x;
  int y;
  bool top;
  bool left;
  bool right;
  bool bottom;
  double set;

  Cell({
    required this.x,
    required this.y,
    required this.top,
    required this.left,
    required this.bottom,
    required this.right,
    this.set = 0.0,
  });

  dynamic propertyByKey(String key) {
    switch (key) {
      case 'set':
        return set;
      case 'x':
        return x;
      case 'y':
        return y;
      case 'top':
        return top;
      case 'bottom':
        return bottom;

      case 'left':
        return left;
      case 'right':
        return right;
    }
  }

  @override
  String toString() {
    return '$x/$y [$set]';
  }
}

List<double> compact(List<double> array) {
  return array.where((u) => u != 0.0).toList();
}

List<double> difference(List<double> c, List<double> d) {
  return [c, d].reduce((a, b) => c.toSet().difference(b.toSet()).toList());
}

List<List<Cell>> initial(List<List<Cell>> array) {
  return array.sublist(0, array.length - 1);
}

List<Cell> initial2(List<Cell> array) {
  return array.sublist(0, array.length - 1);
}

Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
  Map<T, List<S>> map = <T, List<S>>{};
  for (var element in values) {
    (map[key(element)] ??= []).add(element);
  }
  return map;
}

List<Cell> last(List<List<Cell>> array) {
  return array[array.length - 1];
}

Iterable<int> range(
  int n, {
  int end = 0,
}) {
  return end != 0
      ? List<int>.from(List<int>.generate(
          end - n,
          (int index) => index,
          growable: true,
        )).map((k) => k + n)
      : List<int>.from(List<int>.generate(
          n.round(),
          (int index) => index,
          growable: true,
        ));
}

List<double> uniq(List<double> array) {
  return [...Set.from(array)];
}

List<Cell> sampleSize(
  List<Cell> array,
  int? n,
  RndFunc random,
) {
  n = n ?? 1;
  int length = array.length;

  if (length == 0 || n < 1) {
    return [];
  }
  n = n > length ? length : n;
  int index = -1;
  double lastIndex = length - 1;
  List<Cell> result = [...array];
  while (++index < n) {
    int rand = index + (random() * (lastIndex - index + 1)).floor();
    Cell value = result[rand];
    result[rand] = result[index];
    result[index] = value;
  }
  return result.sublist(0, n.round());
}

typedef RndFunc = double Function();

RndFunc mulberry32(int seed) {
  return () {
    seed += 0x6D2B79F5;
    int t = seed;
    t = imul2(t ^ t >> 15, t | 1);
    t ^= t + imul2(t ^ t >> 7, t | 61);
    double result = ((t ^ t >> 14) >> 0) / 4294967296;

    return result;
  };
}

int imul2(int a, int b) {
  int aHi = (a >> 16) & 0xffff;
  int aLo = a & 0xffff;
  int bHi = (b >> 16) & 0xffff;
  int bLo = b & 0xffff;
  return ((aLo * bLo) + (((aHi * bLo + aLo * bHi) << 16) >> 0)).toSigned(32);
}

List<Cell> mergeSetWith(List<Cell> row, double oldSet, double newSet) {
  for (var box in row) {
    if (box.set == oldSet) box.set = newSet;
  }

  return row;
}

List<Cell> populateMissingSets(
  List<Cell> row,
  RndFunc random,
) {
  List<double> map = row.map((row) => row.set).toList();
  List<double> u2 = uniq(map);
  List<double> setsInUse = compact(u2);
  List<double> allSets = range(1, end: row.length + 1)
      .toList()
      .map((int value) => value.toDouble())
      .toList();
  List<double> diff = difference(
    allSets.cast<double>(),
    setsInUse,
  );
  List<double> availableSets = diff.cast<double>();
  availableSets.sort((a, b) => (0.5 - random()).sign.toInt());
  row.where((box) => box.set == 0).toList().asMap().forEach((i, box) {
    box.set = availableSets[i];
  });
  return row;
}

List<Cell> mergeRandomSetsIn(
  List<Cell> row,
  RndFunc random, {
  double probability = 0.5,
}) {
  List<Cell> allBoxesButLast = initial2(row);
  allBoxesButLast.asMap().forEach((x, current) {
    Cell next = row[x + 1];
    bool differentSets = current.set != next.set;
    double rand = random();
    bool shouldMerge = rand <= probability;
    if (differentSets && shouldMerge) {
      row = mergeSetWith(
        row,
        next.set,
        current.set,
      );
      current.right = false;
      row[x + 1].left = false;
    }
  });

  allBoxesButLast.add(row[row.length - 1]);
  return allBoxesButLast;
}

List<List<Cell>> addSetExits(
  List<Cell> row,
  List<Cell> nextRow,
  RndFunc random,
) {
  List<List<Cell>> setsInRow = [];

  groupBy(row, (item) => (item).set.round()).forEach((key, value) {
    setsInRow.add(value);
  });

  for (List<Cell> set in setsInRow) {
    List<Cell> exits = sampleSize(
      set,
      (random() * set.length).ceil(),
      random,
    );
    for (Cell exit in exits) {
      Cell below = nextRow[exit.x];
      exit.bottom = false;
      below.top = false;
      below.set = exit.set;
    }
  }

  return setsInRow;
}
