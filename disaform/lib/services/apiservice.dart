import 'package:disaform/models/formItem.dart';
import 'package:disaform/models/formSchema.dart';
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

  Future<FormSchema> getFormType(int id) async {
    final response =
        await http.get(Uri.parse(URI + 'api/v1/formTypes/' + id.toString()));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      FormSchema form = FormSchema.fromJson(body);
      return form;
    } else {
      throw Exception('Error al cargar los formularios');
    }
  }

  Future<FormItem> getForm(int formId) async {
    final response =
        await http.get(Uri.parse(URI + 'api/v1/forms/' + formId.toString()));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      FormItem form = FormItem.fromJson(body);
      return form;
    } else {
      throw Exception('Error al cargar el formulario');
    }
  }
}
