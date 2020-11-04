import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: non_constant_identifier_names
Widget InputField(String _label, String _prefix, Function _callback,
    TextEditingController _controller) {
  return TextField(
    controller: _controller,
    keyboardType: TextInputType.number,
    onChanged: (value) => _callback(_label, value),
    style: TextStyle(color: Colors.amber),
    decoration: InputDecoration(labelText: _label, prefixText: _prefix),
  );
}
