import 'package:disaform/models/formFieldSchema.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      return InkWell(
        onTap: () {
          _selectDate(context);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            hintText: widget.schema.fieldDescription,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(_selectedDate != null
                  ? DateFormat.yMMMd().format(_selectedDate!)
                  : 'Seleccionar Fecha'),
              Icon(Icons.calendar_today),
            ],
          ),
        ),
      );
      case 'select':
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

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        if (widget.onChanged != null) {
          widget.onChanged!(_selectedDate.toString());
        }
      });
    }
  }
}