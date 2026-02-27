import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class IconDataConverter implements JsonConverter<IconData, int> {
  const IconDataConverter();

  @override
  IconData fromJson(int codePoint) {
    return IconData(
      codePoint,
      fontFamily: 'MaterialIcons',
    );
  }

  @override
  int toJson(IconData icon) {
    return icon.codePoint;
  }
}