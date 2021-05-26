// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Entity _$_$_EntityFromJson(Map<String, dynamic> json) {
  return $checkedNew(r'_$_Entity', json, () {
    final val = _$_Entity(
      id: $checkedConvert(json, 'id', (v) => v as int),
      title: $checkedConvert(json, 'title', (v) => v as String),
      description: $checkedConvert(json, 'description', (v) => v as String?),
    );
    return val;
  });
}

Map<String, dynamic> _$_$_EntityToJson(_$_Entity instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };
