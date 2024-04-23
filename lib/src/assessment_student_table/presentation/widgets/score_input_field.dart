import 'package:ease_studyante_teacher_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScoreInputField extends StatelessWidget {
  const ScoreInputField({
    Key? key,
    required this.totalScore,
    this.controller,
    this.onTap,
    this.hintText,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.initialValue,
    this.onChanged,
    this.isError = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final VoidCallback? onTap;
  final String? hintText;
  final bool readOnly;
  final Function(String value)? onFieldSubmitted;
  final String? initialValue;
  final Function(String? value)? onChanged;
  final int totalScore;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      onTap: onTap,
      readOnly: readOnly,
      initialValue: initialValue,
      onFieldSubmitted: onFieldSubmitted,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      showCursor: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isError ? Colors.red : Colors.grey,
            width: isError ? 2 : 1.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              12,
            ),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isError ? Colors.red : Colors.blue,
            width: isError ? 2 : 1.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              12,
            ),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorName.primary,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              12,
            ),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorName.primary,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              12,
            ),
          ),
        ),
      ),
    );
  }
}
