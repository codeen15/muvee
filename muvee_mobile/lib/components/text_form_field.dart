import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MvTextFormField extends StatelessWidget {
  const MvTextFormField({
    super.key,
    this.label,
    required this.controller,
    required this.focusNode,
    this.inputType = TextInputType.text,
    this.isObscured = false,
    this.validator,
    this.hintText,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.onChanged,
  });

  final String? label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType inputType;
  final bool isObscured;
  final String? Function(String?)? validator;
  final String? hintText;
  final Widget? suffixIcon;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? const SizedBox.shrink()
            : Column(
                children: [
                  Text(label.toString()),
                  SizedBox(height: 1.h),
                ],
              ),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: inputType,
          obscureText: isObscured,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white60),
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(
              vertical: 1.5.h,
              horizontal: 2.w,
            ),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
