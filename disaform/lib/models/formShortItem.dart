class FormShortItem {
  final int formId;
  final int formTypeId;
  final String titleField;

  FormShortItem(
      {required this.formId,
      required this.formTypeId,
      required this.titleField});

  factory FormShortItem.fromJson(Map<String, dynamic> json) {
    return FormShortItem(
      formId: json['form_id'],
      formTypeId: json['form_type_id'],
      titleField: json['title_field'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'form_id': formId,
      'form_type_id': formTypeId,
      'title_field': titleField,
    };
  }
}
