class DummyLoginDataSource {
  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == "user@gmail.com" && password == "123") {
      return {"email": email, "role": "user"};
    }

    if (email == "admin@gmail.com" && password == "123") {
      return {"email": email, "role": "admin"};
    }

    throw Exception("Email atau password salah!");
  }
}
