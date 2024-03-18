import 'package:mwcdn/MwPdf/Service/Puzzle/word_search.dart';

Future<void> main() async {
  // List<List<Cell>> maze = generate(size: 5);
  // for (List<Cell> row in maze) {
  //   for (Cell cell in row) {
  //
  //   }
  //   print('----------');
  // }

  WordSearchBuilder wsb = WordSearchBuilder(
    size: 14,
    words: ['BANANE'],
  );

  wsb.create();
  for (List<String> row in wsb.grid) {
    print(row);
  }
}
