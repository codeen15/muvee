import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../configs/colors.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    this.size,
  });

  final double? size;

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      size: size ?? 24.sp,
      color: quaternaryColor,
    );
  }
}
