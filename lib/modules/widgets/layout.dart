import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifemaker/modules/profile/screens/profile_screen.dart';
import 'package:lifemaker/modules/widgets/layout2.dart';
import 'package:lifemaker/repo/layout/cubit/layout_cubit.dart';
import 'package:lifemaker/repo/modals/user_data_modal.dart';

import 'component.dart';

class LayoutMaker extends StatefulWidget {
  const LayoutMaker({super.key});

  @override
  State<LayoutMaker> createState() => _LayoutMakerState();
}

class _LayoutMakerState extends State<LayoutMaker> {
  bool _backButtonPressedOnce = false;

  // late UserModal user;
  late LayoutCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<LayoutCubit>(context);
    cubit.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is GetUserDataL
            ? buildLoadingIndicator()
            : state is GetUserDataS
                ? WillPopScope(
                    // Handle back button press
                    onWillPop: () async {
                      if (_backButtonPressedOnce) {
                        // If back button is pressed twice, exit the app
                        return true;
                      } else {
                        // Show a snackbar to confirm the exit action
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('مرة اخرى للخروج من البرنامج'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        // Set the flag to true to indicate the first press
                        _backButtonPressedOnce = true;
                        // Return false to prevent exiting immediately
                        return false;
                      }
                    },
                    child: buildLayoutWithUser(context, cubit.userModal!),
                  )
                : buildLoadingIndicator();

        // final userModal = cubit.userModal;
        // if (userModal != null) {
        //   return   } else {
        //   return buildLoadingIndicator();
        // }
      },
    );
  }

  Widget buildLayoutWithUser(BuildContext context, UserModal userModal) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff0E395E),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          backgroundImage: AssetImage('assets/user.jpg'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "اهلًا بعودتك",
                              style: TextStyle(
                                color: Color.fromARGB(186, 255, 255, 255),
                              ),
                            ),
                            Text(
                              userModal.username!,
                              style: const TextStyle(
                                color: Color(0XFFFFFFFF),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        icon: const Icon(CupertinoIcons.person,color: Colors.white,size: 35),

                        onPressed: () {
                          navigateTo(context, const ProfileScreen());

                        }),
                    // TextButton.icon(
                    //   style: TextButton.styleFrom(
                    //     iconColor: Colors.white
                    //   ),
                    //     icon: Icon(CupertinoIcons.person),
                    //     label: const Text('الملف الشخصي',style: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold,
                    //
                    //     ),),
                    //     onPressed: () {
                    //       navigateTo(context, const ProfileScreen());
                    //     }),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 120),
              child: const LayoutMaker2(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoadingIndicator() {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: const CircularProgressIndicator(
        backgroundColor: Color(0xffE9791E),
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
