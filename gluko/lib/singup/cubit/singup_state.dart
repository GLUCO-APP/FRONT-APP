part of 'singup_cubit.dart';
enum Singuptatus{ loading,success,error}

 class SingupState {

   SingupState({
     this.status = Singuptatus.success
   });

   final Singuptatus status;

   Singuptatus confirmar(){
     return Singuptatus.success;
   }
 }

