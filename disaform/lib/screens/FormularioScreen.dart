import 'package:flutter/material.dart';

// Definición de la nueva pantalla del formulario
class FormularioScreen extends StatelessWidget {
  final int formularioId;

  FormularioScreen({required this.formularioId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario $formularioId'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              // Aquí puedes agregar la lógica para enviar el formulario
              // Por ahora, solo imprime un mensaje en la consola
              print('Formulario $formularioId enviado');
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Este es el formulario $formularioId'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MainScreen(),
  ));
}

// Ejemplo de uso desde una pantalla principal
class MainScreen extends StatelessWidget {
  // Lista de formularios con descripciones
  final List<Map<String, String>> formularios = [
    {'nombre': 'Primer formulario', 'descripcion': 'Descripción del primer formulario'},
    {'nombre': 'Segundo formulario', 'descripcion': 'Descripción del segundo formulario'},
    {'nombre': 'Tercer formulario', 'descripcion': 'Descripción del tercer formulario'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Principal'),
      ),
      body: ListView.builder(
        itemCount: formularios.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(formularios[index]['nombre']!),
            subtitle: Text(formularios[index]['descripcion']!),
            onTap: () {
              _navigateToFormularioScreen(context, index + 1);
            },
          );
        },
      ),
    );
  }

  // Función para navegar a la pantalla del formulario
  void _navigateToFormularioScreen(BuildContext context, int formularioId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormularioScreen(formularioId: formularioId)),
    );
  }
}
