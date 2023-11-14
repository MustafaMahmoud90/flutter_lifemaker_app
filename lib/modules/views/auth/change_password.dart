import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifemaker/modules/views/auth/cubit/auth_cubit.dart';
import 'package:lifemaker/modules/views/auth/input_theme.dart';
import 'package:lifemaker/modules/views/auth/login.dart';
import 'package:lifemaker/modules/widgets/btn_theme.dart';
import 'package:lifemaker/modules/widgets/component.dart';

class ChangePasswordScreen extends StatelessWidget {
  final passwordOneController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final dynamic userId;
  final dynamic token;

  final formKey = GlobalKey<FormState>();
  ChangePasswordScreen({super.key, required this.userId, this.token});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 10.0),
                        TextButton(
                          style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.zero)),
                          onPressed: () {
                            // navigateTo(context, ChangePasswordScreen());
                          },
                          child: const Text(
                            'تغيير كلمة السر',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0E395E),
                            ),
                          ),
                        ),
                        Form(
                            key: formKey,
                            child: Column(
                              children: [
                                const SizedBox(height: 16.0),

                                FormTheme(
                                  controller: passwordOneController,
                                  icon: CupertinoIcons.lock,
                                  hintText: "كلمة السر الجديدة",
                                  type: TextInputType.text,
                                  isPassword: true,
                                ),

                                const SizedBox(height: 16.0),
                                FormTheme(
                                  controller: passwordConfirmController,
                                  icon: CupertinoIcons.lock,
                                  hintText: "تأكيد كلمة المرور",
                                  type: TextInputType.text,
                                  isPassword: true,
                                ),

                                // SizedBox(height: 10.0),

                                const SizedBox(height: 15.0),
                                TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate() ==
                                        true) {
                                      BlocProvider.of<AuthCubit>(context)
                                          .changePassword(
                                              password:
                                                  passwordOneController.text,
                                              passwordConfirmation:
                                                  passwordConfirmController
                                                      .text,
                                              token: token);
                                    }
                                  },
                                  child: Center(
                                    child: state is ChangePasswordLoadingState
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
                                        : state is FailedToChangePasswordState
                                            ? const BtnTheme(
                                                text: 'تسجيل',
                                                color: Color(0xffE9791E))
                                            : const BtnTheme(
                                                text: 'تسجيل',
                                                color: Color(0xffE9791E)),
                                  ),
                                ),
                              ],
                            )),
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
        if (state is ChangePasswordSuccessState) {
          await Future.delayed(
              const Duration(seconds: 2)); // Add a 2-second delay
          if(context.mounted)
            {
              navigateAndFinish(context, LoginScreen());
            }
        } else if (state is FailedToChangePasswordState) {
          AwesomeDialog(
            context: context,
            dialogType:
                DialogType.error, // You can choose the dialog type you prefer
            animType: AnimType.scale,
            title: 'يرجي التأكد من كلمة السر',
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
