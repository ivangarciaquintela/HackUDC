/*
 * Autores: Anxo Castro Alonso, Ivan García Quintela, Mateo Amado Ares
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'package:disaform/models/formFieldSchema.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DynamicFormField extends StatefulWidget {
  final FormFieldSchema schema;
  final void Function(String?)?
      onChanged; // Función de devolución de llamada para manejar el cambio de valor
  final bool isVisible;

  DynamicFormField(
      {required this.schema, this.onChanged, this.isVisible = true});

  @override
  _DynamicFormFieldState createState() => _DynamicFormFieldState();
}

class _DynamicFormFieldState extends State<DynamicFormField> {
  dynamic _fieldValue; // Variable para almacenar el valor del campo

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) {
      return Container(); // Vacio si no es visible
    }
    return Container(
      margin: EdgeInsets.all(10.0),
    child: Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
    ));
  }

  Widget _buildField(BuildContext context) {
    switch (widget.schema.fieldType.toLowerCase()) {
      case 'text':
      case 'string':
        return TextFormField(
          maxLines: null, // Allows for multiple lines
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: widget.schema.fieldDescription,
            hintStyle: TextStyle(color: Colors.blueGrey),
          ),
          readOnly: widget.schema.fieldReadonly ?? false,
          initialValue: widget.schema.fieldDefaultValue,
          onChanged: (value) {
            _fieldValue =
                value; // Almacenar el valor del campo en la variable local
            if (widget.onChanged != null) {
              widget.onChanged!(
                  _fieldValue); // Invocar la función de devolución de llamada
            }
          },
          validator: (value) => 
          _validateField(_fieldValue),
        );
      case 'number':
      case 'int':
      case 'int32':
      case 'int64':
        return TextFormField(
          decoration: InputDecoration(
            hintText: widget.schema.fieldDescription,
            hintStyle: TextStyle(color: Colors.blueGrey),
          ),
          readOnly: widget.schema.fieldReadonly ?? false,
          initialValue: widget.schema.fieldDefaultValue?.toString(),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          onChanged: (value) {
            _fieldValue = value;
            if (widget.onChanged != null) {
              widget.onChanged!(_fieldValue);
            }
          },
          validator: (value) => 
          _validateField(_fieldValue),
        );
      case 'date':
      case 'datetime':
        return InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: widget.schema.fieldDescription,
              hintStyle: TextStyle(color: Colors.blueGrey),
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
      case 'selection':
        var options = widget.schema.fieldValidations?['options'] as List<dynamic>?;

        _fieldValue = _fieldValue ?? widget.schema.fieldDefaultValue;

        bool isValueInOptions = options?.contains(_fieldValue) ?? false;
        if (!isValueInOptions && _fieldValue != null) {
          _fieldValue = null;
        }

        if (options != null && options.isNotEmpty) {
          return DropdownButtonFormField<String>(
            value: _fieldValue,
            decoration: InputDecoration(
              hintText: widget.schema.fieldDescription,
              hintStyle: TextStyle(color: Colors.blueGrey),
            ),
            onChanged: (String? newValue) {
              setState(() {
                _fieldValue = newValue;
                if (widget.onChanged != null) {
                  widget.onChanged!(_fieldValue);
                }
              });
            },
            items: options.map<DropdownMenuItem<String>>((dynamic value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        } else {
          return Text('No hay opciones disponibles',
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
              ));
        }
      case 'boolean':
      case 'checkbox':
        return CheckboxListTile(
          value: _fieldValue ?? widget.schema.fieldDefaultValue ?? false,
          onChanged: (bool? value) {
            setState(() {
              _fieldValue = value;
              if (widget.onChanged != null) {
                widget.onChanged!(_fieldValue.toString());
              }
            });
          },
        );
      default:
        return Text('Tipo de campo no soportado',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ));
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



  String? _validateField(dynamic value) {
  Map<String, dynamic>? fieldValidations = widget.schema.fieldValidations;
    
    if (fieldValidations != null && value != null && value.toString().isNotEmpty) {
          print(fieldValidations.toString());

          if (fieldValidations.containsKey('min_value') && (int.parse(value) < fieldValidations['min_value'])) 
            return "Error, valor mínimo = ${fieldValidations['min_value']} ";
          
          if (fieldValidations.containsKey('max_value') && (int.parse(value) > fieldValidations['max_value'])) {
            return "Error, valor máximo = ${fieldValidations['max_value']} ";
          }
          if (fieldValidations.containsKey('format')) {
              String pattern = widget.schema.fieldValidations?['format'];
              if (!RegExp(pattern).hasMatch(value)) return "Error, formato inadecuado";
          }
          if (fieldValidations.containsKey('min_length') && ((value.length) < fieldValidations['min_length'])) {
            return "Error, longitud mínima = ${fieldValidations['min_length']} ";
          }
          if (fieldValidations.containsKey('max_length') && ((value.length) > fieldValidations['max_length'])) {
            return "Error, longitud máxima = ${fieldValidations['max_length']} ";
          }

          
    }
  return null; // No validation errors
}
  


}
