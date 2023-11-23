import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifemaker/modules/views/auth/cubit/auth_cubit.dart';
import 'package:lifemaker/modules/views/auth/input_theme.dart';
import 'package:lifemaker/modules/views/auth/login.dart';
import 'package:lifemaker/modules/views/auth/otp.dart';
import 'package:lifemaker/modules/widgets/btn_theme.dart';
import 'package:lifemaker/modules/widgets/utils.dart';

import '../../../services/firebase/notifications/firebase_notification.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseCustomNotification.setUpFirebase();

  }
  final nameController = TextEditingController();

  final userNameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final phoneController = TextEditingController();

  final whatsappNumberController = TextEditingController();

  final idCardNumberController = TextEditingController();

  final theJobController = TextEditingController();

  final theAddressController = TextEditingController();

  final governorateController = TextEditingController();

  final cityCenterController = TextEditingController();

  final previousExperienceController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<String> governoratesList = [
    "الإسكندرية",
    "الإسماعيلية",
    "أسوان",
    "أسيوط",
    "الأقصر",
    "	البحر الأحمر",
    "البحيرة",
    "بني سويف	",
    "بورسعيد",
    "جنوب سيناء",
    "الجيزة",
    "الدقهلية",
    "دمياط",
    "سوهاج",
    "السويس",
    "الشرقية",
    "شمال سيناء",
    "الغربية",
    "الفيوم",
    "القاهرة",
    "القليوبية",
    "قنا",
    "كفر الشيخ",
    "مطروح",
    "المنوفية",
    "المنيا",
    "الوادي الجديد",
    // Add more governorates here
  ];
  String selectedGovernorate = ""; // Initialize it with an empty string

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) async {
        if (state is RegisterSuccessState) {
          await Future.delayed(
              const Duration(seconds: 2)); // Add a 2-second delay

          if (mounted) {
            navigateTo(
                context,
                OTPScreen(
                  userId: state.userId,
                ));
          }
        } else if (state is FailedToRegisterState) {
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
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.only(top: 30),
            height: double.infinity,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 350,
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
                        const Text(
                          'انشاء حساب',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(height: 10.0),
                        TextButton(
                          style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.zero)),
                          onPressed: () {
                            navigateTo(context, LoginScreen());
                          },
                          child: const Text(
                            'لديك حساب؟ تسجيل دخول',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0E395E),
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FormTheme(
                                  controller: nameController,
                                  icon: CupertinoIcons.person,
                                  hintText: "الأسم",
                                  type: TextInputType.text,
                                ),
                                const SizedBox(height: 16.0),
                                FormTheme(
                                  controller: userNameController,
                                  icon: CupertinoIcons.person_alt_circle,
                                  hintText: "اسم المستخدم",
                                  type: TextInputType.text,
                                ),
                                const SizedBox(height: 16.0),
                                FormTheme(
                                  controller: emailController,
                                  icon: CupertinoIcons.envelope,
                                  hintText: "البريد الالكتروني",
                                  type: TextInputType.emailAddress,
                                ),

                                const SizedBox(height: 16.0),
                                FormTheme(
                                  controller: passwordController,
                                  icon: CupertinoIcons.lock,
                                  hintText: "كلمة المرور",
                                  type: TextInputType.text,
                                  isPassword: true,
                                ),
                                // SizedBox(height: 16.0),
                                // FormTheme(
                                //   controller: passwordController,
                                //   icon: CupertinoIcons.lock,
                                //   hintText: "تأكيد كلمة المرور",
                                //   type: TextInputType.text,
                                //   isPassword: true,
                                // ),
                                const SizedBox(height: 16.0),
                                FormTheme(
                                  controller: phoneController,
                                  icon: CupertinoIcons.phone,
                                  hintText: "رقم الهاتف",
                                  type: TextInputType.phone,
                                ),
                                // const SizedBox(height: 16.0),
                                // FormTheme(
                                //   controller: whatsapp_numberController,
                                //   icon: CupertinoIcons.chat_bubble,
                                //   hintText: "رقم واتسآب",
                                //   type: TextInputType.phone,
                                // ),
                                // const SizedBox(height: 16.0),
                                // //
                                // FormTheme(
                                //   controller: id_card_numberController,
                                //   icon: CupertinoIcons.creditcard,
                                //   hintText: "رقم البطاقة",
                                //   type: TextInputType.number,
                                // ),
                                // const SizedBox(height: 16.0),
                                // FormTheme(
                                //   controller: the_jobController,
                                //   icon: CupertinoIcons.bag,
                                //   hintText: "العمل",
                                //   type: TextInputType.text,
                                // ),
                                // const SizedBox(height: 16.0),
                                // FormTheme(
                                //   controller: the_addressController,
                                //   icon: CupertinoIcons.location_solid,
                                //   hintText: "العنوان",
                                //   type: TextInputType.text,
                                // ),
                                const SizedBox(height: 16.0),
                                Row(
                                  children: [
                                    // Expanded(
                                    //   child: FormTheme(
                                    //     controller: governorateController,
                                    //     icon: CupertinoIcons.location_circle,
                                    //     hintText: "محافظة",
                                    //     type: TextInputType.text,
                                    //   ),
                                    // ),
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        isExpanded: true,
                                        alignment: Alignment.center,
                                        icon: Container(
                                          margin:
                                              const EdgeInsets.only(left: 7),
                                          child: const Icon(
                                            CupertinoIcons.chevron_down,
                                            size: 20,
                                          ),
                                        ),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Alamiri',
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          hintText: "محافظة",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          fillColor: const Color(0xff0E395E),
                                          focusColor: const Color(0xff0E395E),
                                          hintStyle: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xffD6D6D6)),
                                          contentPadding: const EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          prefixIcon: const Icon(
                                            CupertinoIcons.location_solid,
                                            color: Color(0xff0E395E),
                                          ),
                                        ),
                                        items:
                                            governoratesList.map((governorate) {
                                          return DropdownMenuItem<String>(
                                            value: governorate,
                                            child: Text(governorate),
                                          );
                                        }).toList(),
                                        onChanged: (selectedValue) {
                                          setState(() {
                                            selectedGovernorate =
                                                selectedValue!;
                                          });
                                        },
                                        // validator: (value) {
                                        //   if (value == null || value.isEmpty) {
                                        //     return "يجب ادخال المحافظة";
                                        //   } else {
                                        //     return null;
                                        //   }
                                        // },
                                      ),
                                    ),
                                    // const SizedBox(width: 16.0),
                                    // Expanded(
                                    //   child: FormTheme(
                                    //     controller: city_centerController,
                                    //     icon: CupertinoIcons.location_solid,
                                    //     hintText: "مركز",
                                    //     type: TextInputType.text,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                // FormTheme(
                                //   controller: previous_experienceController,
                                //   icon: CupertinoIcons.bag,
                                //   hintText: "الخبرة السابقة",
                                //   type: TextInputType.text,
                                // ),
                                const SizedBox(height: 16.0),
                                TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      BlocProvider.of<AuthCubit>(context)
                                          .register(
                                        email: emailController.text,
                                        name: nameController.text,
                                        userName: userNameController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text,
                                        cityCenter: cityCenterController.text,
                                        governorate: selectedGovernorate,
                                        idCardNumber:
                                            idCardNumberController.text,
                                        whatsAppNumber:
                                            whatsappNumberController.text,
                                        theJob: theJobController.text,
                                        theAddress: theAddressController.text,
                                        previousExperience:
                                            previousExperienceController.text,
                                      );
                                    }
                                  },
                                  child: Center(
                                    child: state is RegisterLoadingState
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
                                            text: 'انشاء حساب',
                                            color: Color(0xffE9791E)),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
