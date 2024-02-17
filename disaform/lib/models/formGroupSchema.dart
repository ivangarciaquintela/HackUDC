class FormGroupSchema {
  final String groupId;
  final String groupName;
  final String groupDescription;
  final int groupOrder;

  FormGroupSchema({
    required this.groupId,
    required this.groupName,
    required this.groupDescription,
    required this.groupOrder,
  });

  factory FormGroupSchema.fromJson(Map<String, dynamic> json) {
    return FormGroupSchema(
      groupId: json['group_id'] ?? '',
      groupName: json['group_name'] ?? '',
      groupDescription: json['group_description'] ?? '',
      groupOrder: json['group_order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'group_name': groupName,
      'group_description': groupDescription,
      'group_order': groupOrder,
    };
  }
}
