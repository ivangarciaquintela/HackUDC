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
