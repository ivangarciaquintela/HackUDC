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
      //'field_dependent_on': fieldDependentOn,
      'field_validations': fieldValidations,
    };
  }
  
}
