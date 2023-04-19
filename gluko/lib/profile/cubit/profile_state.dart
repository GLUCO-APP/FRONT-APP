part of 'profile_cubit.dart';
enum profilestatus{ loading,success,error}
 class ProfileState {
   ProfileState({
      required this.infoUser ,
     this.status = profilestatus.loading,
   });
   final User infoUser;
   final profilestatus status;
   ProfileState copywhit({
     profilestatus? status,
     User? infoUser
   }){
     return ProfileState(status: status ?? this.status, infoUser: infoUser ?? this.infoUser);
   }

 }

