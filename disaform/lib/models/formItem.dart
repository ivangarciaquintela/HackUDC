import 'package:disaform/models/formField.dart';

class FormItem {
  final int formId;
  final int formTypeId;
  final String titleField;
  final List<FormField> formFields;

  FormItem(
      {required this.formId,
      required this.formTypeId,
      required this.titleField,
      required this.formFields});

  factory FormItem.fromJson(Map<String, dynamic> json) {
    return FormItem(
      formId: json['form_id'],
      formTypeId: json['form_type_id'],
      titleField: json['title_field'],
      formFields: (json['form_fields'] as List)
          .map((i) => FormField.fromJson(i))
          .toList(),
    );
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
