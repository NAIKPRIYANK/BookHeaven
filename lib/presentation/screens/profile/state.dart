
import 'package:book_heaven/models/models.dart';
import 'package:equatable/equatable.dart';

enum ProfileStatus { initial, loading, loaded, error, loggedOut }

class ProfileState extends Equatable {
  final LocalUserModel? user;
  final ProfileStatus status;

  const ProfileState({this.user, required this.status});

  factory ProfileState.initial() =>
      const ProfileState(user: null, status: ProfileStatus.initial);

  ProfileState clone({LocalUserModel? user, ProfileStatus? status}) {
    return ProfileState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [user, status];
}
