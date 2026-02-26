import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:template_bloc/presentation/base/base_bloc.dart';
import 'package:template_bloc/presentation/base/base_state.dart';
import 'package:template_bloc/presentation/base/page_status.dart';
import 'package:template_bloc/shared/common/error_converter.dart';

part 'catch_the_button_bloc.freezed.dart';
part 'catch_the_button_event.dart';
part 'catch_the_button_state.dart';

@injectable
class CatchTheButtonBloc extends BaseBloc<CatchTheButtonEvent, CatchTheButtonState> {
  CatchTheButtonBloc() : super(const CatchTheButtonState()) {
    on<CatchTheButtonEvent>((event, emit) async {
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

  Future<void> _handleEventLoadData(Emitter<CatchTheButtonState> emit, _LoadData event) async {}
}