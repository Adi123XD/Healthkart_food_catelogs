import 'package:flutter/material.dart';

class EditNutrientDialog extends StatelessWidget {
  final String nutrient;
  final String initialValue;
  final Function(String) onValueChanged;

  const EditNutrientDialog({
    Key? key,
    required this.nutrient,
    required this.initialValue,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController valueController = TextEditingController(
      text: initialValue,
    );

    return AlertDialog(
      title: Text('Edit Nutrient Value'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            nutrient,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextField(
            controller: valueController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Value',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            onValueChanged(valueController.text);
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
