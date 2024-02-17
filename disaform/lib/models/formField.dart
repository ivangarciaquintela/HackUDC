class FormField {
  final int fieldId;
  final dynamic value;

  FormField({required this.fieldId, required this.value});

  factory FormField.fromJson(Map<String, dynamic> json) {
    return FormField(
      fieldId: json['field_id'],
      value: json['field_value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'field_id': fieldId, 'field_value': value};
  }
}
