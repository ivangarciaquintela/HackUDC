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

import 'package:disaform/screens/createScreen.dart';
import 'package:disaform/screens/searchScreen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(''),
              flexibleSpace: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 5), // Padding vertical de 5
                  child: Image.asset(
                    'assets/disaform.png', // Ruta de la imagen desde los activos
                    height: 270, // Altura de la imagen
                    width: 270, // Ancho de la imagen
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 3,
                      width: 2000,
                    ), // Altura de la sombra
                  ),
                  Expanded(
                    child: Center(
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
                                SizedBox(
                                    height:
                                        10), // Espacio entre el ícono y la etiqueta
                                Text('Buscar'), // Etiqueta
                              ],
                            ),
                          ),
                          SizedBox(height: 50), // Separación entre los botones
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
                                SizedBox(
                                    height:
                                        10), // Espacio entre el ícono y la etiqueta
                                Center(
                                    child: Text(
                                        '      Crear\nFormulario')), // Etiqueta
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
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
