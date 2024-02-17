import 'package:disaform/models/formFieldSchema.dart';
import 'package:disaform/models/formGroupSchema.dart';
import 'package:flutter/material.dart';

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
      formGroups: (json['form_group'] as List? ?? [])
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
}
