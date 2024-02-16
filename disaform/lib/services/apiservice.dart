import 'package:disaform/models/formType.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String URI =
      'https://131b6ea8-87b5-4141-969d-29d7f4ad6b58.mock.pstmn.io/';
  Future<List<FormType>> getFormTypes() async {
    final response = await http.get(Uri.parse(URI + 'api/v1/formTypes'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<FormType> formTypes =
          body.map((dynamic item) => FormType.fromJson(item)).toList();
      return formTypes;
    } else {
      throw Exception('Error al cargar los formularios');
    }
  }
}
