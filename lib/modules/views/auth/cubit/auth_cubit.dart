import 'dart:convert';
import 'package:bloc/bloc.dart';
// import 'package:code_app/shared/network/local_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:lifemaker/repo/modals/user_data_modal.dart';
import 'package:lifemaker/repo/modals/user_modal.dart';
import 'package:lifemaker/repo/shared/network/local_network.dart';
import 'package:lifemaker/repo/shared/network/test.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  UserModal? userModal;

  SharedPrefServices prefServices = SharedPrefServices();

  AuthCubit() : super(AuthInitial());

  // Todo: API URL => https://digifly-eg.com/flutter/life-Makers/public/api/
  // Todo: Register endpoint => register
  void register({
    required String email,
    required String name,
    required String userName,
    required String phone,
    required String password,
    required String whatsapp_number,
    required String id_card_number,
    required String the_job,
    required String the_address,
    required String governorate,
    required String city_center,
    required String previous_experience,
  }) async {
    emit(RegisterLoadingState());
    try {
      Response response = await http.post(
        // request Url = base url + method url ( endpoint ) = https://student.valuxapps.com + /api/register
        Uri.parse(
            'https://digifly-eg.com/flutter/life-Makers/public/api/register'),
        headers: {'Accept': 'application/json'},
        body: <String, String>{
          "name": name,
          "username": userName,
          "email": email,
          "phone": phone,
          "password": password,
          "whatsapp_number": whatsapp_number,
          "id_card_number": id_card_number,
          "the_job": the_job,
          "the_address": the_address,
          "governorate": governorate,
          "city_center": city_center,
          "previous_experience": previous_experience,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          debugPrint("Response is : $data");
          var user = User.fromJson(data);

          emit(RegisterSuccessState(userId: user.user!.id.toString()));
          print(data);
        } else {
          debugPrint("Response is : $data");
          var user = User.fromJson(data);

          emit(FailedToRegisterState(
              message: data['message'], userId: user.user!.id.toString()));
          // emit(R());
        }
      } else if (response.statusCode == 401) {
        var data = jsonDecode(response.body);
        if (data.containsKey('errors')) {
          if (data['errors'].containsKey('email')) {
            emit(FailedToRegisterState(
              message: data['errors']['email'][0] ??
                  'Email error message is missing',
            ));
          } else if (data['errors'].containsKey('phone')) {
            emit(FailedToRegisterState(
              message: data['errors']['phone'][0] ??
                  'Phone error message is missing',
            ));
          } else if (data['errors'].containsKey('username')) {
            emit(FailedToRegisterState(
              message: data['errors']['username'][0] ??
                  'Username error message is missing',
            ));
          }
        }
        // emit(R());
      }
    } catch (e) {
      debugPrint("Failed to Register , reason : $e");
      emit(FailedToRegisterState(message: e.toString()));
    }
  }

  Future<void> sendVerificationCode(
      {required String userId, required String code}) async {
    emit(OTPLoadingState());

    final url = Uri.parse(
        'https://digifly-eg.com/flutter/life-Makers/public/api/submit-code');

    try {
      final response = await http.post(
        url,
        body: {
          'user_id': userId,
          'code': code,
        },
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        // Verification code sent successfully
        await CacheNetwork.insertToCache(
            key: "token", value: responseData['token']);
        emit(OTPSuccessState());
        print('Verification code sent successfully');
      } else if (response.statusCode == 401) {
        var data = jsonDecode(response.body);

        emit(OTPFieldState(message: data['message']));
        // emit(R());
      } else {
        // Handle the error
        emit(OTPFieldState(message: responseData['message']));
        print(
            'Failed to send verification code. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle any exceptions that occur during the HTTP request
      print('Error sending verification code: $error');
    }
  }

  Future<void> ResendVerificationCode({required String userId}) async {
    emit(OTPResendLoadingState());

    final url = Uri.parse(
        'https://digifly-eg.com/flutter/life-Makers/public/api/resend-code');

    try {
      final response = await http.post(
        url,
        body: {
          'user_id': userId,
        },
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        // Verification code sent successfully
        await CacheNetwork.insertToCache(
            key: "token", value: responseData['token']);
        emit(OTPResendSuccessState());
        print('Verification code sent successfully');
      } else if (response.statusCode == 401) {
        var data = jsonDecode(response.body);

        emit(OTPResendFieldState(message: data['message']));
        // emit(R());
      } else {
        // Handle the error
        emit(OTPResendFieldState(message: responseData['message']));
        print(
            'Failed to send verification code. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle any exceptions that occur during the HTTP request
      print('Error sending verification code: $error');
    }
  }

  // Account : mo.ha@gmail.com , password : 123456
  void login({required String username, required String password}) async {
    emit(LoginLoadingState());

    try {
      Response response = await http.post(
        // request => url = base url + method url
        Uri.parse(
            'https://digifly-eg.com/flutter/life-Makers/public/api/login'),
        body: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          // debugPrint("User login success and his Data is : ${responseData['data']['token']}");
          print('====  ===== ===== ===== ${responseData['status']}');
          await CacheNetwork.insertToCache(
              key: "token", value: responseData['token']);

          // var username = User.fromJson(responseData);
          emit(LoginSuccessState());
        } else {
          debugPrint("Failed to login, reason is : ${responseData['message']}");
          await CacheNetwork.insertToCache(
              key: "token", value: responseData['token']);
          // emit(LoginSuccessState());
          emit(FailedToLoginState(message: responseData['message']));
        }
      } else if (response.statusCode == 401) {
        var responseData = jsonDecode(response.body);
        emit(FailedToLoginState(message: responseData['message']));
      }
    } catch (e) {
      // emit(FailedToLoginState(message: e.toString()));
      emit(LoginSuccessState());
    }
  }

  Future<void> sendVerificationCodeReset(
      {required String userId, required String code}) async {
    emit(OTPResetLoadingState());

    final url = Uri.parse(
        'https://digifly-eg.com/flutter/life-Makers/public/api/submit-code');

    try {
      final response = await http.post(
        url,
        body: {
          'user_id': userId,
          'code': code,
        },
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        // Verification code sent successfully
        await CacheNetwork.insertToCache(
            key: "token", value: responseData['token']);

        emit(OTPResetSuccessState());
        print('Verification code sent successfully');
      } else if (response.statusCode == 401) {
        var data = jsonDecode(response.body);

        emit(OTPResetFieldState(message: data['message']));
        // emit(R());
      } else {
        // Handle the error

        emit(OTPResetFieldState(message: responseData['message']));
        print(
            'Failed to send verification code. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle any exceptions that occur during the HTTP request
      print('Error sending verification code: $error');
    }
  }

  // Account : mo.ha@gmail.com , password : 123456
  void resetPassword({
    required String phone,
  }) async {
    emit(ResetPasswordLoadingState());
    try {
      Response response = await http.post(
        // request Url = base url + method url ( endpoint ) = https://student.valuxapps.com + /api/register
        Uri.parse(
            'https://digifly-eg.com/flutter/life-Makers/public/api/reset-password'),

        body: {
          'phone': phone,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          debugPrint("Response is : $data");
          var user = User.fromJson(data);
          emit(ResetPasswordSuccessState(userId: user.user!.id.toString()));
          print(data);
        } else {
          debugPrint("Response is : $data");
          var user = User.fromJson(data);

          emit(FailedToResetPasswordState(message: data['message']));
          // emit(R());
        }
      } else if (response.statusCode == 401) {
        var data = jsonDecode(response.body);
        var user = User.fromJson(data);
        emit(FailedToResetPasswordState(message: data['errors']['phone'][0]));
      } else {
        var data = jsonDecode(response.body);
        emit(FailedToResetPasswordState(message: data['message']));
      }
    } catch (e) {
      // debugPrint("Failed to Register , reason : $e");
      // emit(FailedToRegisterState(message: e.toString()));
    }
  }

  void ChangePassword({
    required String password,
    required String password_confirmation,
    required String token,
  }) async {
    emit(ChangePasswordLoadingState());
    try {
      Response response = await http.post(
        // request Url = base url + method url ( endpoint ) = https://student.valuxapps.com + /api/register
        Uri.parse(
            'https://digifly-eg.com/flutter/life-Makers/public/api/reset-change-password'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'password': password,
          'password_confirmation': password_confirmation,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          debugPrint("Response is : $data");
          emit(ChangePasswordSuccessState());
          print(data);
        }
      } else if (response.statusCode == 401) {
        var data = jsonDecode(response.body);
        emit(FailedToChangePasswordState(
            message: data['errors']['password_confirmation'][0]));
      }
    } catch (e) {
      debugPrint("Failed to Register , reason : $e");
      emit(FailedToChangePasswordState(message: e.toString()));
    }
  }
}

/*
Response after login
{
    "status": true,
    "message": "Registration done successfully",
    "data": {
        "name": "Saleh Ahmed",
        "phone": "0125454412",
        "email": "mohamed.hashim73@gmail.com",
        "id": 52821,
        "image": "https://student.valuxapps.com/storage/uploads/users/CpFliPNQdd_1677580291.jpeg",
        "token": "EbiEk1Tt5UHmHaYbwLvcTdDRPQPYPCQccIBVhH1bwGDnfrAT78ddMB96IKMN3Nv8jpLQAk"
    }
}
 */

