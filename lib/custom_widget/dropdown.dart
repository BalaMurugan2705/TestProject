import 'package:flutter/material.dart';

class MyDropdownWidget extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String?> onChanged;

  MyDropdownWidget({required this.items, required this.selectedValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DropdownButton<String>(
          isExpanded: true,
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
