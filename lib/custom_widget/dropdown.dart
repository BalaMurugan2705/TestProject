import 'package:flutter/material.dart';

class MyDropdownWidget extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String?> onChanged;
  Color? color;

  MyDropdownWidget(
      {required this.items,
      required this.selectedValue,
      required this.onChanged,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DropdownButton<String>(
          isExpanded: true,
          focusColor: Colors.black,
          borderRadius: BorderRadius.circular(10),
          value: selectedValue,
          onChanged: onChanged,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          underline: Container(
            height: 0,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
