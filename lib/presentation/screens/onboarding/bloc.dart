import 'package:bloc/bloc.dart';
import 'event.dart';
import 'state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState.initial()) {
    on<InitEvent>(_init);
    on<OnboardingSkipEvent>(_skip);
  }

  void _init(InitEvent event, Emitter<OnboardingState> emit) {
    emit(state.clone(status: OnboardingStatus.initial));
    emit(state.clone(status: OnboardingStatus.loaded));
  }

  void _skip(OnboardingSkipEvent event, Emitter<OnboardingState> emit) {
    emit(state.clone(status: OnboardingStatus.loaded));
  }
}
