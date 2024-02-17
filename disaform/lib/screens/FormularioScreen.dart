import 'package:disaform/controller/form_type_controller.dart';
import 'package:flutter/material.dart';
import 'package:disaform/models/formType.dart'; // Asegúrate de que la ruta sea correcta
import 'package:disaform/services/apiservice.dart'; // Asegúrate de que la ruta sea correcta

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

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FormTypeController apiService = FormTypeController();
  late Future<List<FormType>> formTypesFuture;

  @override
  void initState() {
    super.initState();
    formTypesFuture = apiService.getFormTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Principal'),
      ),
      body: FutureBuilder<List<FormType>>(
        future: formTypesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<FormType> formTypes = snapshot.data!;
            return ListView.builder(
              itemCount: formTypes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(formTypes[index].formTypeName),
                  subtitle: Text(formTypes[index].formTypeId.toString()),
                  onTap: () {
                    _navigateToFormularioScreen(
                        context, formTypes[index].formTypeId);
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No hay datos disponibles'));
          }
        },
      ),
    );
  }

  void _navigateToFormularioScreen(BuildContext context, int formularioId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FormularioScreen(formularioId: formularioId)),
    );
  }
}
