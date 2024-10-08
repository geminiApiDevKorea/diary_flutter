import 'package:diary_flutter/common/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history.g.dart';

@JsonSerializable()
class History {
  final Role role;
  final String message;

  @override
  String toString() {
    return 'History(role: $role, message: $message)';
  }

  Map<String, dynamic> toJson() => _$HistoryToJson(this);
  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);
  History({required this.role, required this.message});
}
