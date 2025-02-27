import 'package:book_heaven/presentation/screens/bottom_navigation_main/event.dart';
import 'package:book_heaven/presentation/screens/bottom_navigation_main/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBottomNavigationBloc extends Bloc<MainBottomNavigationEvent,MainBottomNavigationState> {
  MainBottomNavigationBloc() : super(MainBottomNavigationState.initial()) {
    on<InitEvent>(_init);
    on<SelectTabEvent>(_selectTab);

  }

  Future<void> _init(MainBottomNavigationEvent event, Emitter<MainBottomNavigationState> emit) async {

    emit(state.clone(status: MainBottomNavigationStatus.loading));

    emit(state.clone(status: MainBottomNavigationStatus.loaded));
    
  }

  void _selectTab(SelectTabEvent event, Emitter<MainBottomNavigationState> emit) {
    emit(state.clone(selectedIndex: event.index));
  }

}
