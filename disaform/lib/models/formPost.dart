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

import 'package:disaform/models/formFieldSchema.dart';

class FormPost {
  int form_id;
  int form_type_id;
  String title_field;
  List<FormFieldSchema> form_fields;

  FormPost({
    required this.form_id,
    required this.form_type_id,
    required this.title_field,
    required this.form_fields,
    });

    factory FormPost.fromJson(Map<String, dynamic> json) {
      return FormPost(
        form_id: json['form_id'],
        form_type_id: json['form_type_id'],
        title_field: json['title_field'],
        form_fields: List<FormFieldSchema>.from(
            json['form_fields'].map((item) => FormFieldSchema.fromJson(item))),
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'form_id': form_id,
        'form_type_id': form_type_id,
        'title_field': title_field,
        'form_fields': form_fields.map((item) => item.toJson()).toList(),
      };
    }

}

