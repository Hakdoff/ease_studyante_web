import 'package:ease_studyante_teacher_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/main_scaffold.dart';
import 'package:ease_studyante_teacher_app/src/section/presentation/section_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<int> currentIndex = ValueNotifier(0);

  final pages = const [
    SectionPage(),
    PlaceHolderPage(),
    PlaceHolderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      child: SectionPage(),
    );
  }
}

class PlaceHolderPage extends StatefulWidget {
  const PlaceHolderPage({super.key});

  static const String routeName = 'place-holder';

  @override
  State<PlaceHolderPage> createState() => _PlaceHolderPageState();
}

class _PlaceHolderPageState extends State<PlaceHolderPage> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Scaffold(
        appBar: buildAppBar(context: context, title: 'Place Holder'),
        body: Container(),
      ),
    );
  }
}
