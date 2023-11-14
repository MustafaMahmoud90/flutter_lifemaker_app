import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifemaker/modules/views/auth/cubit/auth_cubit.dart';
import 'package:lifemaker/modules/views/auth/input_theme.dart';
import 'package:lifemaker/modules/views/auth/login.dart';
import 'package:lifemaker/modules/widgets/btn-theme.dart';
import 'package:lifemaker/modules/widgets/component.dart';
import 'package:lifemaker/modules/widgets/layout.dart';
import 'package:lifemaker/repo/shared/constans/constans.dart';
import 'package:lifemaker/repo/shared/network/local_network.dart';

class OTPScreen extends StatelessWidget {
  final OTPController = TextEditingController();
  final userId;
  final userOldId;
  final formKey = GlobalKey<FormState>();

  OTPScreen({super.key, required this.userId, this.userOldId});

  @override
  Widget build(BuildContext context) {
    print("===================");
    print("user Id is $userId");
    print("===================");
    return BlocConsumer<AuthCubit, AuthStates>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.only(top: 50),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 350,
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/icons/10.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const SizedBox(height: 20.0),
                        const Text(
                          "سيتم ارسال رمز التأكيد",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              // color: Colors.grey[400],
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20.0),
                        Form(
                          key: formKey,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            // child: OtpTextField(
                            //   numberOfFields: 4,
                            //   fieldWidth: 60,
                            //   textStyle: TextStyle(fontSize: 20),
                            //   clearText: false,
                            //   handleControllers: (controllers) => OTPController,
                            //   borderRadius: BorderRadius.circular(14),
                            //   borderColor: Color.fromARGB(255, 6, 189, 235),
                            //   //set to true to show as box or false to show as dash
                            //   showFieldAsBox: false,
                            //   //runs when a code is typed in
                            //   onCodeChanged: (String code) {
                            //     //handle validation or checks here
                            //   },
                            //   //runs when every textfield is filled
                            //   onSubmit: (String verificationCode) {
                            //     // showDialog(
                            //     //     context: context,
                            //     //     builder: (context) {
                            //     //       return AlertDialog(
                            //     //         // title: Text(""),

                            //     //         content: Text(
                            //     //             'الكود المدخل هو $verificationCode'),
                            //     //       );
                            //     //     });
                            //     if (formKey.currentState!.validate() == true) {
                            //       BlocProvider.of<AuthCubit>(context)
                            //           .sendVerificationCode(
                            //               code: OTPController.text,
                            //               userId: userId);
                            //     }
                            //   }, // end onSubmit
                            // ),
                            child: FormTheme(
                              controller: OTPController,
                              icon: CupertinoIcons
                                  .person_crop_circle_fill_badge_checkmark,
                              hintText: "أدخال الرمز",
                              type: TextInputType.number,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Center(
                          child: TextButton(
                            style:
                                const ButtonStyle(alignment: Alignment.center),
                            onPressed: () {
                              BlocProvider.of<AuthCubit>(context)
                                  .ResendVerificationCode(userId: userId);
                            },
                            child: state is OTPResendLoadingState
                                ? Container(
                                    width: 50,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        right: 0, left: 0),
                                    // padding: const EdgeInsets.symmetric(
                                    //     vertical: 15, horizontal: 30),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffE9791E),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Transform.scale(
                                      scale: 0.5,
                                      child: const CircularProgressIndicator(
                                        strokeCap: StrokeCap.butt,
                                        // backgroundColor: AppColor.white,
                                        // strokeWidth: 2,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                  )
                                : state is OTPResendSuccessState
                                    ? Container(
                                        width: 50,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(
                                            right: 0, left: 0),
                                        // padding: const EdgeInsets.symmetric(
                                        //     vertical: 15, horizontal: 30),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffE9791E),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Transform.scale(
                                          scale: 0.5,
                                          child:
                                              const CircularProgressIndicator(
                                            strokeCap: StrokeCap.butt,
                                            // backgroundColor: AppColor.white,
                                            // strokeWidth: 2,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        'لم يتم الارسال؟ اعادة ارسال',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff0E395E),
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate() == true) {
                              BlocProvider.of<AuthCubit>(context)
                                  .sendVerificationCode(
                                      code: OTPController.text, userId: userId);
                            }
                          },
                          child: Center(
                            child: state is OTPLoadingState
                                ? Container(
                                    width: 50,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        right: 0, left: 0),
                                    // padding: const EdgeInsets.symmetric(
                                    //     vertical: 15, horizontal: 30),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffE9791E),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Transform.scale(
                                      scale: 0.5,
                                      child: const CircularProgressIndicator(
                                        strokeCap: StrokeCap.butt,
                                        // backgroundColor: AppColor.white,
                                        // strokeWidth: 2,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                  )
                                : const BtnTheme(
                                    text: 'تأكيد الرمز',
                                    color: Color(0xffE9791E)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) async {
        var userToken = await CacheNetwork.getCacheData(key: "token");
        if (state is OTPSuccessState) {
          print(userToken);
          await Future.delayed(
              const Duration(seconds: 2)); // Add a 2-second delay
          navigateAndFinish(context, LoginScreen());
        } else if (state is OTPFieldState) {
          AwesomeDialog(
            context: context,
            dialogType:
                DialogType.ERROR, // You can choose the dialog type you prefer
            animType: AnimType.SCALE,
            title: 'خطأ في تسجيل الكود',
            desc: state.message,
            btnOkOnPress: () {},
            btnCancelOnPress: () {},
            btnOkColor: const Color(0xff0E395E),
            btnCancelColor: const Color(0xff0E395E),
            btnOkText: 'إعادة إدخال',
            btnCancelText: 'إلغاء',
          ).show();
        }
      },
    );
  }
}
