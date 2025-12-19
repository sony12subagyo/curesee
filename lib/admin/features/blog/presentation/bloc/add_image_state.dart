import 'dart:io';

abstract class AddImageState {}

class AddImageInitial extends AddImageState {}

class AddImageLoading extends AddImageState {}

class AddImageSuccess extends AddImageState {
  final File image;
  AddImageSuccess(this.image);
}

class AddImageFailure extends AddImageState {
  final String message;
  AddImageFailure(this.message);
}
