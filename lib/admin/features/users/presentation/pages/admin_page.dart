import 'package:curesee/admin/features/users/data/data_source/user_remote_data.dart';
import 'package:curesee/admin/features/users/data/repositories/user_repository_impl.dart';
import 'package:curesee/admin/features/users/domain/usecase/delete_users_usecase.dart';
import 'package:curesee/admin/features/users/domain/usecase/get_users_usecase.dart';
import 'package:curesee/app/login/presentation/pages/login_page.dart';
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

/// =======================================
/// ADMIN PAGE (FINAL – RESPONSIVE + LOGOUT)
/// =======================================
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
    _adminToken = prefs.getString('admin_token');
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_adminToken == null) {
      return const Scaffold(
        body: Center(child: Text('Token admin tidak ditemukan')),
      );
    }

    return BlocProvider(
      create: (_) {
        final remote = UserRemoteDataSourceImpl(
          client: http.Client(),
          baseUrl: 'https://a9faa2a6661c.ngrok-free.app/api',
          token: _adminToken!,
        );

        final repo = UserRepositoryImpl(remote);

        return UserBloc(
          getUsersUseCase: GetUsersUseCase(repo),
          deleteUserUseCase: DeleteUserUseCase(repo),
        )..add(LoadUsers());
      },
      child: const _AdminView(),
    );
  }
}

/// =======================================
/// VIEW
/// =======================================
class _AdminView extends StatelessWidget {
  const _AdminView();

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      bottomNavigationBar: isDesktop ? null : _bottomNav(context),
      body: BackgroundWrapper(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserLoaded) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return _mobile(context, state);
                  } else if (constraints.maxWidth < 1024) {
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

  // ================= MOBILE =================
  Widget _mobile(BuildContext context, UserLoaded state) {
    return Column(
      children: [
        TotalUserCard(totalUser: state.users.length),
        Expanded(
          child: ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (_, i) {
              final user = state.users[i];
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

  // ================= TABLET =================
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
              itemBuilder: (_, i) {
                final user = state.users[i];
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

  // ================= DESKTOP =================
  Widget _desktop(BuildContext context, UserLoaded state) {
    return Row(
      children: [
        // ===== SIDEBAR (PUTIH) =====
        Container(
          width: 260,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 32),

              // LOGO
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.favorite, color: Colors.blue),
                  SizedBox(width: 6),
                  Text(
                    'CureSee',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // MENU
              _menuItem(
                icon: Icons.article,
                title: 'Blog',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const BlogPage()),
                  );
                },
              ),

              _menuItem(icon: Icons.people, title: 'Account', active: true),

              // PUSH KE BAWAH
              const Spacer(),

              // LOGOUT (BAWAH KIRI)
              _menuItem(
                icon: Icons.logout_rounded,
                title: 'Logout',
                danger: true,
                onTap: () => _showLogoutDialog(context),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),

        // ===== CONTENT =====
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Information Account User',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                TotalUserCard(totalUser: state.users.length),
                const SizedBox(height: 24),
                Expanded(
                  child: GridView.builder(
                    itemCount: state.users.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 3.5,
                        ),
                    itemBuilder: (_, i) {
                      final user = state.users[i];
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
          ),
        ),
      ],
    );
  }

  // ================= BOTTOM NAV =================
  Widget _bottomNav(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }

  // ================= LOGOUT =================
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _logout(context);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }
}

/// =======================================
/// SIDEBAR MENU ITEM
/// =======================================
Widget _menuItem({
  required IconData icon,
  required String title,
  VoidCallback? onTap,
  bool active = false,
  bool danger = false,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: active ? Colors.blue.shade50 : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: danger ? Colors.red : Colors.blue),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
              color: danger ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
