// ignore_for_file: unrelated_type_equality_checks, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../dialog/Error_dialog.dart';
import '../util/color_catagory.dart';
import '../util/constatnt_widget.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var _isLoading = false;
  Future auth() async {
    if (_emailController.text == '') {
      Get.dialog(ErrorDialog(
        title: 'Unable to log in',
        message: 'Email adress or mobile number required',
      ));
    } else if (_passwordController.text == '') {
      Get.dialog(ErrorDialog(
        title: 'Password required',
        message: 'Enter your password to continue',
      ));
    } else {
      try {
        setState(() {
          _isLoading = true;
        });

        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim())
            .then((value) {});
      } on FirebaseAuthException catch (e) {
        e.printError();
        setState(() {
          _isLoading = false;
        });

        if (e.code == 'invalid-email') {
          Get.dialog(ErrorDialog(
            title: 'invalid-email',
            message: 'The email address is badly formatted',
          ));
        } else if (e.code == 'user-not-found') {
          Get.dialog(ErrorDialog(
            title: 'user-not-found',
            message:
                'There is no user record corresponding to this identifier. The user may have been deleted',
          ));
        } else if (e.code == 'wrong-password') {
          Get.dialog(ErrorDialog(
            title: 'wrong-password',
            message: 'The password is invalid',
          ));
        } else {
          Get.dialog(ErrorDialog(
            title: 'Unable to log in',
            message: 'Something went wrong',
          ));
          // show(
          //     context,
          //     'Sorry, unable to log in. please check your internet connection',
          //     'Login Failed');
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    setStatusBarColor(bgColor);
    return Scaffold(

      backgroundColor: bgWhite,
      resizeToAvoidBottomInset: false,
      body: Container(
        color: bgColor,
        child: SafeArea(
          bottom: false,
          child: Container(
            width: double.infinity,
            color: bgColor,
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getVerSpace(55.h),
                    getCustomFont("Login", 34.sp, Colors.black, 1,
                            fontWeight: FontWeight.w700, txtHeight: 1.5.h)
                        .paddingSymmetric(horizontal: 20.h),
                    getVerSpace(4.h),
                    getMultilineCustomFont("Glad to meet you again! ",
                            16.sp, Colors.black,
                            fontWeight: FontWeight.w400, txtHeight: 1.5.h)
                        .paddingSymmetric(horizontal: 20.h),
                    getVerSpace(24.h),
                    Expanded(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          decoration: BoxDecoration(
                              color: bgWhite,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(22.h)),
                              boxShadow: [
                                BoxShadow(
                                    color: "#26A92F45".toColor(),
                                    blurRadius: 47,
                                    offset: const Offset(1, 4))
                              ]),
                          child: Column(
                            children: [
                              getVerSpace(140.h),
                              getDefaultTextFiledWithLabel(context,
                                  "Enter email address", _emailController,
                                  isEnable: false,
                                  height: 56.h,
                                  withprefix: true,
                                  image: "profile.svg"),
                              getVerSpace(30.h),
                              getDefaultTextFiledWithLabel(context,
                                  "Enter password", _passwordController,
                                  isEnable: false,
                                  height: 56.h,
                                  withprefix: true,
                                  image: "lock.svg",
                                  isPass: true,
                                  withSufix: true,
                                  suffiximage: "eye.svg"),
                              getVerSpace(12.h),
                              Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    // Constant.sendToNext(
                                    //     context, Routes.forgotScreenRoute);
                                  },
                                  child: getCustomFont("Forgot Password?",
                                      16.sp, Colors.black, 1,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              getVerSpace(140.h),
                              getButton(context, buttonColor, "Login",
                                  Colors.white, () {
                                auth();
                                // Get.dialog(ConfirmDialog());
                                // controller.onChange(0.obs);
                                // PrefData.setIsSignIn(false);
                                // Constant.sendToNext(
                                //     context, Routes.homeScreenRoute);
                              }, 18.sp,
                                  weight: FontWeight.w600,
                                  buttonHeight: 60.h,
                                  borderRadius:
                                      BorderRadius.circular(22.h)),
                              getVerSpace(30.h),
                              getVerSpace(30.h),
                              getVerSpace(62.h),
                              getTwoRichText(
                                  "Don’t have an account? ",
                                  Colors.black,
                                  FontWeight.w400,
                                  16.sp,
                                  "Sign Up",
                                  buttonColor,
                                  FontWeight.w700,
                                  16.sp,
                                  txtHeight: 1.5.h, function: () {
                                Navigator.of(context)
                                    .pushNamed('/register');
                                // Constant.sendToNext(
                                //     context, Routes.signUpScreenRoute);
                              })
                            ],
                          ),
                        ))
                  ],
                ),
          ),
        ),
      ),
    );
  }
}




