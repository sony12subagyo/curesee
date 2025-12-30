import 'package:curesee/app/registrasi/domain/entities/registrasi_entitity.dart';

abstract class RegistrasiEvent {}

class RegistrasiSubmitted extends RegistrasiEvent {
  final RegistrasiEntity entity;

  RegistrasiSubmitted(this.entity);
}
