import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifemaker/modules/views/auth/cubit/auth_cubit.dart';
import 'package:lifemaker/modules/views/auth/input_theme.dart';
import 'package:lifemaker/modules/views/auth/otp_reset.dart';
import 'package:lifemaker/modules/widgets/btn_theme.dart';
import 'package:lifemaker/modules/widgets/component.dart';

class ResetPasswordScreen extends StatelessWidget {
  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  ResetPasswordScreen({super.key});

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        const SizedBox(height: 10.0),
                        TextButton(
                          style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.zero)),
                          onPressed: () {
                            // navigateTo(context, ResetPasswordScreen());
                          },
                          child: const Text(
                            'هل نسيت كلمة السر؟',
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
                                  controller: phoneController,
                                  icon: CupertinoIcons.phone,
                                  hintText: "الرقم المستخدم في التسجيل",
                                  type: TextInputType.phone,
                                ),
                                const SizedBox(height: 15),
                                TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate() ==
                                        true) {
                                      BlocProvider.of<AuthCubit>(context)
                                          .resetPassword(
                                              phone: phoneController.text);
                                    }
                                  },
                                  child: Center(
                                    child: state is ResetPasswordLoadingState
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
                                        : const BtnTheme(
                                            text: 'أرسال',
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
        if (state is ResetPasswordSuccessState) {
          await Future.delayed(
              const Duration(seconds: 2)); // Add a 2-second delay
         if(context.mounted)
           {
             navigateTo(
                 context,
                 OTPForResetScreen(
                   userId: state.userId,
                 ));
           }
        } else if (state is FailedToResetPasswordState) {
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
