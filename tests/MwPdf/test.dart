import 'package:mwcdn/MwPdf/Service/Maze/maze_builder.dart';

Future<void> main() async {
  List<List<Cell>> maze = generate(width: 5, height: 5);

  for (List<Cell> row in maze) {
    for (Cell cell in row) {
      
    }
    print('----------');
  }

}
