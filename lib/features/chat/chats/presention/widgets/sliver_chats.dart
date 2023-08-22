import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/core/widgets/slivers/sliver_container.dart';
import 'package:worlds_away/features/chat/chats/presention/blocs/chats_bloc.dart';
import 'package:worlds_away/features/chat/chats/presention/blocs/chats_state.dart';
import 'package:worlds_away/features/chat/chats/presention/widgets/chat_tile.dart';
import 'package:worlds_away/features/common/presentation/widgets/cupertino_loading.dart';
import 'package:worlds_away/features/common/presentation/widgets/my_error_widget.dart';

class SliverChats extends StatelessWidget {
  const SliverChats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        if (state is ChatsError) {
          return SliverFillRemaining(child: MyErrorWidget(error: state.error!));
        }

        if (state is ChatsLoading) {
          return const SliverFillRemaining(child: CupertinoLoading());
        }

        if (state is ChatsDone) {
          if (state.chats!.isEmpty) {
            return const SliverFillRemaining(
              child: Center(
                child: Text(
                  "У вас нету чатов",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }
          return SliverContainer(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(35)),
            background: Container(
              color: containerColor,
            ),
            sliver: SliverList.builder(
              itemCount: state.chats!.length,
              itemBuilder: (context, index) {
                final chat = state.chats![index];
                return ChatTile(chat);
              },
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}
