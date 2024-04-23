import 'package:ease_studyante_teacher_app/core/local_storage/local_storage.dart';
import 'package:ease_studyante_teacher_app/src/assessment/assessment_page.dart';
import 'package:ease_studyante_teacher_app/src/home/presentation/home.dart';
import 'package:ease_studyante_teacher_app/src/home/presentation/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SideMenuNavigation(
              onTap: (value) {
                if (value == 0) {
                  Navigator.of(context).pushNamed(HomePage.routeName);
                }

                if (value == 1) {
                  Navigator.of(context).pushNamed(AssessmentPage.routeName);
                }
              },
              index: -1,
            ),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleLogout() async {
    await LocalStorage.deleteLocalStorage('_user');
    await LocalStorage.deleteLocalStorage('_token');
    await LocalStorage.deleteLocalStorage('_refreshToken');
  }
}
