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
import 'package:disaform/models/formShortItem.dart';
import 'package:disaform/widgets/dynamicReadFieldWidget.dart';
import 'package:flutter/material.dart';

class ReadScreen extends StatefulWidget {
  final FormShortItem formShortItem;

  ReadScreen({required this.formShortItem});

  @override
  State<ReadScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<ReadScreen> {
  final FormTypeController apiService = FormTypeController();
  final FormController formController = FormController();
  late Future<FormSchema> _formSchemaFuture;
  late Future<FormItem> _formItemFuture;
  late FormSchema _formSchema;
  late Map<int, dynamic> _fieldValues =
      {}; // Mapa para almacenar los valores de los campos

  @override
  void initState() {
    super.initState();
    _formSchemaFuture = apiService.getFormType(widget.formShortItem.formTypeId);
    _formItemFuture = formController.getForm(widget.formShortItem.formId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario ${widget.formShortItem.titleField}'),
      ),
      body: Center(
        child: FutureBuilder(
          future: Future.wait([_formSchemaFuture, _formItemFuture]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              _formSchema = snapshot.data![0];
              FormItem formItem = snapshot.data![1];
              return buildFormListView(formItem);
            }
          },
        ),
      ),
    );
  }

Widget buildFormListView(FormItem formItem) {
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
      for (var item in formItem.formFields) {
        if (item.fieldId == field.fieldId) {
          defaultValue = item.value;
          break; // Salir del bucle una vez que se encuentra el valor
        }
      }
      field.fieldDefaultValue = defaultValue;
      return DynamicReadFieldDisplay(schema: field);
    }));
  });

  // Retornamos un ListView que contiene todos los widgets generados
  return ListView(
    children: widgets,
  );
}

}
