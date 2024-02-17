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

