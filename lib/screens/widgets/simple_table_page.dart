// Taken from https://github.com/AlexBacich/sticky-headers-table/blob/master/example/lib/simple_table_page.dart

import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class SimpleTablePage extends StatelessWidget {
  SimpleTablePage(
      {required this.data, required this.titleColumn, required this.titleRow});

  final List<List<String>> data;
  final List<String> titleColumn;
  final List<String> titleRow;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StickyHeadersTable(
        columnsLength: titleColumn.length,
        rowsLength: titleRow.length,
        columnsTitleBuilder: (i) => Text(titleColumn[i]),
        rowsTitleBuilder: (i) => Text(titleRow[i]),
        contentCellBuilder: (i, j) => Text(data[i][j]),
        legendCell: Text('No.'),
      ),
    );
  }
}
