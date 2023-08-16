import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/features/common/presentation/widgets/cupertino_loading.dart';
import 'package:worlds_away/features/common/presentation/widgets/my_error_widget.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/profile_bloc.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/profile_event.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/profile_state.dart';
import 'package:worlds_away/features/user/profile/presentation/widgets/account_info_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(GetUserProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(GetUserProfile());
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("Профиль"),
    );
  }

  _buildBody() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const CupertinoLoading();
        }

        if (state is ProfileDone) {
          return StreamBuilder(
            stream: state.user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: CachedNetworkImageProvider(
                              snapshot.data!.photoUrl!),
                        ),
                        AccountInfoWidget(user: snapshot.data!),
                      ],
                    ),
                  ),
                );
              } else {
                return const CupertinoLoading();
              }
            },
          );
        }

        if (state is ProfileError) {
          return MyErrorWidget(error: state.error!);
        }

        return const SizedBox();
      },
    );
  }
}
