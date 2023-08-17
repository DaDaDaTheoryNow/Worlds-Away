import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_bloc.dart';
import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_event.dart';
import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_state.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: bottomNavigationBarItems,
            currentIndex: state.currentIndex ?? 0,
            onTap: (index) => _onTap(context, index),
          ),
        );
      },
    );
  }

  _onTap(context, index) {
    BlocProvider.of<BottomNavigationBarBloc>(context).add(OnTap(index));
  }
}
