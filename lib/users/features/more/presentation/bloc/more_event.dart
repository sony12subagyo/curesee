enum MorePusatBantuan { informasiumum, akun }

abstract class MoreEvent {}

class PilihanPusatBantuan extends MoreEvent {
  final MorePusatBantuan pusatBantuan;

  PilihanPusatBantuan(this.pusatBantuan);
}
