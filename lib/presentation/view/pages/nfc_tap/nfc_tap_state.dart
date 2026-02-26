part of 'nfc_tap_bloc.dart';

@freezed
abstract class NfcTapState extends BaseState with _$NfcTapState {
  const factory NfcTapState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    String? pageErrorMessage,
  }) = _NfcTapState;

  const NfcTapState._({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
  });
}