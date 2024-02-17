import 'package:disaform/controller/form_controller.dart';
import 'package:disaform/controller/form_type_controller.dart';
import 'package:disaform/models/formShortItem.dart';
import 'package:disaform/screens/readScreen.dart';
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
  final FormController formController = FormController();
  late Future<List<FormShortItem>> formTypesFuture;
  late Future<List<FormShortItem>> formShortsFuture;
  void _search() {
    // Aquí puedes implementar la lógica de búsqueda, por ejemplo, buscar en una base de datos o una lista predefinida.
    setState(() {
      // En este ejemplo, simplemente agregamos elementos aleatorios a la lista de resultados.
      apiService.getAllForms().then((value) => print(value));
      _searchResults = List.generate(10, (index) => 'Resultado $index');
    });
  }

  @override
  void initState() {
    super.initState();
    formShortsFuture = formController.getAllForms();
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
            child: FutureBuilder<List<FormShortItem>>(
              future: formShortsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<FormShortItem> formShorts = snapshot.data!;
                  return ListView.builder(
                    itemCount: formShorts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(formShorts[index].titleField),
                        onTap: () {
                          _navigateToReadScreen(context, formShorts[index]);
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No hay datos disponibles'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToReadScreen(
      BuildContext context, FormShortItem formShortItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ReadScreen(formShortItem: formShortItem)),
    );
  }
}
