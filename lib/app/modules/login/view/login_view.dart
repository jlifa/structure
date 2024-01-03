import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:structure_project/app/modules/login/controller/login_controller.dart';
import 'package:structure_project/app/utilities/Icon_utils.dart';

import '../../../utilities/colors.dart';


class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: const BoxDecoration(
          gradient: background,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconUtils.getSvgImage('logo', color: Colors.white, height: 126.h),
            SizedBox(
              height: 40.h,
            ),
            // InputWidget(
            //   hintText: 'Email',
            //   controller: controller.emailController,
            // ),
            SizedBox(
              height: 8.h,
            ),
            // InputWidget(
            //   isPassword: true,
            //   hintText: 'Password',
            //   controller: controller.passwordController,
            // ),
            SizedBox(
              height: 20.h,
            ),
            Container(),
            // Obx(() => SolidButtonWidget(
            //   isReady: controller.isEmailReady.value && controller.isPasswordReady.value,
            //   text: 'Login',
            //   onTap: controller.login,
            // ),),
            SizedBox(
              height: 50.h,
            ),
            // GestureDetector(
            //   onTap: (){
            //     SmartDialog.show(
            //       animationType: SmartAnimationType.centerFade_otherSlide,
            //       animationTime: const Duration(milliseconds: 100),
            //       builder: (context) {
            //         return EmailPopUp(controller: controller.emailResetController,
            //         send: () {
            //           controller.resetPassword();
            //          },
            //         );
            //       });
            //   },
            //   child:  Text('Forgot Password',style: TextStyle(
            //     color: white,
            //     fontSize: 16.sp,
            //       fontWeight: FontWeight.w400
            //   ),),
            // )
          ],
        ),
      ),
    );
  }
}



