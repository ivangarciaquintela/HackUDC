class FormType {
  final int formTypeId;
  final String formTypeName;

  FormType({
    required this.formTypeId,
    required this.formTypeName,
  });

  factory FormType.fromJson(Map<String, dynamic> json) {
    return FormType(
      formTypeId: json['form_type_id'],
      formTypeName: json['form_type_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'form_type_id': formTypeId,
      'form_type_name': formTypeName,
    };
  }
}
