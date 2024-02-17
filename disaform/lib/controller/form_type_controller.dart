/*
 * Autores: Anxo Castro Alonso, Ivan García Quintela, Mateo Amado Ares
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

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
