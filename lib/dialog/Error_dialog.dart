import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../util/color_catagory.dart';
import '../util/constatnt_widget.dart';

class ErrorDialog extends StatefulWidget {
  String title;
  String message;
  ErrorDialog({required this.title, required this.message});

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.h)),
      child: SizedBox(
        width: 350.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // getVerSpace(40.h),
            // getCustomFont(widget.title, 22.sp, Colors.black, 1,
            //     fontWeight: FontWeight.w700, txtHeight: 1.5.h),
            getVerSpace(20.h),
            getCustomFont(widget.title, 22.sp, Colors.black, 1,
                fontWeight: FontWeight.w700, txtHeight: 1.5.h),

            getVerSpace(28.h),
            getMultilineCustomFont(widget.message, 16.sp, Colors.black,
                    fontWeight: FontWeight.w400,
                    txtHeight: 1.5.h,
                    textAlign: TextAlign.center)
                .paddingSymmetric(horizontal: 30.h),
            getVerSpace(40.h),
            getButton(context, buttonColor, "Ok", Colors.white, () {
              // Constant.sendToNext(context, Routes.loginRoute);
            }, 18.sp,
                    weight: FontWeight.w600,
                    buttonHeight: 60.h,
                    borderRadius: BorderRadius.circular(22.h))
                .paddingSymmetric(horizontal: 48.h),
            getVerSpace(40.h),
          ],
        ),
      ),
    );
  }
}
