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

import 'package:disaform/models/formItem.dart';
import 'package:disaform/models/formShortItem.dart';
import 'package:disaform/models/formSchema.dart';
import 'package:disaform/models/formShortList.dart';
import 'package:disaform/models/formType.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String URI =
      'https://695f223f-0edb-42c1-a127-ed6674f679d8.mock.pstmn.io/';

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

  Future<void> postForm(FormItem formItem) async {
    Map<String, String> headers = {
      'mock': '1',
    };
    final response = await http.post(Uri.parse(URI + 'api/v1/forms'),
        headers: headers, body: formItem.toJson());

    if (response.statusCode == 201) {
      print('Post correcto');
    } else {
      throw Exception("Error al enviar el formulario");
    }
  }

  Future<List<FormShortItem>> getAllForms() async {
    Map<String, String> headers = {
      'Accept': 'application/json;charset=utf-8',
      'mock': '1',
    };
    final response =
        await http.get(Uri.parse(URI + 'api/v1/forms/'), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<FormShortItem> forms = FormShortList.fromJson(body).items;
      return forms;
    } else {
      throw Exception('Error al cargar el formulario');
    }
  }
}
