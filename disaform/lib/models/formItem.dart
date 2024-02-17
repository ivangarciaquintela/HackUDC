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

import 'package:disaform/models/formField.dart';

class FormItem {
  final int formId;
  final int formTypeId;
  final String titleField;
  List<FormField> formFields = [];

  FormItem(
      {required this.formId,
      required this.formTypeId,
      required this.titleField,
      required this.formFields});

  factory FormItem.fromJson(Map<String, dynamic> json) {
    return FormItem(
      formId: json['form_id']  ?? 0,
      formTypeId: json['form_type_id'],
      titleField: json['title_field'],
      formFields: (json['form_fields'] as List? ?? []).map((item) => FormField.fromJson(item)).toList(),    );
  }

  Map<String, dynamic> toJson() {
    return {
      'form_id': formId.toString(),
      'form_type_id': formTypeId.toString(),
      'title_field': titleField.toString(),
      'form_fields': formFields.toString(),
    };
  }
}
