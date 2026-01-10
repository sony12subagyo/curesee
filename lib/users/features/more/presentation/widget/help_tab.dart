import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/more_bloc.dart';
import '../bloc/more_event.dart';
import '../bloc/more_state.dart';

class PilihanTab extends StatelessWidget {
  const PilihanTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreBloc, MoreState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _tabButton(
                context,
                "Informasi Umum",
                MorePusatBantuan.informasiumum,
                state,
              ),
              _tabButton(context, "Akun", MorePusatBantuan.akun, state),
            ],
          ),
        );
      },
    );
  }

  Widget _tabButton(
    BuildContext context,
    String title,
    MorePusatBantuan kategori,
    MoreState state,
  ) {
    final bool isActive = state.selectedPusatBantuan == kategori;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<MoreBloc>().add(PilihanPusatBantuan(kategori));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Color.fromARGB(255, 0, 128, 255) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isActive
                    ? Colors.white
                    : Color.fromARGB(255, 0, 128, 255),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
