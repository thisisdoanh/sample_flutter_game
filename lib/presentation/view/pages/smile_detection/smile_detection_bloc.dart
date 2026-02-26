import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:template_bloc/presentation/base/base_bloc.dart';
import 'package:template_bloc/presentation/base/base_state.dart';
import 'package:template_bloc/presentation/base/page_status.dart';
import 'package:template_bloc/shared/common/error_converter.dart';

part 'smile_detection_bloc.freezed.dart';
part 'smile_detection_event.dart';
part 'smile_detection_state.dart';

@injectable
class SmileDetectionBloc extends BaseBloc<SmileDetectionEvent, SmileDetectionState> {
  SmileDetectionBloc() : super(const SmileDetectionState()) {
    on<SmileDetectionEvent>((event, emit) async {
        try {
          switch(event) {
            case _LoadData():
              _handleEventLoadData(emit, event);
              break;
          }
        } catch(e,s) {
            handleError(emit, ErrorConverter.convert(e, s));
        }
    });
  }

  Future<void> _handleEventLoadData(Emitter<SmileDetectionState> emit, _LoadData event) async {}
}