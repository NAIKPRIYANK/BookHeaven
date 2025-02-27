import 'package:equatable/equatable.dart';

/// Enum representing different states of the Onboarding screen
enum OnboardingStatus { initial, loading, loaded,error }

class OnboardingState extends Equatable {
  final OnboardingStatus status;

  const OnboardingState({required this.status});

  /// Returns the initial state of the Onboarding screen
  factory OnboardingState.initial() => const OnboardingState(status: OnboardingStatus.initial);

  /// Creates a new instance of OnboardingState with updated values
  OnboardingState clone({OnboardingStatus? status}) {
    return OnboardingState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
