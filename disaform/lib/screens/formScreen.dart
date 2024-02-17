
import 'package:disaform/services/apiservice.dart';
import 'package:disaform/widgets/dynamicWidget.dart';
import 'package:flutter/material.dart';

class FormularioScreen extends StatelessWidget {
  final int formularioId;

  FormularioScreen({required this.formularioId});

  @override
  Widget build(BuildContext context) {
    //obtenemos el formulario especifico
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
