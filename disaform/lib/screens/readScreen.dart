import 'package:disaform/controller/form_controller.dart';
import 'package:disaform/controller/form_type_controller.dart';
import 'package:disaform/models/formField.dart';
import 'package:disaform/models/formFieldSchema.dart';
import 'package:disaform/models/formItem.dart';
import 'package:disaform/models/formSchema.dart';
import 'package:disaform/models/formShortItem.dart';
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              print('Formulario ${widget.formShortItem.formId} enviado');
            },
          ),
        ],
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

  void _sendForm() {
    // Imprime los valores almacenados en el mapa
    print('Valores del formulario:');
    _fieldValues.forEach((key, value) {
      print('$key: $value');
    });
    // Aquí puedes realizar otras acciones con los valores del formulario, como enviarlos a través de una solicitud HTTP, etc.
  }

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
        return DynamicFormField(
          schema: formFieldSchema,
          onChanged: (value) {
            // Almacena el valor del campo en el mapa
            _fieldValues[formFieldSchema.fieldId] = value;
          },
        );
      },
    );
  }
}
