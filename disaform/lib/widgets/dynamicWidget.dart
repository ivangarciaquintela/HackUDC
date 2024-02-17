import 'package:disaform/models/formFieldSchema.dart';
import 'package:flutter/material.dart';

class DynamicFormField extends StatelessWidget {
  final FormFieldSchema schema;

  DynamicFormField({required this.schema});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            schema.fieldName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          _buildField(context),
        ],
      ),
    );
  }

  Widget _buildField(BuildContext context) {
    switch (schema.fieldType) {
      case 'text':
        return TextFormField(
          decoration: InputDecoration(
            hintText: schema.fieldDescription,
          ),
          readOnly: schema.fieldReadonly ?? false,
          initialValue: schema.fieldDefaultValue,
        );
      case 'number':
        return TextFormField(
          decoration: InputDecoration(
            hintText: schema.fieldDescription,
          ),
          readOnly: schema.fieldReadonly ?? false,
          initialValue: schema.fieldDefaultValue?.toString(),
          keyboardType: TextInputType.number,
        );
      case 'date':
        return Container(); // Implementa según tu solución.
      case 'selection':
        return Container(); // Implementa según tu solución.
      case 'checkbox':
        return CheckboxListTile(
          title: Text(schema.fieldName),
          value: schema.fieldDefaultValue ?? false,
          onChanged: (bool? value) {},
        );
      default:
        return Text('Tipo de campo no soportado');
    }
  }
}
