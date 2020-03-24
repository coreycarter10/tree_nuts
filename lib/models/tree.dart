class Tree {
  final List<List<Cell>> _grid;
  int _currentRow = 0;

  Tree(this._grid);

  factory Tree.fromStrings(List<String> rows) {
    final List<List<Cell>> grid = [];

    for (String row in rows) {
      final rowList = row.split('');
      final cellList = rowList.map((String value) => value == 'o' ? Cell(' ', 1) : Cell(value));

      grid.add(cellList.toList());
    }

    return Tree(grid);
  }

  void go() {
    for (int col = 0; col < _grid[_currentRow].length; col++) {
      final currentCell = _grid[_currentRow][col];

      if (!currentCell.hasNuts || currentCell.isFlat) {
        continue;
      }

      final nextRow = _currentRow + 1;
      final underCell = _grid[nextRow][col];
      Cell destCell;

      switch (underCell.type) {
        case ' ':
        case '_':
        case '|': destCell = underCell; break;
        case '/': destCell =  _grid[nextRow][col - 1]; break;
        case r'\': destCell =  _grid[nextRow][col + 1]; break;
      }

      destCell.add(currentCell.tumble());
    }

    _currentRow++;
  }

  int get height => _grid.length;
  List<int> get ground => _grid[height - 1].map((Cell cell) => cell.nuts).toList();

  @override
  String toString() {
    final sb = StringBuffer();
    _grid.forEach((List<Cell> row) => sb.writeln(row.join('   ')));
    return sb.toString();
  }
}

class Cell {
  final String type;
  int _nuts;
  int get nuts => _nuts;

  Cell(this.type, [this._nuts = 0]);

  void add(int nutsToAdd) => _nuts += nutsToAdd;

  int tumble() {
    final fallingNuts = nuts;
    _nuts = 0;

    return fallingNuts;
  }

  bool get hasNuts => _nuts > 0;
  bool get isFlat => type == '_';

  @override
  String toString() => "$type$_nuts";
}