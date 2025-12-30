import 'package:curesee/users/features/more/domain/entities/more.dart';

abstract class MoreRepository {
  Future<List<MoreMenu>> getMenus();
  Future<void> logout();
}
