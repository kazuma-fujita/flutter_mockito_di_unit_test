import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity.freezed.dart';
part 'entity.g.dart';

@freezed
class Entity with _$Entity {
  factory Entity({
    required int id,
    required String title,
    String? description,
  }) = _Entity;

  factory Entity.fromJson(Map<String, Object> json) => _$EntityFromJson(json);
}
