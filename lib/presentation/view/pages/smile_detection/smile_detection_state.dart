part of 'smile_detection_bloc.dart';

@freezed
abstract class SmileDetectionState extends BaseState with _$SmileDetectionState {
  const factory SmileDetectionState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    String? pageErrorMessage,
  }) = _SmileDetectionState;

  const SmileDetectionState._({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
  });
}