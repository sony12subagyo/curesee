import 'package:curesee/users/features/more/presentation/bloc/more_event.dart';

class MoreState {
  final MorePusatBantuan selectedPusatBantuan;

  MoreState({required this.selectedPusatBantuan});
  factory MoreState.initial() {
    return MoreState(selectedPusatBantuan: MorePusatBantuan.informasiumum);
  }
  MoreState copyWith({MorePusatBantuan? selectedPusatBantuan}) {
    return MoreState(
      selectedPusatBantuan: selectedPusatBantuan ?? this.selectedPusatBantuan,
    );
  }
}
