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
