import 'package:book_heaven/gen/assets.gen.dart';
import 'package:book_heaven/presentation/resources/color_manager.dart';
import 'package:book_heaven/presentation/resources/router/route_manager.dart';
import 'package:book_heaven/presentation/screens/profile/bloc.dart';
import 'package:book_heaven/presentation/screens/profile/event.dart';
import 'package:book_heaven/presentation/screens/profile/state.dart';
import 'package:book_heaven/ui_components/appbar_com.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(LoadProfileEvent()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.loggedOut) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.loginPage,
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          return _buildPage(context, state);
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context, ProfileState state) {
    switch (state.status) {
      case ProfileStatus.initial:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case ProfileStatus.loading:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case ProfileStatus.loaded:
        return ProfileView(state: state);
      default:
        return const Scaffold(body: Center(child: Text("Profile Error")));
    }
  }
}

class ProfileView extends StatelessWidget {
  final ProfileState state;
  const ProfileView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(title: "My Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 📌 **Profile Picture**
            Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.grey[300],
                backgroundImage: _getProfileImage(state.user?.gender),
              ),
            ),
            const SizedBox(height: 16),

            /// 📌 **Username**
            Text(
              state.user?.username ?? 'N/A',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),

            /// 📌 **Email**
            Text(
              state.user?.email ?? 'N/A',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),

            /// 📌 **User Details Section**
            _buildProfileCard([
              _buildProfileRow(
                  Icons.person, "Gender", state.user?.gender ?? 'N/A'),
              _buildProfileRow(Icons.calendar_today, "Age Group",
                  state.user?.ageGroup ?? 'N/A'),
              _buildProfileRow(
                Icons.favorite,
                "Interests",
                state.user?.interests?.isNotEmpty == true
                    ? state.user!.interests!.join(', ')
                    : 'N/A',
              ),
            ]),

            const SizedBox(height: 30),

            SizedBox(
              child: InkWell(
                onTap: () {
                  showLogoutDialog(context, () {
                    context.read<ProfileBloc>().add(LogoutEvent());
                  });
                },
                child: IntrinsicWidth(
                  // Adjusts width to fit the content
                  child: IntrinsicHeight(
                    // Adjusts height to fit the content
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16), // Add spacing
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorManager.primary),
                      ),
                      child: const Center(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 📌 **Get Profile Picture Based on Gender**
  ImageProvider _getProfileImage(String? gender) {
    if (gender?.toLowerCase() == "male") {
      return AssetImage(
          Assets.images.profile.defaultProfile.path); // Add male avatar
    } else if (gender?.toLowerCase() == "female") {
      return AssetImage(
          Assets.images.profile.defaultWomen.path); // Add female avatar
    } else {
      return AssetImage(
          Assets.images.profile.defaultProfile.path); // Default avatar
    }
  }

  /// 📌 **Reusable Card for Profile Info**
  Widget _buildProfileCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  /// 📌 **Reusable Row for Profile Info**
  Widget _buildProfileRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 24, color: ColorManager.primary),
          const SizedBox(width: 12),
          Text(
            "$label:",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// 📌 **Logout Dialog with Animation**
void showLogoutDialog(BuildContext context, VoidCallback onLogout) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Logout",
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.logout, size: 60, color: Colors.redAccent),
                  const SizedBox(height: 10),
                  const Text(
                    "Are you sure?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Do you really want to logout?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel",
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onLogout();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        child: const Text("Logout",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
