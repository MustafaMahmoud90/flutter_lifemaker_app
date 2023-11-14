import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lifemaker/modules/widgets/component.dart';
import 'package:lifemaker/modules/widgets/layout.dart';
import 'package:lifemaker/repo/layout/cubit/layout_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:share/share.dart';

class ThanksScreen extends StatefulWidget {
  const ThanksScreen({Key? key}) : super(key: key);

  @override
  State<ThanksScreen> createState() => _ThanksScreenState();
}

class _ThanksScreenState extends State<ThanksScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  Future<void> _captureAndShare() async {
    try {
      // Check and request permissions
      if (await Permission.storage.request().isGranted) {
        // Capture the screenshot
        final image = await screenshotController.capture();

        if (image != null) {
          // Save the screenshot
          await saveImage(image);
          if(mounted)
            {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.scale,
                title: 'تم أخذ لقطة شاشة',
                btnOkText: "شاركها مع أصدقائك",
                btnOkOnPress: () async {
                  // Share the screenshot
                },
                btnOkColor: const Color(0xff0E395E),
                btnCancelColor: const Color(0xff0E395E),
              ).show();

            }
        }
      } else {
        // Handle denied permission
      }
    } catch (e) {
      // Handle errors
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<void> saveImage(Uint8List bytes) async {
    try {
      final time = DateTime.now()
          .toIso8601String()
          .replaceAll('.', '-')
          .replaceAll(':', "-");
      final name = 'VoteResults_$time';
      await ImageGallerySaver.saveImage(bytes, name: name);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving image: $e');
      }
    }
  }

  Future<bool> shareImage(Uint8List bytes) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/image.png';
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      await Share.shareFiles([filePath], text: 'Share Image');

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing image: $e');
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    // FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);

    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Screenshot(
          controller: screenshotController,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              scrolledUnderElevation: 10,
              shadowColor: Colors.black,
              excludeHeaderSemantics: true,
              automaticallyImplyLeading: false,
              actions: [
                Image.asset(
                  "assets/user.jpg",
                  width: 70,
                  height: 70,
                )
              ],
              leading: IconButton(
                icon: const Icon(
                  CupertinoIcons.arrow_right,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 14, 57, 94)),
                ),
                color: Colors.white,
                onPressed: () {
                  navigateAndFinish(context,
                      const LayoutMaker()); // Uncomment and replace with your own navigation logic
                },
              ),
            ),
            body: SizedBox(
              // alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/5359958.png",
                    width: 300,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  state is GetUserDataFaildState
                      ? const CircularProgressIndicator()
                      : const Text(
                          " فخور بالمشاركة في انتخابات مجلس إدارة متطوعين مؤسسة صناع الحياة",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      _captureAndShare();
                    },
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xffE9791E),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "حفظ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Container(
                            alignment: Alignment.center,
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xff0E395E),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.downloading_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
