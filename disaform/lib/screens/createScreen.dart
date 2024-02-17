import 'package:disaform/screens/formScreen.dart';
import 'package:flutter/material.dart';
import 'package:disaform/models/formType.dart'; // Asegúrate de que la ruta sea correcta
import 'package:disaform/services/apiservice.dart'; // Asegúrate de que la ruta sea correcta

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final ApiService apiService = ApiService();
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
        title: new Center(child: new Text('Selección de formulario', textAlign: TextAlign.center)),
       
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
                  onTap: () {
                    _navigateToFormularioScreen(
                        context, formTypes[index].formTypeId,formTypes[index].formTypeName);
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

  void _navigateToFormularioScreen(BuildContext context, int formularioId, String formularioName) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FormularioScreen(formularioId: formularioId, formularioName:  formularioName)),
    );
  }
}
