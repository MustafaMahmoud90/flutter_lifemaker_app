import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:lifemaker/modules/views/thanks/thanks.dart';
import 'package:lifemaker/modules/views/voating/vot_card.dart';
import 'package:lifemaker/modules/views/voating/voters_details.dart';
import 'package:lifemaker/modules/widgets/btn-theme.dart';
import 'package:lifemaker/modules/widgets/component.dart';
import 'package:lifemaker/modules/widgets/layout.dart';
import 'package:lifemaker/repo/layout/cubit/layout_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VotersScreen extends StatefulWidget {
  const VotersScreen({Key? key});

  @override
  State<VotersScreen> createState() => _VotersScreenState();
}

class _VotersScreenState extends State<VotersScreen> {
  final List<String> selectedVoters = [];

  bool canVote() {
    return selectedVoters.length == 11;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    // Get the current date and time
    final now = DateTime.now();

    // Define the start and end times for showing the cards
    final startTime = DateTime(now.year, now.month, now.day, 10, 0);
    final endTime = DateTime(now.year, now.month, now.day, 22, 0);

    // Check if the current time is before 10:00 AM
    final isBeforeStartTime = now.isBefore(startTime);

    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        // FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

        if (state is GetVotersSuccessState) {
          print("تم تحميل المرشحين.");
        } else if (state is GetVotersFaildState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("خطأ في تحميل المرشحين."),
          ));
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            // Enable screenshots when leaving this screen
            // await FlutterWindowManager.addFlags(
            //     FlutterWindowManager.FLAG_SECURE);

            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "إنتخابات مجلس إدارة متطوعين",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0E395E),
                ),
              ),
              centerTitle: true,
              scrolledUnderElevation: 10,
              shadowColor: Colors.black,
              excludeHeaderSemantics: true,
              automaticallyImplyLeading: false,
              leading: IconButton(
                color: const Color(0xff0E395E),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.arrow_right,
                ),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
              child: RefreshIndicator(
                backgroundColor: const Color(0xffE9791E),
                color: const Color.fromARGB(255, 255, 255, 255),
                onRefresh: () async {
                  cubit.refreshData();
                },
                child: state is AlreadyVotedState
                    ? Text("data")
                    : SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            // const Text(
                            //   "إنتخابات مجلس إدارة متطوعين مؤسسة صناع الحياة المصرية",
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.w700,
                            //     color: Color(0xff0E395E),
                            //   ),
                            // ),
                            if (isBeforeStartTime)
                              Text(
                                "معاد الانتخابات اليوم الساعة العاشرة صباحًا",
                                style: TextStyle(
                                  color: Colors.red, // يمكنك تغيير لون النص
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            else if (now.isAfter(endTime))
                              const SizedBox(
                                height: 30,
                              ),
                            GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 30,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 0.9),
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: cubit.voters.length,
                              itemBuilder: (context, index) {
                                final voter = cubit.voters[index];
                                final isVoted = selectedVoters
                                    .contains(voter.id.toString());

                                return GestureDetector(
                                  onTap: () {
                                    final voterId = voter.id.toString();
                                    if (isVoted) {
                                      // Deselect the voter
                                      selectedVoters.remove(voterId);
                                    } else {
                                      if (selectedVoters.length < 11) {
                                        // Select the voter
                                        selectedVoters.add(voterId);
                                      }
                                    }
                                    // Rebuild the widget to update the selection
                                    setState(() {});
                                  },
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Hero(
                                      tag: voter.id!,
                                      child: CardWidgets(
                                        isVoted: isVoted,
                                        image: "${voter.image}",
                                        text: voter.name!,
                                        icon: CupertinoIcons.info_circle_fill,
                                        onTap: () {
                                          final voterId = voter.id.toString();
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreen(e: voter),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: state is VotingLoadingState
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
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ),
                                    )
                                  : BtnTheme(
                                      color: const Color(0xffE9791E),
                                      text: "إنتهاء",
                                      ontap: () async {
                                        if (canVote()) {
                                          await Future.delayed(
                                              const Duration(seconds: 0));
                                          await cubit
                                              .vote(selectedVoters)
                                              .then((value) async {
                                            await Future.delayed(const Duration(
                                                milliseconds: 1500));
                                            // Mark the user as voted in SharedPreferences
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setBool('hasVoted', true);
                                            navigateAndFinish(
                                                context, ThanksScreen());
                                          });
                                          print(selectedVoters.length);
                                        } else {
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.error,
                                            animType: AnimType.SCALE,
                                            title: 'خطأ في إلإنتخاب',
                                            desc:
                                                "عذرا، برجاء إختيار 11 مرشح من قائمة المرشحين لإتمام العملية الإنتخابية.",
                                            btnOkOnPress: () {},
                                            btnCancelOnPress: () {},
                                            btnOkColor: const Color(0xff0E395E),
                                            btnCancelColor:
                                                const Color(0xff0E395E),
                                            btnOkText: 'إعادة إدخال',
                                            btnCancelText: 'إلغاء',
                                          ).show();
                                        }
                                      },
                                    ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
