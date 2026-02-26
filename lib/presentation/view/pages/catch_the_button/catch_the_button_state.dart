part of 'catch_the_button_bloc.dart';

@freezed
abstract class CatchTheButtonState extends BaseState with _$CatchTheButtonState {
  const factory CatchTheButtonState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    String? pageErrorMessage,
  }) = _CatchTheButtonState;

  const CatchTheButtonState._({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
  });
}