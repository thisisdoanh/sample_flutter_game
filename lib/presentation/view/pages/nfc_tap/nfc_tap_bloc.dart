import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:template_bloc/presentation/base/base_bloc.dart';
import 'package:template_bloc/presentation/base/base_state.dart';
import 'package:template_bloc/presentation/base/page_status.dart';
import 'package:template_bloc/shared/common/error_converter.dart';

part 'nfc_tap_bloc.freezed.dart';
part 'nfc_tap_event.dart';
part 'nfc_tap_state.dart';

@injectable
class NfcTapBloc extends BaseBloc<NfcTapEvent, NfcTapState> {
  NfcTapBloc() : super(const NfcTapState()) {
    on<NfcTapEvent>((event, emit) async {
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

  Future<void> _handleEventLoadData(Emitter<NfcTapState> emit, _LoadData event) async {}
}