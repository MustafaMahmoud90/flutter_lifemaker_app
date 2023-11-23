import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifemaker/modules/views/auth/cubit/auth_cubit.dart';
import 'package:lifemaker/modules/views/auth/input_theme.dart';
import 'package:lifemaker/modules/views/auth/password_reset.dart';
import 'package:lifemaker/modules/views/auth/registeration.dart';
import 'package:lifemaker/modules/widgets/btn_theme.dart';
import 'package:lifemaker/modules/widgets/component.dart';
import 'package:lifemaker/modules/widgets/layout.dart';

import '../../../services/firebase/notifications/firebase_notification.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    super.initState();
    FirebaseCustomNotification.setUpFirebase();

  }
  final userNameController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
                    height: 350,
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/icons/7.png',
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
                        // const SizedBox(height: 30.0),
                        Text(
                          'اهلًا بعودتك',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(height: 10.0),
                        TextButton(
                          style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.zero)),
                          onPressed: () {
                            // navigateTo(context, LoginScreen());
                          },
                          child: const Text(
                            'تسجيل دخول',
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
                                  controller: userNameController,
                                  icon: CupertinoIcons.person,
                                  hintText: "اسم المستخدم",
                                  type: TextInputType.multiline,
                                ),

                                const SizedBox(height: 16.0),
                                FormTheme(
                                  controller: passwordController,
                                  icon: CupertinoIcons.lock,
                                  hintText: "كلمة المرور",
                                  type: TextInputType.text,
                                  isPassword: true,
                                ),

                                // SizedBox(height: 10.0),
                                TextButton(
                                  onPressed: () {
                                    navigateTo(context, ResetPasswordScreen());
                                  },
                                  child: Text(
                                    'نسيت كلمة المرور',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 0.0),
                                TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate() ==
                                        true) {
                                      BlocProvider.of<AuthCubit>(context).login(
                                          username: userNameController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  child: Center(
                                    child: state is LoginLoadingState
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
                                            text: 'تسجيل',
                                            color: Color(0xffE9791E)),
                                  ),
                                ),
                                Center(
                                  child: TextButton(
                                    style: const ButtonStyle(
                                        alignment: Alignment.center),
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              const Duration(milliseconds: 200),
                                          reverseTransitionDuration:
                                              const Duration(milliseconds: 200),
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              const RegistrationScreen(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return const ZoomPageTransitionsBuilder()
                                                .buildTransitions(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const RegistrationScreen()),
                                              context,
                                              animation,
                                              secondaryAnimation,
                                              child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'ليس لديك حساب؟ انشاء حساب',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff0E395E),
                                          decoration: TextDecoration.underline),
                                    ),
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
        if (state is LoginSuccessState) {
          await Future.delayed(
              const Duration(seconds: 2)); // Add a 2-second delay
          if (context.mounted) {
            navigateAndFinish(context, const LayoutMaker());
          }
        } else if (state is FailedToLoginState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            // You can choose the dialog type you prefer
            animType: AnimType.scale,
            title: 'خطأ في التسجيل',
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
