class DummyLoginDataSource {
  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == "user@gmail.com" && password == "123") {
      return {"email": email, "password": password};
    } else {
      throw Exception("Email atau password salah!");
    }
  }
}
