import 'package:equatable/equatable.dart';

enum MainBottomNavigationStatus { initial, loading, loaded, error }

// ignore: must_be_immutable
class MainBottomNavigationState extends Equatable {
  final MainBottomNavigationStatus? status;
  int? selectedIndex;

  MainBottomNavigationState({
    this.status,
    this.selectedIndex = 0
  });

  static MainBottomNavigationState initial() {
    return MainBottomNavigationState(
      status: MainBottomNavigationStatus.initial,
      selectedIndex: 0
    );
  }

  MainBottomNavigationState clone({
    MainBottomNavigationStatus? status,
    int? selectedIndex
  }) {
    return MainBottomNavigationState(
      status: status ?? this.status,
      selectedIndex: selectedIndex ?? this.selectedIndex
    );
  }

  @override
  List<Object?> get props => [status,selectedIndex];
}
