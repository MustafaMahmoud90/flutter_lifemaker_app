// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

@immutable
abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {
  final String? userId;
  RegisterSuccessState({
    this.userId,
  });
}

class FailedToRegisterState extends AuthStates {
  final String message;
  final String? userId;
  FailedToRegisterState({this.userId, required this.message});
}

class OTPLoadingState extends AuthStates {}

class OTPSuccessState extends AuthStates {}

class OTPFieldState extends AuthStates {
  final String message;
  OTPFieldState({required this.message});
}

class OTPResetLoadingState extends AuthStates {}

class OTPResetSuccessState extends AuthStates {}

class OTPResetFieldState extends AuthStates {
  final String message;
  OTPResetFieldState({required this.message});
}
class OTPResendLoadingState extends AuthStates {}

class OTPResendSuccessState extends AuthStates {}

class OTPResendFieldState extends AuthStates {
  final String message;
  OTPResendFieldState({required this.message});
}

class UpdateLoadingState extends AuthStates {}

class UpdateSuccessState extends AuthStates {}

class FailedToUpdateState extends AuthStates {
  final String message;
  FailedToUpdateState({required this.message});
}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  // final String userId;
  // LoginSuccessState({required this.userId});
}

class FailedToLoginState extends AuthStates {
  final String message;
  FailedToLoginState({required this.message});
}

class ChangePasswordLoadingState extends AuthStates {}

class ChangePasswordSuccessState extends AuthStates {
  ChangePasswordSuccessState();
}

class FailedToChangePasswordState extends AuthStates {
  final String message;

  FailedToChangePasswordState({
    required this.message,
  });
}

class ResetPasswordLoadingState extends AuthStates {}

class ResetPasswordSuccessState extends AuthStates {
  final String? userId;
  ResetPasswordSuccessState({this.userId});
}

class FailedToResetPasswordState extends AuthStates {
  final String message;
  final String? userId;
  FailedToResetPasswordState({required this.message, this.userId});
}
