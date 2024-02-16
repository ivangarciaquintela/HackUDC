import 'package:disaform/models/formFieldSchema.dart';
import 'package:flutter/material.dart';

class DynamicFormField extends StatelessWidget {
  final FormFieldSchema schema;

  DynamicFormField({required this.schema});

  @override
  Widget build(BuildContext context) {
    switch (schema.fieldType) {
      case 'text':
        return TextFormField(
          decoration: InputDecoration(
            labelText: schema.fieldName,
            hintText: schema.fieldDescription,
          ),
          readOnly: schema.fieldReadonly,
          initialValue: schema.fieldDefaultValue,
        );
      case 'number':
        return TextFormField(
          decoration: InputDecoration(
            labelText: schema.fieldName,
            hintText: schema.fieldDescription,
          ),
          readOnly: schema.fieldReadonly,
          initialValue: schema.fieldDefaultValue?.toString(),
          keyboardType: TextInputType.number,
        );
      case 'date':
        // Aquí podrías necesitar un paquete externo como 'flutter_datetime_picker'
        // para implementar un selector de fecha, o construir uno propio.
        return Container(); // Placeholder, implementa según tu solución.
      case 'selection':
        // Este caso podría implementarse usando DropdownButton o un widget similar.
        return Container(); // Placeholder, implementa según tu solución.
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
