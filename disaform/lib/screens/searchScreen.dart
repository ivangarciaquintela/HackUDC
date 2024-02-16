import 'package:flutter/material.dart';



class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenPageState createState() => _SearchScreenPageState();
}

class _SearchScreenPageState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  void _search() {
    // Aquí puedes implementar la lógica de búsqueda, por ejemplo, buscar en una base de datos o una lista predefinida.
    setState(() {
      // En este ejemplo, simplemente agregamos elementos aleatorios a la lista de resultados.
      _searchResults = List.generate(10, (index) => 'Resultado $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Búsqueda'),
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
                      labelText: 'Buscar',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _search,
                  child: Text('Buscar'),
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