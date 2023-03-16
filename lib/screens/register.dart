import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../dialog/Error_dialog.dart';

import '../dialog/account_create_dialog.dart';

import '../util/color_catagory.dart';
import '../util/constatnt_widget.dart';
import '../util/sizeconfig.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passswordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  // String confirmPass = '';
  String pass = '';
  String username = '';
  // bool? taylorValue = true;
  // bool? customervalue = false;
  // String error = '';
  Future<void> register() async {
    setState(() {
      loading = true;
    });
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passswordController.text,
      )
          .then((value) async {
        final user = await FirebaseFirestore.instance
            .collection('tailors')
            .doc(emailController.text);
        final x = {
          'shopimage':
              'https://firebasestorage.googleapis.com/v0/b/darzi-on-marzi.appspot.com/o/products%2Fshop_tre1.png?alt=media&token=9bf09e03-26d7-45d5-843c-4687062befdf',
          'username': nameController.text,
        };
        await user.set(x).then((value) {
          setState(() {
            loading = false;
            FirebaseAuth.instance.signOut();
            Get.dialog(AccountCreateDialog());
          });
        });
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-email') {
        setState(() {
          loading = false;
        });
        Get.dialog(ErrorDialog(
          title: 'invalid-email',
          message: 'The email address is badly formatted',
        ));
      } else if (e.code == 'weak-password') {
        setState(() {
          loading = false;
        });
        Get.dialog(ErrorDialog(
          title: 'weak password',
          message: 'The password provided is too weak.',
        ));
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          loading = false;
        });
        Get.dialog(ErrorDialog(
          title: 'email-already-in-use',
          message: 'The account already exists for that email.',
        ));
      } else {
        setState(() {
          loading = false;
        });
        Get.dialog(ErrorDialog(
          title: 'Unable to Register',
          message: 'Something went wrong',
        ));
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      Get.dialog(ErrorDialog(
        title: 'Unable to Register',
        message: 'Something went wrong',
      ));

      print(e);
    }
  }

  Future<void> registerCustomer() async {
    setState(() {
      loading = true;
    });

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passswordController.text,
      )
          .then((value) async {
        final user = await FirebaseFirestore.instance
            .collection('customers')
            .doc(emailController.text);
        final x = {
          'date': DateTime.now(),
          'email': emailController.text,
          'role': 'customer',
          'username': nameController.text,
        };
        await user.set(x).then((value) {
          setState(() {
            loading = false;
            FirebaseAuth.instance.signOut();
            Get.dialog(AccountCreateDialog());
          });
        });
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-email') {
        setState(() {
          loading = false;
        });
        Get.dialog(ErrorDialog(
          title: 'invalid-email',
          message: 'The email address is badly formatted',
        ));
      } else if (e.code == 'weak-password') {
        setState(() {
          loading = false;
        });
        Get.dialog(ErrorDialog(
          title: 'weak password',
          message: 'The password provided is too weak.',
        ));
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          loading = false;
        });
        Get.dialog(ErrorDialog(
          title: 'email-already-in-use',
          message: 'The account already exists for that email.',
        ));
      } else {
        setState(() {
          loading = false;
        });
        Get.dialog(ErrorDialog(
          title: 'Unable to Register',
          message: 'Something went wrong',
        ));
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      Get.dialog(ErrorDialog(
        title: 'Unable to Register',
        message: 'Something went wrong',
      ));

      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //  final AuthProvider _auth = AuthProvider();
    // final authProvider = Provider.of<AuthProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SizeConfig().init(context);
    return loading
        ? Scaffold(
            backgroundColor: bgWhite,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                children: [
                  getVerSpace(20.h),
                  Center(
                    child: getCustomFont(
                        'Trending tailors', 22.sp, Colors.black, 1,
                        fontWeight: FontWeight.w700),
                  ),
                  getVerSpace(300.h),
                  CircularProgressIndicator(
                    color: bgColor,
                  ),
                  getVerSpace(10.h),
                  getCustomFont(
                      'getting tailors please wait...', 12.sp, Colors.black, 1,
                      fontWeight: FontWeight.w700)
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: bgWhite,
            resizeToAvoidBottomInset: false,
            body: Container(
                color: bgColor,
                child: SafeArea(
                    bottom: false,
                    child: Container(
                        width: double.infinity,
                        color: bgColor,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getVerSpace(20.h),
                              GestureDetector(
                                onTap: () {
                                  // backClick();
                                },
                                child: getSvgImage("arrow_left.svg",
                                        height: 24.h, width: 24.h)
                                    .paddingSymmetric(horizontal: 20.h),
                              ),
                              getVerSpace(16.h),
                              getCustomFont("Sign Up", 34.sp, Colors.black, 1,
                                      fontWeight: FontWeight.w700,
                                      txtHeight: 1.5.h)
                                  .paddingSymmetric(horizontal: 20.h),
                              getVerSpace(4.h),
                              getMultilineCustomFont(
                                      "Enter your detail for sign up!",
                                      16.sp,
                                      Colors.black,
                                      fontWeight: FontWeight.w400,
                                      txtHeight: 1.5.h)
                                  .paddingSymmetric(horizontal: 20.h),
                              getVerSpace(24.h),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.h),
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
                                        getVerSpace(40.h),

                                        getDefaultTextFiledWithLabel(context,
                                            "Enter name", nameController,
                                            isEnable: false,
                                            height: 56.h,
                                            withprefix: true,
                                            image: "profile.svg"),

                                        getVerSpace(30.h),
                                        getDefaultTextFiledWithLabel(
                                            context,
                                            "Enter email address",
                                            emailController,
                                            isEnable: false,
                                            height: 56.h,
                                            withprefix: true,
                                            image: "profile.svg"),

                                        // getPhoneTextField(context, "Phone number",
                                        //     phoneController,
                                        //     isEnable: false,
                                        //     height: 56.h,
                                        //     keyboardType: TextInputType.number,
                                        //     inputFormatters: [
                                        //       // FilteringTextInputFormatter.digitsOnly
                                        //     ],
                                        //     withprefix: true,
                                        //     image: SizedBox(
                                        //       height: 24.h,
                                        //       width: 60.h,
                                        //       child: CountryCodePicker(
                                        //         onChanged: print,
                                        //         initialSelection: 'PK',
                                        //         flagWidth: 24.h,
                                        //         padding: EdgeInsets.zero,
                                        //         textStyle: TextStyle(
                                        //             color: hintColor,
                                        //             fontWeight: FontWeight.w400,
                                        //             fontSize: 16.sp),
                                        //         favorite: const ['+91', 'IN'],
                                        //         showCountryOnly: false,
                                        //         showDropDownButton: false,
                                        //         showOnlyCountryWhenClosed: false,
                                        //         alignLeft: false,
                                        //       ),
                                        //     )),
                                        getVerSpace(30.h),
                                        getDefaultTextFiledWithLabel(context,
                                            "Password", passswordController,
                                            isEnable: false,
                                            height: 56.h,
                                            withprefix: true,
                                            image: "lock.svg",
                                            withSufix: true,
                                            suffiximage: "eye.svg"),
                                        getVerSpace(20.h),

                                        getVerSpace(120.h),
                                        getButton(context, buttonColor,
                                            "Sign up", Colors.white, () {
                                          if (emailController.text == '' ||
                                              passswordController.text == '' ||
                                              nameController.text == '') {
                                            Get.dialog(ErrorDialog(
                                              title: 'Unable to Register',
                                              message:
                                                  'please enter all fields',
                                            ));
                                          } else {
                                            register();
                                          }
                                          // Constant.sendToNext(
                                          //     context, Routes.verifyScreenRoute);
                                        }, 18.sp,
                                            weight: FontWeight.w600,
                                            buttonHeight: 60.h,
                                            borderRadius:
                                                BorderRadius.circular(22.h)),
                                        getVerSpace(93.h),
                                        getTwoRichText(
                                            "Already have an account? ",
                                            Colors.black,
                                            FontWeight.w400,
                                            16.sp,
                                            "Login",
                                            buttonColor,
                                            FontWeight.w700,
                                            16.sp,
                                            txtHeight: 1.5.h, function: () {
                                          Navigator.pop(context);
                                          // Navigator.of(context).pushNamed('/Login');
                                          // Constant.sendToNext(context, Routes.loginRoute);
                                        })
                                      ],
                                    ),
                                  ))
                            ]))))

            // backgroundColor: AppColors.primaryShade1,
            // appBar: AppBar(
            //   backgroundColor: AppColors.primaryShade1,
            //   elevation: 0,
            //   leading: SizedBox(
            //     width: 25,
            //     height: 25,
            //     child: IconButton(
            //       icon: const Icon(
            //         Icons.arrow_back,
            //         size: 30,
            //       ),
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //     ),
            //   ),
            // ),
            // body: SingleChildScrollView(
            //   child: SizedBox(
            //     height: height,
            //     width: width,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 25),
            //           child: SizedBox(
            //             height: SizeConfig.screenHeight * 0.15,
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   "Sign Up",
            //                   style: TextStyle(
            //                       color: AppColors.textBlack,
            //                       fontSize: 50,
            //                       fontWeight: FontWeight.w900),
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 Text(
            //                   "Enter your details for sign up!",
            //                   style: TextStyle(
            //                       color: AppColors.textBlack,
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w400),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           child: Container(
            //             height: SizeConfig.screenHeight * 0.7,
            //             width: SizeConfig.screenWidth,
            //             padding:
            //                 const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
            //             decoration: const BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.only(
            //                     topLeft: Radius.circular(50),
            //                     topRight: Radius.circular(50))),
            //             child: Column(children: [
            //               Form(
            //                 key: formkey,
            //                 child: Column(children: [
            //                   TextFormField(
            //                     onChanged: (value) {
            //                       setState(() {
            //                         username = value;
            //                       });
            //                     },
            //                     validator: (value) =>
            //                         value!.isEmpty ? "Enter Username" : null,
            //                     decoration: InputDecoration(
            //                       hintText: 'Username',
            //                       border: OutlineInputBorder(
            //                         borderRadius: BorderRadius.circular(10.0),
            //                         borderSide: const BorderSide(color: Colors.white),
            //                       ),
            //                       hintStyle:
            //                           const TextStyle(color: Color(0xff8391A1)),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     height: height * .012,
            //                   ),
            //                   TextFormField(
            //                     onChanged: (value) {
            //                       setState(() {
            //                         email = value;
            //                       });
            //                     },
            //                     validator: (value) =>
            //                         value!.isEmpty ? "Enter an Email" : null,
            //                     decoration: InputDecoration(
            //                       hintText: 'Email adress',
            //                       border: OutlineInputBorder(
            //                         borderRadius: BorderRadius.circular(10.0),
            //                         borderSide: const BorderSide(color: Colors.white),
            //                       ),
            //                       hintStyle:
            //                           const TextStyle(color: Color(0xff8391A1)),
            //                     ),
            //                   ),
            //                 ]),
            //               ),
            //               SizedBox(
            //                 height: height * .012,
            //               ),
            //               TextFormField(
            //                 validator: (value) =>
            //                     value!.length < 6 ? "Enter Password 6+ words" : null,
            //                 decoration: InputDecoration(
            //                     hintText: 'Password',
            //                     border: OutlineInputBorder(
            //                       borderRadius: BorderRadius.circular(10.0),
            //                       borderSide: const BorderSide(color: Colors.white),
            //                     ),
            //                     hintStyle: const TextStyle(color: Color(0xff8391A1))),
            //                 obscureText: true,
            //                 onChanged: ((value) {
            //                   setState(() {
            //                     pass = value;
            //                   });
            //                 }),
            //               ),
            //               const SizedBox(
            //                 height: 10,
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Radio(
            //                     value: 'tailor',
            //                     groupValue: val,
            //                     onChanged: (value) {
            //                       setState(() {
            //                         val = value!;
            //                       });
            //                     },
            //                   ),
            //                   const Text(
            //                     'Tailor',
            //                     style: TextStyle(
            //                       fontSize: 20.0,
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: width * .09,
            //                   ),
            //                   Radio(
            //                     value: 'customer',
            //                     groupValue: val,
            //                     onChanged: (value) {
            //                       setState(() {
            //                         val = value!;
            //                       });
            //                     },
            //                   ),
            //                   const Text(
            //                     'Customer',
            //                     style: TextStyle(
            //                       fontSize: 20.0,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: height * 0.02,
            //               ),
            //               SizedBox(
            //                   width: double.infinity,
            //                   child: ElevatedButton(
            //                     onPressed: () async {
            //                       if (formkey.currentState!.validate()) {
            //                         await authProvider.signupWithEmailAndPass(
            //                             email: email,
            //                             pass: pass,
            //                             username: username,
            //                             context: context,
            //                             role: val.toString());
            //                       }
            //                       // Navigator.of(context)
            //                       //     .pushNamed(BottomBarScreen.routeName);
            //                     },
            //                     style: ElevatedButton.styleFrom(
            //                         shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.circular(25.0),
            //                         ),
            //                         minimumSize: const Size(0, 60),
            //                         backgroundColor: AppColors.primaryColor),
            //                     child: const Text(
            //                       "Sign Up",
            //                       style: TextStyle(
            //                           fontSize: 20,
            //                           fontWeight: FontWeight.w600,
            //                           letterSpacing: 1.5),
            //                     ),
            //                   )),
            //               Align(
            //                 widthFactor: 10,
            //                 heightFactor: 7,
            //                 alignment: Alignment.bottomCenter,
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     const Text(
            //                       "Already have an account?",
            //                       style: TextStyle(
            //                           fontSize: 18,
            //                           fontWeight: FontWeight.w600,
            //                           color: Colors.black54),
            //                     ),
            //                     const SizedBox(
            //                       width: 5,
            //                     ),
            //                     InkWell(
            //                       onTap: () {
            //                         Navigator.of(context).pop();
            //                       },
            //                       child: Text(
            //                         "login",
            //                         style: TextStyle(
            //                             fontSize: 18,
            //                             fontWeight: FontWeight.w600,
            //                             color: AppColors.primaryColor),
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               )
            //             ]),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            );
  }
}
