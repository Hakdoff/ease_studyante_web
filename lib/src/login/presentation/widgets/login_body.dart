import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/common_widget/common_widget.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    Key? key,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.formKey,
    required this.suffixIcon,
    required this.onSubmit,
    required this.passwordVisible,
    this.errorMessage,
  }) : super(key: key);

  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final GlobalKey formKey;
  final Widget suffixIcon;
  final VoidCallback onSubmit;
  final bool passwordVisible;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 50,
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(40),
            CustomTextField(
              labelText: 'Email Address',
              parametersValidate: 'required',
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl,
              validators: (value) {
                if (value != null && EmailValidator.validate(value)) {
                  return null;
                }
                return "Please enter a valid email";
              },
            ),
            CustomTextField(
              labelText: 'Password',
              parametersValidate: 'required',
              textController: passwordCtrl,
              validators: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              obscureText: !passwordVisible,
              suffixIcon: suffixIcon,
            ),
            const Gap(10),
            if (errorMessage != null) ...[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: CustomText(
                    text: errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const Gap(20),
            ],
            CustomBtn(
              label: 'Login',
              onTap: onSubmit,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              width: MediaQuery.of(context).size.width * 0.23,
            ),
          ],
        ),
      ),
    );
  }
}
