part of 'profile_cubit.dart';
enum profilestatus{ loading,success,error}
 class ProfileState {
   ProfileState({
      required this.infoUser ,
     this.status = profilestatus.loading,
     this.insulinas = const <Insulin>[]
   });
   final User infoUser;
   final profilestatus status;
   final List<Insulin> insulinas;

   ProfileState copywhit({
     profilestatus? status,
     User? infoUser,
     List<Insulin>? insulinas
   }){
     return ProfileState(status: status ?? this.status, infoUser: infoUser ?? this.infoUser, insulinas: insulinas ?? this.insulinas);
   }

   List<Insulin> getInsulinas(){
     return insulinas;
   }

 }

