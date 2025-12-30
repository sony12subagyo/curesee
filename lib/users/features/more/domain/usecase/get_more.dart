import 'package:curesee/users/features/more/domain/entities/more.dart';
import 'package:curesee/users/features/more/domain/repositories/more_repositories.dart';

class GetMoreMenus {
  final MoreRepository repository;

  GetMoreMenus(this.repository);

  Future<List<MoreMenu>> call() {
    return repository.getMenus();
  }
}
