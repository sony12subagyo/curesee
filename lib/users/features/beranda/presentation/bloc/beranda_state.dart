import 'package:curesee/users/features/beranda/domain/entities/beranda.dart';

abstract class BerandaState {}

class BerandaInitial extends BerandaState {}
class BerandaLoading extends BerandaState {}
class BerandaLoaded extends BerandaState {
  final List<Beranda> data;
  BerandaLoaded(this.data);
}
class BerandaError extends BerandaState {
  final String message;
  BerandaError(this.message);
}
