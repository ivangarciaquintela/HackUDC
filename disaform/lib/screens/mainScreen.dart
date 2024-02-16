import 'package:disaform/screens/createScreen.dart';
import 'package:disaform/screens/searchScreen.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(child : Text('DisaForm')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón de búsqueda
                _navigateToSearchScreen(context);
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.search), // Ícono
                  SizedBox(height: 10), // Espacio entre el ícono y la etiqueta
                  Text('Buscar'), // Etiqueta
                ],
              ),
            ),
            SizedBox(height: 20), // Separación entre los botones
            ElevatedButton(
              onPressed: () {
                _navigateToCreateScreen(context);
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.description), // Ícono
                  SizedBox(height: 10), // Espacio entre el ícono y la etiqueta
                  Center(child: Text('      Crear\nFormulario')), // Etiqueta
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCreateScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateScreen()),
    );
  }


  void _navigateToSearchScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchScreen()),
    );
  }
}