// import 'package:darzionmarzi/screens/register_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../constants.dart';
// import '../provider/auth_provider.dart';
// import '../size_config.dart';

// class LoginScreen extends StatefulWidget {
//   static const routeName = "/LoginScreen";
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formkey = GlobalKey<FormState>();

//   // final AuthProvider authProvider = AuthProvider();
//   String email = '';
//   String pass = '';
//   String error = '';
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     final authProvider = Provider.of<AuthProvider>(context);
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: AppColors.primaryShade1,
//       appBar: AppBar(
//         backgroundColor: AppColors.primaryShade1,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           height: height,
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25),
//               child: SizedBox(
//                 height: SizeConfig.screenHeight * 0.15,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Login",
//                       style: TextStyle(
//                           color: AppColors.textBlack,
//                           fontSize: 50,
//                           fontWeight: FontWeight.w900),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       "Enter your details to login!",
//                       style: TextStyle(
//                           color: AppColors.textBlack,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 height: SizeConfig.screenHeight * 0.7,
//                 width: SizeConfig.screenWidth,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(50),
//                         topRight: Radius.circular(50))),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Form(
//                       key: _formkey,
//                       child: Column(children: [
//                         Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               TextFormField(
//                                 onChanged: (value) {
//                                   setState(() {
//                                     email = value;
//                                   });
//                                 },
//                                 validator: (value) =>
//                                     value!.isEmpty ? "Enter an Email" : null,
//                                 decoration: InputDecoration(
//                                   hintText: 'Email adress',
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10.0),
//                                     borderSide: BorderSide(color: Colors.white),
//                                   ),
//                                   hintStyle:
//                                       TextStyle(color: Color(0xff8391A1)),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: height * .012,
//                               ),
//                               TextFormField(
//                                 validator: (value) => value!.length < 6
//                                     ? "Enter Password 6+ words"
//                                     : null,
//                                 decoration: InputDecoration(
//                                   hintText: 'Password',
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10.0),
//                                     borderSide: BorderSide(color: Colors.white),
//                                   ),
//                                   hintStyle:
//                                       TextStyle(color: Color(0xff8391A1)),

//                                   // focusedBorder: UnderlineInputBorder(
//                                   //   borderSide: BorderSide(
//                                   //       color: Color.fromARGB(255, 31, 31, 31)),
//                                   // ),
//                                 ),
//                                 obscureText: true,
//                                 onChanged: ((value) {
//                                   setState(() {
//                                     pass = value;
//                                   });
//                                 }),
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               InkWell(
//                                   onTap: () {},
//                                   child: const Text(
//                                     "Forget Password?",
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.black54),
//                                   )),
//                               // const SizedBox(
//                               //   height: 30,
//                               // ),
//                               SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                     onPressed: () async {
//                                       if (_formkey.currentState!.validate()) {
//                                         await authProvider
//                                             .signinWithEmailAndPass(
//                                                 email, pass, context);
//                                       }
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(25.0),
//                                         ),
//                                         minimumSize: const Size(0, 60),
//                                         backgroundColor:
//                                             AppColors.primaryColor),
//                                     child: const Text(
//                                       "SignIn",
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w600,
//                                           letterSpacing: 1.5),
//                                     )),
//                               ),
//                               // SizedBox(
//                               //   height: 30,
//                               // ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "or",
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         color: AppColors.textBlack,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ],
//                               ),
//                               // SizedBox(
//                               //   height: 30,
//                               // ),

//                               Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       "Don't have an account?",
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.black54),
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     InkWell(
//                                       onTap: () {
//                                         Navigator.of(context).pushNamed(
//                                             RegisterScreen.routeName);
//                                       },
//                                       child: Text(
//                                         "Sign Up",
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w600,
//                                             color: AppColors.primaryColor),
//                                       ),
//                                     )
//                                   ])
//                             ]),
//                       ]),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
