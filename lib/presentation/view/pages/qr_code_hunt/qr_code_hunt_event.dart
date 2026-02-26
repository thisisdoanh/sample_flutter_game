part of 'qr_code_hunt_bloc.dart';

@freezed
sealed class QrCodeHuntEvent with _$QrCodeHuntEvent {
  const factory QrCodeHuntEvent.loadData() = _LoadData;
}