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
  bool _isSearching = false;

  void _search() {
    // Aquí puedes implementar la lógica de búsqueda, por ejemplo, buscar en una base de datos o una lista predefinida.
    setState(() {
      //_searchResults = formShorts.where((formShortItem) {
      //return formShortItem.titleField.toLowerCase().contains(query.toLowerCase());
    //}).toList();
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
      title: _isSearching
        ? TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Buscar por id...',
            border: InputBorder.none,
          ),
          onSubmitted: (_) => _search(),
        )
        : Text('Búsqueda de Formularios'),
      actions: [
        IconButton(
          icon: Icon(Icons.filter_alt),
          onPressed: () {
            _filterByTitleField();
          },
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: _isSearching
            ? IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                  });
                },
              )
            : IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _isSearching = true;
                  });
                },
              ),
        ),
      ],
    ),
    body: Column(
      children: [
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
void _filterByTitleField() {
    setState(() {
  });
}
  
}
