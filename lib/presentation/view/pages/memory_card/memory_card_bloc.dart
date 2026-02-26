import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:template_bloc/presentation/base/base_bloc.dart';
import 'package:template_bloc/presentation/base/base_state.dart';
import 'package:template_bloc/presentation/base/page_status.dart';
import 'package:template_bloc/shared/common/error_converter.dart';

part 'memory_card_bloc.freezed.dart';
part 'memory_card_event.dart';
part 'memory_card_state.dart';

@injectable
class MemoryCardBloc extends BaseBloc<MemoryCardEvent, MemoryCardState> {
  MemoryCardBloc() : super(const MemoryCardState()) {
    on<MemoryCardEvent>((event, emit) async {
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

  Future<void> _handleEventLoadData(Emitter<MemoryCardState> emit, _LoadData event) async {}
}