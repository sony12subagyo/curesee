// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:camera/camera.dart';
// import '../../data/repositories/camera_repository_impl.dart';

// class CameraState {
//   final bool isLoading;
//   final CameraController? controller;
//   final FlashMode flashMode;
//   final int cameraIndex;

//   CameraState({
//     this.isLoading = true,
//     this.controller,
//     this.flashMode = FlashMode.off,
//     this.cameraIndex = 0,
//   });

//   CameraState copyWith({
//     bool? isLoading,
//     CameraController? controller,
//     FlashMode? flashMode,
//     int? cameraIndex,
//   }) {
//     return CameraState(
//       isLoading: isLoading ?? this.isLoading,
//       controller: controller ?? this.controller,
//       flashMode: flashMode ?? this.flashMode,
//       cameraIndex: cameraIndex ?? this.cameraIndex,
//     );
//   }
// }

// class CameraCubit extends Cubit<CameraState> {
//   final CameraRepository repository;

//   CameraCubit(this.repository) : super(CameraState());

//   Future<void> initCamera() async {
//     emit(state.copyWith(isLoading: true));

//     await repository.loadCameras();

//     final controller = await repository.initCamera(
//       state.cameraIndex,
//       state.flashMode,
//     );

//     emit(state.copyWith(isLoading: false, controller: controller));
//   }

//   Future<void> switchCamera() async {
//     final newIndex = state.cameraIndex == 0 ? 1 : 0;

//     emit(state.copyWith(cameraIndex: newIndex));
//     await initCamera();
//   }

//   Future<void> changeFlash(FlashMode mode) async {
//     await repository.controller!.setFlashMode(mode);
//     emit(state.copyWith(flashMode: mode));
//   }

//   Future<XFile> capturePhoto() async {
//     return await repository.takePhoto();
//   }
// }
