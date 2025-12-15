// import 'package:curesee/users/features/profile/domain/entities/profil.dart';
// import 'package:curesee/users/features/profile/presentation/bloc/profile_bloc.dart';
// import 'package:curesee/users/features/profile/presentation/bloc/profile_event.dart';
// import 'package:curesee/users/features/profile/presentation/bloc/profile_state.dart';
// import 'package:curesee/users/features/profile/presentation/widget/jumlah_analisis_card.dart';
// import 'package:curesee/users/features/profile/presentation/widget/profile_card.dart';
// import 'package:curesee/users/features/profile/presentation/widget/update_profile_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ProfileBloc>().add(LoadProfileEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProfileBloc, ProfileState>(
//       builder: (context, state) {
//         if (state is ProfileLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (state is ProfileError) {
//           return Center(
//             child: Text(
//               state.message,
//               style: const TextStyle(color: Colors.red),
//             ),
//           );
//         }

//         if (state is ProfileLoaded) {
//           final Profile user = state.profileList.first;
//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: ProfileCard(profile: user),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [JumlahAnalisis()],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [UpdateProfileCard()],
//                 ),
//               ),
//             ],
//           );
//         }

//         return const SizedBox.shrink();
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),

        // avatar
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/avatar_placeholder.png'),
        ),

        const SizedBox(height: 12),

        const Text(
          'Guest User',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          'guest@email.com',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 24),

        _ProfileMenuItem(
          icon: Icons.analytics,
          title: 'Jumlah Analisis',
          value: '0',
        ),

        _ProfileMenuItem(
          icon: Icons.edit,
          title: 'Update Profil',
          value: 'Coming Soon',
        ),

        _ProfileMenuItem(
          icon: Icons.logout,
          title: 'Logout',
          value: '',
        ),
      ],
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
