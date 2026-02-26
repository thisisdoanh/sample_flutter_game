part of 'qr_code_hunt_bloc.dart';

@freezed
abstract class QrCodeHuntState extends BaseState with _$QrCodeHuntState {
  const factory QrCodeHuntState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    String? pageErrorMessage,
  }) = _QrCodeHuntState;

  const QrCodeHuntState._({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
  });
}