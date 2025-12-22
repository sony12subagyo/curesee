abstract class LoginRepository {
  Future<String> login(String email, String password);
  Future<String> fetchRole(String token);
}
