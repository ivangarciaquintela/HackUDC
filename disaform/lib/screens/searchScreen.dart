import 'package:disaform/screens/readScreen.dart';
import 'package:flutter/material.dart';
import 'package:disaform/models/formShortItem.dart';
import 'package:disaform/controller/form_controller.dart';
import 'package:disaform/controller/form_type_controller.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenPageState createState() => _SearchScreenPageState();
}

class _SearchScreenPageState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<FormShortItem> _allForms = [];
  List<FormShortItem> _filteredForms = [];
  Map<int, bool> _selectedFormTypes = {};
  final FormController formController = FormController();
  bool _isSearching = false;
  String? _selectedFormTypeName;
  bool _isLoading = true;

  void _search(String query) {
    final results = _isSearching
        ? _allForms.where((form) {
            return form.titleField.toLowerCase().contains(query.toLowerCase());
          }).toList()
        : _allForms;

    setState(() {
      _filteredForms = results;
    });
  }

  void _filterForms() {
    setState(() {
      _filteredForms = _allForms.where((form) {
        return _selectedFormTypes[form.formTypeId] ?? false;
      }).toList();
    });
  }

  Future<void> _showFilterDialog() async {
    final formTypes = await FormTypeController().getFormTypes();
    if (_selectedFormTypes.isEmpty) {
      for (var type in formTypes) {
        _selectedFormTypes[type.formTypeId] = true;
      }
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text('Filtrar por Tipo de Formulario'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: formTypes.map((formType) {
                    return CheckboxListTile(
                      value: _selectedFormTypes[formType.formTypeId],
                      title: Text(formType.formTypeName),
                      onChanged: (bool? value) {
                        setStateDialog(() {
                          _selectedFormTypes[formType.formTypeId] = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text('Filtrar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _filterForms();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    formController.getAllForms().then((forms) {
      setState(() {
        _allForms = forms;
        _filteredForms = forms;
        _isLoading = false;
      });
    });
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
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _search('');
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (_selectedFormTypeName != null)
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Chip(
                      label: Text('Filtrado por: $_selectedFormTypeName'),
                      onDeleted: () {
                        _filterForms();
                      },
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredForms.length,
                    itemBuilder: (context, index) {
                      final form = _filteredForms[index];
                      return ListTile(
                        title: Text(form.titleField),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ReadScreen(formShortItem: form)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class FormType {
  final int formTypeId;
  final String formTypeName;

  FormType({required this.formTypeId, required this.formTypeName});
}
