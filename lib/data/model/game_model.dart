import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:template_bloc/data/converter/color_converter.dart';
import 'package:template_bloc/data/converter/icon_converter.dart';
import 'package:template_bloc/domain/enums/game_route.dart';

part 'game_model.g.dart';

@JsonSerializable()
class GameModel {
  const GameModel({
    required this.name,
    required this.description,
    required this.icon,
    required this.cardColor,
    required this.shadowColor,
    required this.targetRoute,
  });

  /// Connect the generated [_$GameModelFromJson] function to the `fromJson`
  /// factory.
  factory GameModel.fromJson(Map<String, dynamic> json) => _$GameModelFromJson(json);

  final String name;
  final String description;

  @IconDataConverter()
  final IconData icon;

  @ColorConverter()
  final Color cardColor;

  @ColorConverter()
  final Color shadowColor;

  final GameRoute targetRoute;

  /// Connect the generated [_$GameModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GameModelToJson(this);
}
