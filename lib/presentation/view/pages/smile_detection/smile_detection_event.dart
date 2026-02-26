part of 'smile_detection_bloc.dart';

@freezed
sealed class SmileDetectionEvent with _$SmileDetectionEvent {
  const factory SmileDetectionEvent.loadData() = _LoadData;
}