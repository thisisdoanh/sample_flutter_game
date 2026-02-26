part of 'nfc_tap_bloc.dart';

@freezed
sealed class NfcTapEvent with _$NfcTapEvent {
  const factory NfcTapEvent.loadData() = _LoadData;
}