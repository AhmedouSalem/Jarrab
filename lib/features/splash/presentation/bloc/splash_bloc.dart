import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jarrab/features/splash/domain/usecases/init_app_usecase.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required InitAppUseCase initApp})
    : _initApp = initApp,
      super(const SplashInitial()) {
    on<SplashStarted>(_onStarted);
    on<SplashRetry>(_onRetry);
  }

  final InitAppUseCase _initApp;

  static const _minSplashDuration = Duration(milliseconds: 6200);

  Future<void> _onStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading('Initializing…'));

    try {
      await Future.wait([_initApp(), Future.delayed(_minSplashDuration)]);
      emit(const SplashReady());
    } catch (e, st) {
      debugPrint('Splash init failed: $e');
      debugPrintStack(stackTrace: st);
      await Future.delayed(_minSplashDuration);
      emit(const SplashReady());
    }
  }

  Future<void> _onRetry(SplashRetry event, Emitter<SplashState> emit) async {
    add(const SplashStarted());
  }
}
