import 'dart:io';

class AddImageState {
  final File? image;
  final bool isLoading;
  final String? errorMessage;

  const AddImageState({
    this.image,
    this.isLoading = false,
    this.errorMessage,
  });

  AddImageState copyWith({
    File? image,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AddImageState(
      image: image ?? this.image,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
