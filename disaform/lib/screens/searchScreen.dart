import 'package:disaform/controller/form_controller.dart';
import 'package:disaform/models/formShortItem.dart';
import 'package:disaform/services/apiservice.dart';
import 'package:flutter/material.dart';



class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenPageState createState() => _SearchScreenPageState();
}

class _SearchScreenPageState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  final ApiService apiService = ApiService();
  late Future<List<FormShortItem>> formTypesFuture;

  void _search() {
    // Aquí puedes implementar la lógica de búsqueda, por ejemplo, buscar en una base de datos o una lista predefinida.
    setState(() {
      // En este ejemplo, simplemente agregamos elementos aleatorios a la lista de resultados.
      apiService.getAllForms().then((value) => print(value));
      _searchResults = List.generate(10, (index) => 'Resultado $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Búsqueda de Formularios'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _search,
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResults[index]),
                  //onTap: ,
                  // Aquí puedes agregar más elementos a tu ListTile según tus necesidades.
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}