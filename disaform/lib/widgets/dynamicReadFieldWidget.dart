import 'package:disaform/models/formFieldSchema.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DynamicReadFieldDisplay extends StatefulWidget {
  final FormFieldSchema schema;

  DynamicReadFieldDisplay({required this.schema});

  @override
  _DynamicReadFieldDisplayState createState() =>
      _DynamicReadFieldDisplayState();
}

class _DynamicReadFieldDisplayState extends State<DynamicReadFieldDisplay> {
  @override
  Widget build(BuildContext context) {
    if (widget.schema.fieldType.toLowerCase() != 'boolean' &&
        widget.schema.fieldType.toLowerCase() != 'checkbox') {
      if (widget.schema.fieldDefaultValue == null ||
          (widget.schema.fieldDefaultValue is String &&
              widget.schema.fieldDefaultValue!.isEmpty)) {
        return Container(); // Devuelve un contenedor vacío si el valor es null o ''
      }
    }
    return Container(
      margin: EdgeInsets.all(25.0),
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
    switch (widget.schema.fieldType.toLowerCase()) {
      case 'text':
      case 'string':
        return Text(
          widget.schema.fieldDefaultValue ?? "No disponible",
          style: TextStyle(color: Colors.blueGrey),
        );
      case 'number':
      case 'int':
      case 'int32':
      case 'int64':
        return Text(
          widget.schema.fieldDefaultValue?.toString() ?? "No disponible",
          style: TextStyle(color: Colors.blueGrey),
        );
      case 'date':
      case 'datetime':
        return Text(
          widget.schema.fieldDefaultValue != null
              ? DateFormat.yMMMd()
                  .format(DateTime.parse(widget.schema.fieldDefaultValue))
              : "No disponible",
          style: TextStyle(color: Colors.blueGrey),
        );
      case 'select':
      case 'selection':
        return Text(widget.schema.fieldDefaultValue != null
            ? widget.schema.fieldDefaultValue
            : "No disponible");
      case 'boolean':
      case 'checkbox':
        return widget.schema.fieldDefaultValue ?? false
            ? Icon(Icons.check_box, color: Colors.green)
            : Icon(Icons.check_box_outline_blank, color: Colors.red);
      default:
        return Text(
          'Tipo de campo no soportado',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
          ),
        );
    }
  }
}
