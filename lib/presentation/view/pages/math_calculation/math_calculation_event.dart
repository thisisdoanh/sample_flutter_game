part of 'math_calculation_bloc.dart';

@freezed
sealed class MathCalculationEvent with _$MathCalculationEvent {
  const factory MathCalculationEvent.loadData() = _LoadData;
}