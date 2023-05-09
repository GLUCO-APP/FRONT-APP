part of 'singup_cubit.dart';
enum Singuptatus{ loading,success,error}

 class SingupState {

   SingupState({
     this.status = Singuptatus.success,
     this.insulinas = const <Insulin>[]
   });

   final Singuptatus status;
   final List<Insulin> insulinas;

   Singuptatus confirmar(){
     return Singuptatus.success;
   }

   SingupState copywhit(  {
     Singuptatus? status,
     List<Insulin>? insulinas
   }){
     return SingupState(status: status ?? this.status, insulinas: insulinas ?? this.insulinas);
   }

   List<Insulin> getInsulinas(){
     return insulinas;
   }
 }

