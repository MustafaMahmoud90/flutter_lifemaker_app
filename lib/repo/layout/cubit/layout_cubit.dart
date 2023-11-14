import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:lifemaker/modules/views/connect/internet.dart';
import 'package:lifemaker/modules/widgets/component.dart';
import 'package:lifemaker/modules/widgets/layout.dart';
import 'package:lifemaker/repo/modals/Voters_modal.dart';
import 'package:lifemaker/repo/modals/user_data_modal.dart';
import 'package:lifemaker/repo/shared/constans/constans.dart';
import 'package:lifemaker/repo/shared/network/local_network.dart';
import 'package:lifemaker/repo/shared/network/test.dart';
import 'package:meta/meta.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  SharedPrefServices prefServices = SharedPrefServices();
  LayoutCubit() : super(LayoutInitial());

  UserModal? userModal;
  int CurrentIndex = 0;

  void changeNav({required int index}) {
    CurrentIndex = index;
    emit(ChangeBottomNavState());
  }

  void getUserData() async {
    try {
      emit(GetUserDataL());

      var userToken = await CacheNetwork.getCacheData(
        key: "token",
      );

      Response response = await http.get(
          Uri.parse(
              'https://digifly-eg.com/flutter/life-Makers/public/api/user-data'),
          headers: {
            'Authorization': 'Bearer $userToken',
          });

      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        userModal = UserModal.fromJson(data: responseData['data']);
        log('====================================');
        print("user OLD ID IS ${userModal!.old!}");
        print("user username ID IS ${userModal!.username!}");

        await prefServices.saveInteger(isOld, userModal!.old!);
        // await prefServices.saveString(
        //     username!, userModal!.username!.toString());
        emit(GetUserDataS());
      } else {
        emit(GetUserDataFaildState(error: responseData['massage']));
      }
    } catch (e) {
      emit(GetUserDataFaildState(error: e.toString()));
      print("==================================Error: $e");
    }
  }

  List<VotersModal> voters = [];

  // Function to fetch voters data
  Future<void> getVoters() async {
    // emit(GetVotersLoadingState()); // Indicate that data is being fetched
    var userToken = await CacheNetwork.getCacheData(
      key: "token",
    );

    try {
      Response response = await http.get(
        Uri.parse(
            'https://digifly-eg.com/flutter/life-Makers/public/api/Voters'),
        headers: {
          'Authorization': 'Bearer ${userToken!}',
        },
      );

      final responseBody = jsonDecode(response.body);

      if (responseBody['status'] == true) {
        voters.clear(); // Clear the existing data
        for (var item in responseBody['Voters']) {
          voters.add(
            VotersModal.fromJson(data: item),
          );
        }
        // emit(GetVotersSuccessState());
      } else {
        // emit(GetVotersFaildState());
      }
    } catch (e) {
      // emit(GetVotersFaildState());
    }
  }

  // Function to refresh data
  Future<void> refreshData() async {
    await getVoters(); // Call the getVoters function to refresh data
  }

  List<String> voterIds = [];
  Future<void> vote(voterIds) async {
    var userToken = await CacheNetwork.getCacheData(
      key: "token",
    );
    // Check if there are more than 11 IDs and limit it to the first 11
    emit(VotingLoadingState());
    if (voterIds.length == 11) {
      try {
        var requestBody = {
          "voters_id[0]": voterIds[0],
          "voters_id[1]": voterIds[1],
          "voters_id[2]": voterIds[2],
          "voters_id[3]": voterIds[3],
          "voters_id[4]": voterIds[4],
          "voters_id[5]": voterIds[5],
          "voters_id[6]": voterIds[6],
          "voters_id[7]": voterIds[7],
          "voters_id[8]": voterIds[8],
          "voters_id[9]": voterIds[9],
          "voters_id[10]": voterIds[10],
        };

        var request = await http.post(
          Uri.parse(
            'https://digifly-eg.com/flutter/life-Makers/public/api/toggleVote',
          ),
          headers: {
            'Authorization': 'Bearer ${userToken}',
          },
          body: requestBody,
        );
        final responseJson = json.decode(request.body);

        if (request.statusCode == 200) {
          // Check if the response contains the specific message
          emit(VotingSuccessState());
        } else if (responseJson['status'] == false) {
          emit(AlreadyVotedState());
        } else {
          emit(VotingFaildState());
        }
      } catch (e) {
        print('Error: $e');
        emit(VotingFaildState());
      }
    } else {
      emit(VotingFaildState());
    }
  }

  Future<Future<Object?>> showLogoutConfirmationDialog(
      BuildContext context) async {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: SingleChildScrollView(
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'تأكيد تسجيل الخروج',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30)),
                            backgroundColor: MaterialStatePropertyAll(
                                const Color(0xff0E395E)),
                          ),
                          child: const Text(
                            'إلغاء',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30)),
                            backgroundColor: MaterialStatePropertyAll(
                                const Color(0xff0E395E)),
                          ),
                          child: const Text(
                            'نعم',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          onPressed: () {
                            const Duration(seconds: 2); // Add a 2-second delay
                            logOut(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void checkInternetConnection(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // Navigator.pushNamed(context, '');
      navigateTo(context, const InternetLost());
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LayoutMaker()),
      );
    }
  }
}
