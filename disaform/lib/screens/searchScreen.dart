import 'package:disaform/screens/readScreen.dart';
import 'package:flutter/material.dart';
import 'package:disaform/models/formShortItem.dart';
import 'package:disaform/controller/form_controller.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenPageState createState() => _SearchScreenPageState();
}

class _SearchScreenPageState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<FormShortItem> _searchResults = [];
  final FormController formController = FormController();
  late Future<List<FormShortItem>> _formsFuture;
  bool _isSearching = false;

  void _search(String query) {
    if (!_isSearching) return;
    _formsFuture.then((forms) {
      setState(() {
        _searchResults = forms.where((form) {
          return form.titleField.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _formsFuture = formController.getAllForms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar por título...',
                  border: InputBorder.none,
                ),
                onChanged: _search,
              )
            : Text('Búsqueda de Formularios'),
        actions: [
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
              future: _isSearching
                  ? Future.value(_searchResults)
                  : _formsFuture, // Usa resultados de búsqueda o lista completa
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<FormShortItem> forms = snapshot.data!;
                  return ListView.builder(
                    itemCount: forms.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(forms[index].titleField),
                        onTap: () =>
                            _navigateToReadScreen(context, forms[index]),
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
