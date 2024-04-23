import 'package:ease_studyante_teacher_app/core/bloc/global_bloc.dart';
import 'package:ease_studyante_teacher_app/core/enum/view_status.dart';
import 'package:ease_studyante_teacher_app/core/routes/routes.dart';
import 'package:ease_studyante_teacher_app/src/home/presentation/home.dart';
import 'package:ease_studyante_teacher_app/src/login/presentation/login.dart';
import 'package:ease_studyante_teacher_app/src/profile/data/data_sources/profile_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EaseStudyanteTeacherApp extends StatefulWidget {
  const EaseStudyanteTeacherApp({super.key});
  static final navKey = GlobalKey<NavigatorState>();

  @override
  State<EaseStudyanteTeacherApp> createState() =>
      _EaseStudyanteTeacherAppState();
}

class _EaseStudyanteTeacherAppState extends State<EaseStudyanteTeacherApp>
    with WidgetsBindingObserver {
  bool isNeedOnBoarded = true;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    Future.delayed(const Duration(seconds: 3), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalBloc>(
          create: (context) =>
              GlobalBloc(ProfileRepositoryImpl())..add(SetProfileEvent()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(1366, 768),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        builder: ((context, child) {
          return BlocBuilder<GlobalBloc, GlobalState>(
            builder: (context, state) {
              return MaterialApp(
                navigatorKey: EaseStudyanteTeacherApp.navKey,
                onGenerateRoute: generateRoute,
                home: state.viewStatus == ViewStatus.successful
                    ? const HomePage()
                    : const LoginPage(),
              );
            },
          );
        }),
      ),
    );
  }
}
