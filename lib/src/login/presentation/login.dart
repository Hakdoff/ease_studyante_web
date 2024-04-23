import 'package:ease_studyante_teacher_app/core/bloc/global_bloc.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_teacher_app/gen/assets.gen.dart';
import 'package:ease_studyante_teacher_app/gen/colors.gen.dart';
import 'package:ease_studyante_teacher_app/src/home/presentation/home.dart';
import 'package:ease_studyante_teacher_app/src/login/data/data_sources/login_repository_impl.dart';
import 'package:ease_studyante_teacher_app/src/login/presentation/bloc/login_bloc.dart';
import 'package:ease_studyante_teacher_app/src/login/presentation/widgets/login_body.dart';
import 'package:ease_studyante_teacher_app/src/profile/data/data_sources/profile_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  late LoginBloc loginBloc;
  late GlobalBloc globalBloc;

  @override
  void initState() {
    super.initState();
    // emailCtrl.text = 'denstudent@deped.com';
    // passwordCtrl.text = 'asd000!!';
    final profileRepository = ProfileRepositoryImpl();
    loginBloc = LoginBloc(
      LoginRepositoryImpl(),
      profileRepository,
    );
    globalBloc = BlocProvider.of<GlobalBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(
          context: context,
          title: 'Commonwealth High School Teacher',
        ),
        body: SizedBox.expand(
          child: ProgressHUD(
            child: Builder(builder: (context) {
              final progressHUD = ProgressHUD.of(context);

              return BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoading) {
                    progressHUD?.show();
                  }

                  if (state is LoginSuccess || state is LoginError) {
                    progressHUD?.dismiss();

                    if (state is LoginSuccess) {
                      handleNavigate();
                      globalBloc.add(
                        StoreProfileEvent(profile: state.profile),
                      );
                    }
                  }
                },
                builder: (context, state) {
                  return Container(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.65,
                          width: MediaQuery.of(context).size.width * 0.65,
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: ColorName.gray,
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.55,
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: LoginBody(
                                    formKey: _formKey,
                                    emailCtrl: emailCtrl,
                                    passwordCtrl: passwordCtrl,
                                    onSubmit: handleSubmit,
                                    passwordVisible: _passwordVisible,
                                    errorMessage: state is LoginError
                                        ? state.errorMessage
                                        : null,
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                      child: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Assets.images.loginSchool.image(
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: (MediaQuery.of(context).size.height * 0.678) -
                              130,
                          child: Assets.icon.appIcon.image(
                            width: 130,
                            height: 130,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Add student support !widget.args.isTeacher
      // add checkbox for parent?

      loginBloc.add(
        OnSubmitLoginEvent(
          emailAddress: emailCtrl.value.text,
          password: passwordCtrl.value.text,
          isTeacher: true,
        ),
      );
    }
  }

  void handleErrorMessage(String errorMessage) {
    showTopSnackBar(
      Overlay.of(context),
      snackBarPosition: SnackBarPosition.bottom,
      CustomSnackBar.error(
        message: errorMessage,
      ),
    );
  }

  void handleNavigate() {
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }
}
