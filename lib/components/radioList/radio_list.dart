import 'package:flutter/material.dart';

class RadioList extends StatefulWidget {
  final int? selectedValue;
  final Function(int)? onItemSelected;

  const RadioList({
    super.key,
    this.selectedValue,
    this.onItemSelected,
  });

  @override
  _RadioListState createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  int? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          title: Text(
            'Filtrar por:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        RadioListTile<int>(
          value: 1,
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
            widget.onItemSelected?.call(value!);
            Navigator.pop(context);
          },
          title: const Text(
            'Numero',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          dense: true,
          controlAffinity: ListTileControlAffinity.trailing,
          tileColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
          ),
        ),
        RadioListTile<int>(
          value: 2,
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
            widget.onItemSelected?.call(value!);
            Navigator.pop(context);
          },
          title: const Text(
            'Nome',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          dense: true,
          controlAffinity: ListTileControlAffinity.trailing,
          tileColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.0)),
          ),
        ),
      ],
    );
  }
}
