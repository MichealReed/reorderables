import 'package:flutter_web/material.dart';

import 'package:reorderables/reorderables.dart';

class ColumnExample2 extends StatefulWidget {
  @override
  _ColumnExample2State createState() => _ColumnExample2State();
}

class _ColumnExample2State extends State<ColumnExample2> {
  List<Widget> _rows;

  @override
  void initState() {
    super.initState();
    _rows = List<Widget>.generate(
        10,
        (int index) => Text('This is row $index',
            key: ValueKey(index), textScaleFactor: 1.5));
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _rows.removeAt(oldIndex);
        _rows.insert(newIndex, row);
      });
    }

    Widget reorderableColumn = IntrinsicWidth(
        child: ReorderableColumn(
      header: Text('List-like view but supports IntrinsicWidth'),
//        crossAxisAlignment: CrossAxisAlignment.start,
      children: _rows,
      onReorder: _onReorder,
      onNoReorder: (int index) {
        //this callback is optional
        debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
      },
    ));

    return Transform(
      transform: Matrix4.rotationZ(0),
      alignment: FractionalOffset.topLeft,
      child: Material(
        child: Card(child: reorderableColumn),
        elevation: 6.0,
        color: Colors.transparent,
        borderRadius: BorderRadius.zero,
      ),
    );
  }
}
