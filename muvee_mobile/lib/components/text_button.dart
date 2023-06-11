import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../configs/colors.dart';

class MvTextButton extends StatelessWidget {
  const MvTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOutlined = false,
  });

  final String label;
  final void Function()? onPressed;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isOutlined ? Colors.transparent : quaternaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.sp),
          side: const BorderSide(
            color: quaternaryColor,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: isOutlined ? quaternaryColor : Colors.white,
        ),
      ),
    );
  }
}
