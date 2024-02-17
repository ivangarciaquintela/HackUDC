import 'package:disaform/controller/form_controller.dart';
import 'package:disaform/controller/form_type_controller.dart';
import 'package:disaform/models/formFieldSchema.dart';
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
        title: Text('${widget.formularioName}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendForm();
              print('Formulario : ${widget.formularioName} enviado');
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
      Map<String, dynamic> body = _fieldValues.map((key, value) => MapEntry(key.toString(), value));
      body['form_id'] = widget.formularioId;
      body['form_type_id'] = _formSchema.formTypeId;
      body['title_field'] = _formSchema.titleField;
      FormItem form = FormItem.fromJson(body);
      //validate?
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
                  Navigator.pop(context); // Volver a la pantalla principal
                  Navigator.pop(context); //volver volver
                },
              ),
            ],
          );
        },
      );
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
