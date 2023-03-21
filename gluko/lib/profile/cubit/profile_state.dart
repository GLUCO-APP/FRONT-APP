part of 'profile_cubit.dart';
enum profilestatus{ loading,success,error}
 class ProfileState {
   ProfileState({
     this.status = profilestatus.success
   });

   final profilestatus status;

   profilestatus confirmar(){
     return profilestatus.success;
   }
 }
