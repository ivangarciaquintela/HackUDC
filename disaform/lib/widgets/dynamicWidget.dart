import 'package:disaform/models/formFieldSchema.dart';
import 'package:flutter/material.dart';

class DynamicFormField extends StatefulWidget {
  final FormFieldSchema schema;
  final void Function(String?)? onChanged; // Función de devolución de llamada para manejar el cambio de valor

  DynamicFormField({required this.schema, this.onChanged});

  @override
  _DynamicFormFieldState createState() => _DynamicFormFieldState();
}

class _DynamicFormFieldState extends State<DynamicFormField> {
  String? _fieldValue; // Variable para almacenar el valor del campo

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.schema.fieldName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          _buildField(context),
        ],
      ),
    );
  }

  Widget _buildField(BuildContext context) {
    switch (widget.schema.fieldType) {
      case 'text':
        return TextFormField(
          decoration: InputDecoration(
            hintText: widget.schema.fieldDescription,
          ),
          readOnly: widget.schema.fieldReadonly ?? false,
          initialValue: widget.schema.fieldDefaultValue,
          onChanged: (value) {
            _fieldValue = value; // Almacenar el valor del campo en la variable local
            if (widget.onChanged != null) {
              widget.onChanged!(_fieldValue); // Invocar la función de devolución de llamada
            }
          },
        );
      case 'number':
        return TextFormField(
          decoration: InputDecoration(
            hintText: widget.schema.fieldDescription,
          ),
          readOnly: widget.schema.fieldReadonly ?? false,
          initialValue: widget.schema.fieldDefaultValue?.toString(),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            _fieldValue = value; // Almacenar el valor del campo en la variable local
            if (widget.onChanged != null) {
              widget.onChanged!(_fieldValue); // Invocar la función de devolución de llamada
            }
          },
        );
      case 'date':
        return Container();
      case 'selection':
        return Container(); // Implementa según tu solución.
      case 'checkbox':
        return CheckboxListTile(
          title: Text(widget.schema.fieldName),
          value: widget.schema.fieldDefaultValue ?? false,
          onChanged: (bool? value) {},
        );
      default:
        return Text('Tipo de campo no soportado');
    }
  }

}
