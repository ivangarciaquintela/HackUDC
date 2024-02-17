import 'package:disaform/models/formItem.dart';
import 'package:disaform/models/formShortItem.dart';
import 'package:disaform/services/apiservice.dart';

class FormController {
  ApiService apiService = ApiService();

  Future<FormItem> getForm(int formId) async {
    return await apiService.getForm(formId);
  }
  Future<List<FormShortItem>> getAllForms() async {
    return await apiService.getAllForms();
  }
}
