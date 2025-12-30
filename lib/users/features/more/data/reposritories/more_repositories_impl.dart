import 'package:curesee/users/features/more/data/data%20source/more_local_data_source.dart';
import 'package:curesee/users/features/more/domain/entities/more.dart';
import 'package:curesee/users/features/more/domain/repositories/more_repositories.dart';

class MoreRepositoryImpl implements MoreRepository {
  final MoreLocalDataSource local;

  MoreRepositoryImpl(this.local);

  @override
  Future<List<MoreMenu>> getMenus() async {
    final data = local.getMenus();
    return data.map((e) => MoreMenu(
      title: e['title'],
      icon: e['icon'],
      route: e['route'],
    )).toList();
  }

  @override
  Future<void> logout() async {
    // clear token / firebase signOut
  }
}
