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

class FormFieldSchema {
  final int fieldId;
  final String fieldName;
  final String fieldType;
  final int fieldOrder;
  final bool fieldRequired;
  final String?
      fieldDescription; // Optional since not all fields might have a description
  final bool? fieldReadonly;
  dynamic
      fieldDefaultValue; // dynamic to accommodate different types of default values
  final String fieldGroup;
  final FormField?
      fieldDependentOn; // Optional as not all fields might have dependencies
  final Map<String, dynamic>?
      fieldValidations; // dynamic to accommodate different types of validations or options

  FormFieldSchema({
    required this.fieldId,
    required this.fieldName,
    required this.fieldType,
    required this.fieldOrder,
    required this.fieldRequired,
    this.fieldDescription,
    required this.fieldReadonly,
    this.fieldDefaultValue,
    required this.fieldGroup,
    this.fieldDependentOn,
    this.fieldValidations,
  });

  factory FormFieldSchema.fromJson(Map<String, dynamic> json) {
    return FormFieldSchema(
      fieldId: json['field_id'],
      fieldName: json['field_name'],
      fieldType: json['field_type'],
      fieldOrder: json['field_order'],
      fieldRequired: json['field_required'],
      fieldDescription: json['field_description'],
      fieldReadonly: json['field_readonly'],
      fieldDefaultValue: json['field_default_value'],
      fieldGroup: json['field_group'] ?? "",
      fieldDependentOn: json['field_dependent_on'] != null ? FormField(fieldId: json['field_dependent_on']['field_id'], value: json['field_dependent_on']['field_value']) : null,
      fieldValidations: json['field_validations'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'field_id': fieldId,
      'field_name': fieldName,
      'field_type': fieldType,
      'field_order': fieldOrder,
      'field_required': fieldRequired,
      'field_description': fieldDescription,
      'field_readonly': fieldReadonly,
      'field_default_value': fieldDefaultValue,
      'field_group': fieldGroup,
      'field_dependent_on': fieldDependentOn,
      'field_validations': fieldValidations,
    };
  }
  
}
