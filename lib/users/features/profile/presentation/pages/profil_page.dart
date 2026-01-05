import 'package:curesee/users/features/profile/domain/entities/profil.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_event.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_state.dart';
import 'package:curesee/users/features/profile/presentation/widget/jumlah_analisis_card.dart';
import 'package:curesee/users/features/profile/presentation/widget/profile_card.dart';
import 'package:curesee/users/features/profile/presentation/widget/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProfileError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is ProfileLoaded) {
          final Profile user = state.profile;
          return SingleChildScrollView(
            child: Column(
              children: [
                ProfileCard(profile: user),
                //Di dalam ProfilePage (state is ProfileLoaded)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:
                      CrossAxisAlignment.start, //Agar widget rata atas
                  children: [
                    const JumlahAnalisis(),
                    const SizedBox(
                      width: 8,
                    ), //Gunakan Expanded agar ProfileForm menyesuaikan sisa ruang layar
                  ],
                ),
                const SizedBox(height: 16),
                ProfileForm(profile: user),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

// import 'package:flutter/material.dart';

// class ProfilPage extends StatelessWidget {
//   const ProfilPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text("halaman profil", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
//     );
//   }
// }
