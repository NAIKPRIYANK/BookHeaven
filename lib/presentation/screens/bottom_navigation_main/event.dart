

import 'package:equatable/equatable.dart';


abstract class MainBottomNavigationEvent extends Equatable {
  const MainBottomNavigationEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends MainBottomNavigationEvent{}

class SelectTabEvent extends MainBottomNavigationEvent{
  final int index;

  const SelectTabEvent(this.index);

  @override
  List<Object?> get props => [index];
}

