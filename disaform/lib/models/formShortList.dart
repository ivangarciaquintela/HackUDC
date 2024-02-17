import 'package:disaform/models/formShortItem.dart';

class FormShortList {
  List<FormShortItem> items;

  FormShortList({required this.items});

factory FormShortList.fromJson(List<dynamic> json) {
    List<FormShortItem> formShortItems = List<FormShortItem>.from(
        json.map((item) => FormShortItem.fromJson(item)));
    return FormShortList(items: formShortItems);
}


  List<Map<String, dynamic>> toJson() {
    return items.map((item) => item.toJson()).toList();
  }
}
