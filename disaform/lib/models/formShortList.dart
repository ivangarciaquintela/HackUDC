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
