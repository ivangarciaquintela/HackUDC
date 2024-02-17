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
