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

import 'package:disaform/controller/form_controller.dart';
import 'package:disaform/controller/form_type_controller.dart';
import 'package:disaform/models/formFieldSchema.dart';
import 'package:disaform/models/formGroupSchema.dart';
import 'package:disaform/models/formItem.dart';
import 'package:disaform/models/formSchema.dart';
import 'package:disaform/widgets/dynamicWidget.dart';
import 'package:flutter/material.dart';

class FormularioScreen extends StatefulWidget {
  final int formularioId;
  final String formularioName;

  FormularioScreen({required this.formularioId, required this.formularioName});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final FormTypeController apiService = FormTypeController();
  final FormController apiService2 = FormController();

  late Future<FormSchema> _formSchemaFuture;
  late FormSchema _formSchema;
  int formTypeId = 0;
  late Map<int, dynamic> _fieldValues =
      {};

  @override
  void initState() {
    super.initState();
    _formSchemaFuture = apiService.getFormType(widget.formularioId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.formularioName}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendForm();
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: _formSchemaFuture,
          builder: (context, AsyncSnapshot<FormSchema> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              _formSchema = snapshot.data!;
              //return buildFormListView();
              return buildFormListView();
            }
          },
        ),
      ),
    );
  }

  void _sendForm() {
    List<Map<String, dynamic>> fields = _fieldValues.entries
        .map((e) => {"field_id": e.key, "field_value": e.value.toString()})
        .toList();
    Map<String, dynamic> body = {"form_fields": fields};

    body['form_type_id'] = _formSchema.formTypeId;
    body['title_field'] = _formSchema.titleField;

    FormItem form = FormItem.fromJson(body);
    if (validate_form(_formSchema, form) ) {
      apiService2.postForm(form);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Formulario enviado'),
            content: Text('El formulario se ha enviado exitosamente.'),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.pop(context); // Cerrar el diálogo
                  Navigator.pop(context); 
                  Navigator.pop(context); 
                },
              ),
            ],
          );
        },
      );
    }
  }

  bool validate_form(FormSchema schema, FormItem form) {
    for (FormFieldSchema field in schema.formFields) {
      if (field.fieldRequired && field.fieldDependentOn == null) {
        if (form.formFields
            .where((element) =>
                element.fieldId == field.fieldId && element.value != null && field.fieldDefaultValue != null)
            .isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('El campo ${field.fieldName} es requerido.'),
                actions: [
                  TextButton(
                    child: Text('Aceptar'),
                    onPressed: () {
                      Navigator.pop(context); // Cerrar el diálogo
                    },
                  ),
                ],
              );
            },
          );
          return false;
        }
      }
    }
    return true;
  }


Widget buildFormListView() {
  // Creamos un mapa para agrupar los campos por su grupo
  Map<String, List<FormFieldSchema>> groupedFields = {};
  List<FormGroupSchema>? formgroupSchemas = _formSchema.formGroups;
  
  // Iteramos sobre cada campo del esquema para agruparlos
  for (var field in _formSchema.formFields) {
    // Verificamos si el grupo ya existe en el mapa, si no existe lo creamos
    if (!groupedFields.containsKey(field.fieldGroup)) {
      groupedFields[field.fieldGroup] = [];
    }
    // Añadimos el campo al grupo correspondiente
    groupedFields[field.fieldGroup]!.add(field);
  }

  // Creamos una lista de widgets que contendrá los campos agrupados
  List<Widget> widgets = [];

  // Iteramos sobre los grupos y sus campos para generar los widgets correspondientes
  groupedFields.forEach((groupId, fields) {
    String groupName = '';
    // Encuentra el nombre del grupo correspondiente
    for (var groupSchema in formgroupSchemas!) {
      if (groupSchema.groupId == groupId) {
        groupName = groupSchema.groupName;
        break;
      }
    }
    
    // Agregamos un encabezado para el grupo si existe
    if (groupName.isNotEmpty) {
      widgets.add(
  Container(
    color: Colors.grey.withOpacity(0.05), // Color gris con opacidad 0.5
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        groupName,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.red[800],
        ),
      ),
    ),
  ),
);
    }
    
    // Agregamos los campos del grupo
    widgets.addAll(fields.map((field) {
      // Inicializa el valor por defecto en null o cualquier otro valor predeterminado adecuado
      var defaultValue = null;

      // Busca el valor correspondiente manualmente
      for (var item in _formSchema.formFields) {
        if (item.fieldId == field.fieldId) {
          defaultValue = item.fieldDefaultValue;
          break; // Salir del bucle una vez que se encuentra el valor
        }
      }
      field.fieldDefaultValue = defaultValue;
      return DynamicFormField(schema: field,
      isVisible:
              shouldShow(field), // Determina si el campo debe ser visible
          onChanged: (value) {
            //Así controlamos cuando se modifica un campo
            setState(() {
              _fieldValues[field.fieldId] = value;
            });
          },);
    }));
  });

  // Retornamos un ListView que contiene todos los widgets generados
  return ListView(
    children: widgets,
  );
}

/*formField
  Widget buildFormListView() {
    return ListView.builder(
      itemCount: _formSchema.formFields.length,
      itemBuilder: (context, index) {
        FormFieldSchema formField = _formSchema.formFields[index];

        return DynamicFormField(
          schema: formField,
          isVisible:
              shouldShow(formField), // Determina si el campo debe ser visible
          onChanged: (value) {
            //Así controlamos cuando se modifica un campo
            setState(() {
              _fieldValues[formField.fieldId] = value;
            });
          },
        );
      },
    );
  }
*/


  //Para dependencias de campos
  bool shouldShow(FormFieldSchema formField) {
    if (formField.fieldDependentOn != null) {
      int? dependentFieldId = formField.fieldDependentOn?.fieldId;
      var requiredValue = formField.fieldDependentOn?.value;

      return _fieldValues.containsKey(dependentFieldId) &&
          _fieldValues[dependentFieldId].toString() == requiredValue.toString();
    }
    return true;
  }
}
