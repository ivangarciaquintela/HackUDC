import 'package:disaform/controller/form_type_controller.dart';
import 'package:disaform/models/formFieldSchema.dart';
import 'package:disaform/models/formSchema.dart';
import 'package:disaform/widgets/dynamicWidget.dart';
import 'package:flutter/material.dart';

class FormularioScreen extends StatefulWidget {
  final int formularioId;

  FormularioScreen({required this.formularioId});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final FormTypeController apiService = FormTypeController();
  late Future<FormSchema> _formSchemaFuture;
  late FormSchema _formSchema;
  late Map<int, dynamic> _fieldValues = {}; // Mapa para almacenar los valores de los campos

  
  @override
  void initState() {
    super.initState();
    _formSchemaFuture = apiService.getFormType(widget.formularioId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario ${widget.formularioId}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              print('Formulario ${widget.formularioId} enviado');
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
              return buildFormListView();
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

  Widget buildFormListView() {
    return ListView.builder(
      itemCount: _formSchema.formFields.length,
      itemBuilder: (context, index) {
        FormFieldSchema formField = _formSchema.formFields[index];
        
        return DynamicFormField(
          schema: formField,
          onChanged: (value) {
            // Almacena el valor del campo en el mapa
            _fieldValues[formField.fieldId] = value;
          },
        );
      },
    );
  }
}
