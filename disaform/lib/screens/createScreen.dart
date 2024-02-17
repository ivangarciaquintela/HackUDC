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

import 'package:disaform/screens/formScreen.dart';
import 'package:flutter/material.dart';
import 'package:disaform/models/formType.dart'; 
import 'package:disaform/services/apiservice.dart'; 
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
