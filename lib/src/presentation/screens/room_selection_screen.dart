import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/common/theme/app_colors.dart';
import 'package:hotel/src/di/di.dart';
import 'package:hotel/src/domain/models/hotel.dart';
import 'package:hotel/src/presentation/blocs/rooms/rooms_bloc.dart';
import 'package:hotel/src/presentation/widgets/custom_app_bar.dart';
import 'package:hotel/src/presentation/widgets/room_card.dart';

class RoomSelectionScreen extends StatelessWidget {
  static const routeName = '/room_selection';

  const RoomSelectionScreen({Key? key, Hotel? hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Hotel hotel = ModalRoute.of(context)?.settings.arguments as Hotel;
    return BlocProvider<RoomsBloc>(
      create: (_) => getIt<RoomsBloc>()..add(LoadRooms()),
      child: BlocBuilder<RoomsBloc, RoomsState>(
        builder: (_, state) {
          if (state is RoomsLoading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is RoomsFailure) {
            return Center(child: Text('Failed to load rooms: ${state.message}'));
          }
          if (state is RoomsLoaded) {
            return Scaffold(
              backgroundColor: AppColors.background,
              appBar: CustomAppBar(
                title: hotel.name,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: state.rooms
                      .map((room) => RoomCard(
                            room: room,
                          ))
                      .toList(),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
