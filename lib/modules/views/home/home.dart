// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifemaker/about/about_screen.dart';
import 'package:lifemaker/about/other_means.dart';
import 'package:lifemaker/modules/views/terms/terms.dart';
import 'package:lifemaker/modules/views/voating/voters.dart';
import 'package:lifemaker/modules/views/voating/voters_for_details.dart';
import 'package:lifemaker/modules/widgets/cards.dart';
import 'package:lifemaker/modules/widgets/custom_popup.dart';
import 'package:lifemaker/modules/widgets/utils.dart';
import 'package:lifemaker/repo/layout/cubit/layout_cubit.dart';
import 'package:lifemaker/repo/shared/constans/constans.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../about/about_info.dart';

class HomeScreen extends StatelessWidget {
  final bool? isVooted;
  const HomeScreen({Key? key, this.isVooted});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              topLeft: Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(155, 0, 0, 0),
                  blurRadius: 10,
                  offset: Offset(-5, -5),
                  spreadRadius: -3),
            ],
            // borderRadius: BorderRadius.circular(20),
          ),
          child: GridView.count(
            crossAxisCount: 2, // Number of cards in each row
            shrinkWrap: true,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20,
            // childAspectRatio: 1,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              GestureDetector(
                onTap: () async {
                  var isUserOld = await cubit.prefServices.getInteger(isOld);
                  // Redirect to another screen (e.g., VotersScreen)

                  if (cubit.userModal!.old == 0) {
                    navigateTo(context, const VotersForDetailScreen());
                  } else {
                    if (cubit.userModal!.isVoted == true) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType
                            .warning, // You can choose the dialog type you prefer
                        animType: AnimType.SCALE,
                        titleTextStyle: const TextStyle(fontWeight: FontWeight.w700),
                        title: 'لقد قمت بالإنتخاب بالفعل',
                        // desc: "state.message",
                        reverseBtnOrder: true,
                        btnOkColor: const Color(0xff0E395E),
                        btnCancelColor: const Color(0xff0E395E),
                        // btnOkText: 'إعادة إدخال',
                        // btnCancelText: 'إلغاء',
                      ).show();
                    } else {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      bool modalShown = prefs.getBool('modal_shown') ?? false;
                      if (!modalShown) {
                        // Show the modal for the first time
                        // await CacheNetwork.getCacheData(key: key);
                        showModalBottomSheet(
                          enableDrag: true,
                          isScrollControlled: true,
                          isDismissible: true,
                          useSafeArea: true,
                          context: context,
                          showDragHandle: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return CustomPopup(
                              title:
                                  'إنتخابات مجلس إدارة متطوعين مؤسسة صناع الحياة المصرية',
                              subTitle:
                                  ' القواعد الواجب إتباعها في العملية الإنتخابية :',
                              content: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const TermsWidget(
                                      text:
                                          "يرجى إدخال رقم البطاقة ورقم الموبايل للمرشحين"),
                                  const TermsWidget(
                                      text:
                                          " يرجى تسجيل رقم التحقق OTP الذي يتم إرسالة على رقم هاتفك SMS "),
                                  const TermsWidget(
                                      text:
                                          "يرجى العلم أن التسجيل يتم مرة واحدة فقط ولا يسمح بإجراء تعديلات"),
                                  const TermsWidget(
                                      text:
                                          "يرجى التأكد من إدخال رقم البطاقة ورقم الهاتف المتطابقين مع كشف العضوية للتمكن من الدخول وإجراء العملية الإنتخابية بشكل صحيح"),
                                  const TermsWidget(
                                      text:
                                          "في حالة طلب المساعدة يرجى الإتصال على الأرقام التالية"),
                                  const SizedBox(height: 20),
                                  const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '01063301119',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        '-',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        '01063301119',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        '-',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        '01063301119',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () async {
                                      prefs.setBool('modal_shown', true);
                                      Navigator.of(context)
                                          .pop(); // Close the modal
                                      var isUserOld = await cubit.prefServices
                                          .getInteger(isOld);
                                      // Redirect to another screen (e.g., VotersScreen)
                                      if (isUserOld == 0) {
                                        navigateTo(context,
                                            const VotersForDetailScreen());
                                      } else {
                                        navigateTo(
                                            context, const VotersScreen());
                                      }
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 30),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffE9791E),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'للموافقة اضغط إنتهاء',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        navigateTo(context, const VotersScreen());
                      }
                    }
                  }
                },
                child: const AboutWidget(
                  image: AssetImage('assets/logo1.png'),
                  image2: AssetImage("assets/icons/19.png"),
                  text: 'إنتخابات مجلس إدارة متطوعين',
                  isAvilable: true,
                ),
              ),
              InkWell(
                onTap: ()=>  navigateTo(context,  AboutScreen()),
                child: const AboutWidget(
                  image: AssetImage('assets/logo3.png'),
                  image2: AssetImage("assets/logo3.png"),
                  text:  "قصص نجاح المتطوعيين",
                  isAvilable: true,
                ),
              ),
               InkWell(
                onTap: ()=>  navigateTo(context,  const AboutInfo()),
                child: const InfoWidget(
                  image: AssetImage('assets/logo2.png'),
                  image2: AssetImage('assets/logo2.png'),
                  text:  "من نحن",
                  isAvilable: true,
                ),
              ),
              InkWell(
                onTap: ()=>  navigateTo(context,  const OtherMeans()),
                child: const OtherMeansWidgets(
                  image: AssetImage('assets/logo4.png'),
                  image2: AssetImage("assets/logo4.png"),
                  text:  "وسائل التبرع",
                  isAvilable: true,
                ),
              ),
              //   const CardWidget(
              //   image: AssetImage('assets/icons/3.png'),
              //   image2: AssetImage("assets/icons/13.png"),
              //   text: 'مجلس ادارة المتطوعين',
              //   isAvilable: false,
              // ),
              // const CardWidget(
              //   image: AssetImage('assets/icons/3.png'),
              //   image2: AssetImage("assets/icons/13.png"),
              //   text: 'فرص تطوعية',
              //   isAvilable: false,
              // ),
            //   const CardWidget( 
            //     image: AssetImage('assets/icons/8.png'),
            //     image2: AssetImage("assets/icons/18.png"),
            //     text: 'حملات',
            //     isAvilable: false,
            //   ),
            //   const CardWidget(
            //     image: AssetImage('assets/icons/1.png'),
            //     image2: AssetImage("assets/icons/14.png"),
            //     text: 'ضبط العضوية',
            //     isAvilable: false,
            //   ),
            //   const CardWidget(
            //     image: AssetImage('assets/icons/2.png'),
            //     image2: AssetImage("assets/icons/15.png"),
            //     text: 'ضبط الحساب الشخصي',
            //     isAvilable: false,
            //   ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
