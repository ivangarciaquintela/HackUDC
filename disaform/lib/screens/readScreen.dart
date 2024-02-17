import 'package:disaform/controller/form_controller.dart';
import 'package:disaform/controller/form_type_controller.dart';
import 'package:disaform/models/formField.dart';
import 'package:disaform/models/formFieldSchema.dart';

import 'package:disaform/models/formGroupSchema.dart';
import 'package:disaform/models/formItem.dart';
import 'package:disaform/models/formSchema.dart';
import 'package:disaform/models/formShortItem.dart';
import 'package:disaform/widgets/dynamicReadFieldWidget.dart';
import 'package:disaform/widgets/dynamicWidget.dart';
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
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            groupName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
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
/*
  Widget buildFormListView(FormItem formItem) {
    return ListView.builder(
      itemCount: _formSchema.formFields.length,
      itemBuilder: (context, index) {
        final formFieldSchema = _formSchema.formFields[index];

        // Inicializa el valor por defecto en null o cualquier otro valor predeterminado adecuado
        var defaultValue = null;

        // Busca el valor correspondiente manualmente
        for (var item in formItem.formFields) {
          if (item.fieldId == formFieldSchema.fieldId) {
            defaultValue = item.value;
            break; // Salir del bucle una vez que se encuentra el valor
          }
        }
        formFieldSchema.fieldDefaultValue = defaultValue;
        return DynamicReadFieldDisplay(schema: formFieldSchema);
      },
    );
  }
*/
/*
Widget buildFormListView(FormItem formItem) {
  // Creamos un mapa para agrupar los campos por su grupo
  Map<String, List<FormFieldSchema>> groupedFields = {};

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
  groupedFields.forEach((group, fields) {
    // Agregamos un encabezado para el grupo si existe
    if (group.isNotEmpty) {
      widgets.add(
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            group,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent
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
*/
/*
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
  groupedFields.forEach((groupName, fields) {
    
    // Agregamos un encabezado para el grupo si existe
    if (groupName.isNotEmpty) {
      widgets.add(
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            groupName, // Usamos el group_name en lugar del group_id
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
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

*/

}
