import 'package:curesee/admin/features/users/data/data_source/user_remote_data.dart';
import 'package:curesee/admin/features/users/data/repositories/user_repository_impl.dart';
import 'package:curesee/admin/features/users/domain/usecase/delete_users_usecase.dart';
import 'package:curesee/admin/features/users/domain/usecase/get_users_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curesee/admin/features/users/presentation/bloc/user_bloc.dart';
import 'package:curesee/admin/features/users/presentation/bloc/user_event.dart';
import 'package:curesee/admin/features/users/presentation/bloc/user_state.dart';
import 'package:curesee/app/navigation/background_wrapper.dart';
import 'package:curesee/admin/features/blog/presentation/page/blog_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/user_card.dart';
import '../widgets/total_user_card.dart';
import 'package:http/http.dart' as http;

/// ================================
/// ADMIN PAGE (FINAL FIX)
/// ================================
class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String? _adminToken;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAdminToken();
  }

  Future<void> _loadAdminToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('admin_token');

    debugPrint('ADMIN TOKEN DARI STORAGE: $token');

    setState(() {
      _adminToken = token;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // =========================
    // LOADING TOKEN
    // =========================
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // =========================
    // TOKEN TIDAK ADA
    // =========================
    if (_adminToken == null) {
      return const Scaffold(
        body: Center(
          child: Text('Token admin tidak ditemukan, silakan login ulang'),
        ),
      );
    }

    // =========================
    // BLOC PROVIDER (DIBUAT SEKALI)
    // =========================
    return BlocProvider(
      create: (_) {
        final remoteDataSource = UserRemoteDataSourceImpl(
          client: http.Client(),
          baseUrl: 'https://a9faa2a6661c.ngrok-free.app/api',
          token: _adminToken!,
        );

        final repository = UserRepositoryImpl(remoteDataSource);
        final getUsersUseCase = GetUsersUseCase(repository);
        final deleteUserUseCase = DeleteUserUseCase(repository);

        return UserBloc(
          getUsersUseCase: getUsersUseCase,
          deleteUserUseCase: deleteUserUseCase,
        )..add(LoadUsers()); // 🔥 DIPANGGIL SEKALI
      },
      child: const _AdminView(),
    );
  }
}

/// ================================
/// VIEW
/// ================================
class _AdminView extends StatelessWidget {
  const _AdminView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: const Color(0xFF1EA3FF),
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BlogPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blog'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Account'),
        ],
      ),
      appBar: AppBar(
        title: const Text('Information Account User'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BackgroundWrapper(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserLoaded) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  if (width < 600) {
                    return _mobile(context, state);
                  } else if (width < 1024) {
                    return _tablet(context, state);
                  }
                  return _desktop(context, state);
                },
              );
            }

            if (state is UserError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _mobile(BuildContext context, UserLoaded state) {
    return Column(
      children: [
        TotalUserCard(totalUser: state.users.length),
        Expanded(
          child: ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (_, index) {
              final user = state.users[index];
              return UserCard(
                user: user,
                onDelete: () {
                  context.read<UserBloc>().add(DeleteUser(user.id));
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _tablet(BuildContext context, UserLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TotalUserCard(totalUser: state.users.length),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: state.users.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3.2,
              ),
              itemBuilder: (_, index) {
                final user = state.users[index];
                return UserCard(
                  user: user,
                  onDelete: () {
                    context.read<UserBloc>().add(DeleteUser(user.id));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _desktop(BuildContext context, UserLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TotalUserCard(totalUser: state.users.length),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 5,
            child: GridView.builder(
              itemCount: state.users.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3.5,
              ),
              itemBuilder: (_, index) {
                final user = state.users[index];
                return UserCard(
                  user: user,
                  onDelete: () {
                    context.read<UserBloc>().add(DeleteUser(user.id));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
