import 'package:disaform/models/formSchema.dart';
import 'package:disaform/models/formType.dart';
import 'package:disaform/services/apiservice.dart';

class FormTypeController {
  ApiService apiService = ApiService();

  Future<List<FormType>> getFormTypes() async {
    return await apiService.getFormTypes();
  }
  Future<FormSchema> getFormType(int id) async {
    return await apiService.getFormType(id);
  }
}
