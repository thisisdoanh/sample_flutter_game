import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:template_bloc/app_bloc.dart';
import 'package:template_bloc/presentation/base/base_bloc.dart';
import 'package:template_bloc/presentation/base/base_state.dart';
import 'package:template_bloc/presentation/base/page_status.dart';
import 'package:template_bloc/presentation/router/router.dart';
import 'package:template_bloc/shared/common/error_converter.dart';

part 'splash_bloc.freezed.dart';
part 'splash_event.dart';
part 'splash_state.dart';

@injectable
class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc(this._appRouter, this._appBloc) : super(const SplashState()) {
    on<SplashEvent>((event, emit) async {
      try {
        switch (event) {
          case _LoadData():
            _handleEventLoadData(emit, event);
            break;
        }
      } catch (e, s) {
        handleError(emit, ErrorConverter.convert(e, s));
      }
    });
  }

  Future<void> _handleEventLoadData(Emitter<SplashState> emit, _LoadData event) async {
    _appBloc.add(const AppEvent.loadListGame());
    _appRouter.replace(const ChooseGameRoute());
  }

  final AppRouter _appRouter;
  final AppBloc _appBloc;
}
