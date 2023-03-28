import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProgressDialog extends StatelessWidget {
  const CustomProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      width: 200.h,
      height: 200.h,
      decoration: BoxDecoration(
          color: theme.colorScheme.onSecondary.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(10.h))),
      child: Center(
        child: SizedBox(
          height: 100.h,
          width: 100.h,
          child: CircularProgressIndicator(
            strokeWidth: 8.w,
            valueColor:
                AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
