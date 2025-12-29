import 'package:curesee/app/registrasi/domain/entities/registrasi_entitity.dart';

class RegistrasiModel extends RegistrasiEntity {
  RegistrasiModel({
    required super.name,
    required super.email,
    required super.gender,
    required super.age,
    required super.password,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'gender': gender, 'age': age};
  }
}
