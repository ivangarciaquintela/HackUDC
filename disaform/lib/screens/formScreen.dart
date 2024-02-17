
import 'package:disaform/controller/form_controller.dart';
import 'package:disaform/controller/form_type_controller.dart';
import 'package:disaform/models/formSchema.dart';
import 'package:disaform/services/apiservice.dart';
import 'package:disaform/widgets/dynamicWidget.dart';
import 'package:flutter/material.dart';

class FormularioScreen extends StatelessWidget {
  final int formularioId;
  final FormTypeController apiService = FormTypeController();

  FormularioScreen({required this.formularioId});

  @override
  Widget build(BuildContext context) {
    //obtenemos el formulario especifico
    Future<FormSchema> f =  apiService.getFormType(formularioId);
    FormSchema fs  ;
    f.then((value) => print(value.formTypeId));
    var a = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario $formularioId'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              print('Formulario $formularioId enviado');
            },
          ),
        ],
      ),
      body: Center(
        //child: Text('Este es el formulario $formularioId'),
        //child: DynamicFormField(schema: ,)
      ),
    );
  }
}
