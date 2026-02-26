part of 'math_calculation_bloc.dart';

@freezed
abstract class MathCalculationState extends BaseState with _$MathCalculationState {
  const factory MathCalculationState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    String? pageErrorMessage,
  }) = _MathCalculationState;

  const MathCalculationState._({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
  });
}