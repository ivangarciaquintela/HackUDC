import 'package:disaform/models/formFieldSchema.dart';

class FormSchema {
  final String formTypeId;
  final String formTypeName;
  final String?
      formTypeDescription; // Optional since not all forms might have a description
  final String titleField;
  final List<FormFieldSchema>
      formFields; // Assuming FormFieldSchema is defined elsewhere
  final List<String> formGroups; // List of group identifiers

  FormSchema({
    required this.formTypeId,
    required this.formTypeName,
    this.formTypeDescription,
    required this.titleField,
    required this.formFields,
    required this.formGroups,
  });

  factory FormSchema.fromJson(Map<String, dynamic> json) {
    return FormSchema(
      formTypeId: json['form_type_id'],
      formTypeName: json['form_type_name'],
      formTypeDescription: json['form_type_description'],
      titleField: json['title_field'],
      formFields: (json['form_fields'] as List)
          .map((item) => FormFieldSchema.fromJson(item))
          .toList(),
      formGroups: List<String>.from(json['form_groups']),
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