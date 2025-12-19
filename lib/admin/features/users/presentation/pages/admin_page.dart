import 'package:curesee/admin/features/users/data/dummy_user.dart';
import 'package:curesee/app/navigation/background_wrapper.dart';
import 'package:flutter/material.dart';
import '../widgets/total_user_card.dart';
import '../widgets/user_card.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Information Account User'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BackgroundWrapper(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            if (width < 600) return _mobileLayout();
            if (width < 1024) return _tabletLayout();
            return _desktopLayout();
          },
        ),
      ),
    );
  }

  // MOBILE
  Widget _mobileLayout() {
    return Column(
      children: [
        TotalUserCard(totalUser: dummyUsers.length),
        Expanded(
          child: ListView.builder(
            itemCount: dummyUsers.length,
            itemBuilder: (context, index) {
              return UserCard(user: dummyUsers[index]);
            },
          ),
        ),
      ],
    );
  }

  // TABLET
  Widget _tabletLayout() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TotalUserCard(totalUser: dummyUsers.length),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3.2,
              ),
              itemCount: dummyUsers.length,
              itemBuilder: (context, index) {
                return UserCard(user: dummyUsers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // DESKTOP
  Widget _desktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TotalUserCard(totalUser: dummyUsers.length),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 5,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3.5,
              ),
              itemCount: dummyUsers.length,
              itemBuilder: (context, index) {
                return UserCard(user: dummyUsers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
