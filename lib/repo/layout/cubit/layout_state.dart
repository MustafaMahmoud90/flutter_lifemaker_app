part of 'layout_cubit.dart';

@immutable
sealed class LayoutState {}

final class LayoutInitial extends LayoutState {}

class ChangeBottomNavState extends LayoutState{}
class GetVotersSuccessState extends LayoutState {}

class GetVotersLoadingState extends LayoutState {}

class GetVotersFaildState extends LayoutState {}

class GetUserDataLoadingState extends LayoutState {}

class GetUserDataSuccessState extends LayoutState {}

class GetUserDataFaildState extends LayoutState {
  String error;
  GetUserDataFaildState({required this.error});
}

class VotingSuccessState extends LayoutState {}

class VotingLoadingState extends LayoutState {}

class VotingFaildState extends LayoutState {}

class AlreadyVotedState extends LayoutState {}

class UserIsOldSuccessState extends LayoutState {}

class UserIsOldFaildState extends LayoutState {}



class GetUserDataS extends LayoutState {}
class GetUserDataL extends LayoutState {}

