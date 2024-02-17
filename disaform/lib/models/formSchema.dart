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
import 'package:disaform/models/formGroupSchema.dart';

class FormSchema {
  final int formTypeId;
  final String formTypeName;
  final String?
      formTypeDescription; // Optional since not all forms might have a description
  final String titleField;
  final List<FormFieldSchema>
      formFields; // Assuming FormFieldSchema is defined elsewhere
  final List<FormGroupSchema>? formGroups; // List of group identifiers

  FormSchema({
    required this.formTypeId,
    required this.formTypeName,
    this.formTypeDescription,
    required this.titleField,
    required this.formFields,
    this.formGroups,
  });

  factory FormSchema.fromJson(Map<String, dynamic> json) {
    return FormSchema(
      formTypeId: json['form_type_id'],
      formTypeName: json['form_type_name'],
      formTypeDescription: json['form_type_description'],
      titleField: json['title_field']['field_description'],
      formFields: (json['form_fields'] as List)
          .map((item) => FormFieldSchema.fromJson(item))
          .toList(),
      formGroups: (json['form_groups'] as List? ?? [])
          .map((item) => FormGroupSchema.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'form_type_id': formTypeId,
      'form_type_name': formTypeName,
      'form_type_description': formTypeDescription,
      'title_field': titleField,
      'form_fields': formFields.map((field) => field.toJson()).toList(),
      'form_groups': formGroups,
    };
  }
  int getFormTypeId() {
    return formTypeId;
  }
}
