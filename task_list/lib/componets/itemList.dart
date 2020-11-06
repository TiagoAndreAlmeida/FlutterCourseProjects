import 'package:flutter/material.dart';
import 'package:task_list/models/TodoItem.dart';

Widget itemList(TodoItem item, Function _callback) {
  return (CheckboxListTile(
    title: Text(item.title),
    value: item.done,
    onChanged: _callback,
  ));
}
