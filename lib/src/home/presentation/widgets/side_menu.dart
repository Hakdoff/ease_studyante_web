import 'package:ease_studyante_teacher_app/core/local_storage/local_storage.dart';
import 'package:ease_studyante_teacher_app/src/login/presentation/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';

import 'package:ease_studyante_teacher_app/core/bloc/global_bloc.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_teacher_app/gen/colors.gen.dart';

class SideMenuNavigation extends StatelessWidget {
  const SideMenuNavigation({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final int index;

  final Function(int value) onTap;

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      mode: SideMenuMode.open,
      hasResizerToggle: false,
      builder: (data) => SideMenuData(
        header: Container(
          color: ColorName.primary,
          height: 120,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: BlocSelector<GlobalBloc, GlobalState, GlobalState>(
            selector: (state) {
              return state;
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      style: const TextStyle(color: Colors.white),
                      text:
                          '${state.profile.firstName} ${state.profile.lastName}'),
                  CustomText(
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    text: state.profile.email,
                  )
                ],
              );
            },
          ),
        ),
        items: [
          SideMenuItemDataTile(
            isSelected: index == 0,
            onTap: () {
              onTap(0);
            },
            title: 'Sections',
            highlightSelectedColor: ColorName.primary,
            icon: Icon(
              Icons.account_box,
              color: index == 0 ? Colors.white : ColorName.gray,
            ),
          ),
          SideMenuItemDataTile(
            highlightSelectedColor: ColorName.primary,
            isSelected: index == 1,
            onTap: () {
              onTap(1);
            },
            title: 'Assessments',
            icon: Icon(Icons.grade,
                color: index == 1 ? Colors.white : ColorName.gray),
          ),
        ],
        footer: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomBtn(
              height: 45,
              label: 'Logout',
              onTap: () {
                handleLogout(context);
              }),
        ),
      ),
    );
  }

  Future<void> handleLogout(BuildContext context) async {
    await LocalStorage.deleteLocalStorage('_user');
    await LocalStorage.deleteLocalStorage('_token');
    await LocalStorage.deleteLocalStorage('_refreshToken');
    // ignore: use_build_context_synchronously
    context.read<GlobalBloc>().add(OnLogoutEvent());
    // ignore: use_build_context_synchronously
    Navigator.popAndPushNamed(context, LoginPage.routeName);
  }
}
