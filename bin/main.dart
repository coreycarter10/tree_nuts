import 'package:tree_nuts/models/tree.dart';

final treeData = [" o o o  ",
  " /    / ",
  "   /    ",
  "  /  /  ",
  "   ||   ",
  "   ||   ",
  "   ||   "
];

void main() {
  final tree = Tree.fromStrings(treeData);
  print(tree);

  for (int i = 0; i < tree.height -1; i++) {
    tree.go();
    print(' ');
    print(tree);
  }

  print(tree.ground);
}
