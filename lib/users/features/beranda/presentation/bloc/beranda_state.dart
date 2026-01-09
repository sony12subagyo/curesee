import '../../domain/entities/beranda.dart';

abstract class BerandaState {}

class BerandaInitial extends BerandaState {}

class BerandaLoading extends BerandaState {}

class BerandaLoaded extends BerandaState {
  final List<Beranda> beranda;
  BerandaLoaded(this.beranda);
}

class BerandaFailure extends BerandaState {
  final String message;
  BerandaFailure(this.message);
}
