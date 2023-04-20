import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gluko_repository/gluko_repository.dart';
import '../../colors/colorsGenerals.dart';
import '../cubit/profile_cubit.dart';

class profilepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(infoUserRepository())..getInfoUser(),
      child: profileview(),
    );
  }
}

var name = "Mateo Arenas";
var edad = "23";
var correo = "matvo@gmail.com";
var sexo = "Masculino";
var Hiper = "180 mg/dL";
var Normal = "90 - 160 mg/dL";
var Hipo = "70 mg/dL";
var peso = "70";
var altura = "175";
var sensibilidad = "40";
var ratio = "14";
var tipoinsulina = "175";
User user = User("", "", "", "", "", 0, "", 0, 0, "", "", 0, 0, 0, 0, 0, "", "", "", "", "", "", "", Insulin(0, "", "", 0, 0), Insulin(0, "", "", 0, 0), 0, 0, "");
GlobalKey<FormState> formKey = GlobalKey<FormState>();
final nameCtrl = TextEditingController();
final meilCtrl = TextEditingController();
final edadCtrl = TextEditingController();
var  ver = true;

class profileview extends StatefulWidget {
  @override
  State<profileview> createState() => _profileviewState();
}


Future<void> showMyPopupEditName(BuildContext context) async {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  return showDialog<void>(
    context: context,
    builder: (BuildContext context){
      return  Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width/3,
          height: MediaQuery.of(context).size.height/1.3,
          color: Colors.transparent,
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width/1.2,
                      height: MediaQuery.of(context).size.height/2.8,
                      decoration: BoxDecoration(
                        color: ColorsGenerals().whith,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(-5, 6),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height:  MediaQuery.of(context).size.height/13,
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              controller: nameCtrl,
                              keyboardType: TextInputType.name,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black, fontSize: 15),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                filled: true,
                                hintText: name,
                                errorText: nameCtrl.text.isEmpty || nameCtrl.text.length > 10 ? null : 'Nombre invalido',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none,
                                  ),
                              ),
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          Container(
                            height:  MediaQuery.of(context).size.height/13,
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              controller: meilCtrl,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black, fontSize: 15),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                filled: true,
                                hintText: correo,
                                errorText: meilCtrl.text.isEmpty || meilCtrl.text.length > 10 ? null : 'correo invalido',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          Container(
                            height:  MediaQuery.of(context).size.height/13,
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              controller: edadCtrl,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black, fontSize: 15),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                filled: true,
                                hintText: edad,
                                errorText: edadCtrl.text.isEmpty || edadCtrl.text.length < 2 ? null : 'Edad invalido',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                            },
                            child: Text("Guardar Cambios",
                              style: TextStyle(color: ColorsGenerals().whith),),
                            style: ElevatedButton.styleFrom(
                              elevation: 8, // elevación de la sombra
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30), // radio de la esquina redondeada
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              backgroundColor: ColorsGenerals().red, // color de fondo
                            ),
                          ),
                        ],
                      )
                  ),
                ]
            ),
          ),
        ),
      );
    },
  );
}


class  _profileviewState extends State<profileview>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/Icons/atras.svg", color: ColorsGenerals().black,
            cacheColorFilter: false,
            width: MediaQuery
                .of(context)
                .size
                .height / 30,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorsGenerals().whith,
        elevation: 1,
        actions: [Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(
            "Perfil   ",
            style: TextStyle(color: Colors.black, fontSize: 22),
          )
          ],
        )
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, states) {
          switch (states.status) {
            case profilestatus.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case profilestatus.success:
              user = context.read<ProfileCubit>().getUser();
              if(user.nombre.isNotEmpty){
                name = user.nombre;
                edad = "${user.edad}";
                correo = user.email;
                sexo = user.genero;
                Hiper = "${user.hyper} mg/dL";
                Normal = "${user.estable} mg/dL";
                Hipo = "${user.hipo} mg/dL";
                peso = "${user.peso}";
                altura = "${user.estatura}";
                sensibilidad = "${user.sensitivity}";
                ratio = "${user.rate}";
                tipoinsulina = "175";
              }
              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                    physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                ),
                child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/1.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                height:  MediaQuery.of(context).size.height/6,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: ColorsGenerals().lightgrey,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(name, style: TextStyle(color: ColorsGenerals().black, fontSize: 25, fontWeight: FontWeight.w500),),
                                    Text("Edad : ${edad}", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                    Text("Correo : ${correo}", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                    Text("Sexo : ${sexo}", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(onPressed: (){
                                  showMyPopupEditName(context);
                                }, icon: SvgPicture.asset("assets/Icons/lapiz.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/30,)),
                              ),
                            ],
                          ),
                          Text("  Objetivos glucometria", style: TextStyle(color: ColorsGenerals().black, fontSize: 17,fontWeight: FontWeight.w400),),
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                height:  MediaQuery.of(context).size.height/6,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: ColorsGenerals().lightgrey,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.red,
                                            Colors.green,
                                            Colors.blue,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width/8,
                                      height: MediaQuery.of(context).size.height/7,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Hiper : ", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w500),),
                                            Text(Hiper, style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Normal : ", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w500),),
                                            Text(Normal, style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Hipo : ", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w500),),
                                            Text(Hipo, style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(onPressed: (){}, icon: SvgPicture.asset("assets/Icons/lapiz.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/30,),
                                ),
                              ),
                            ],
                          ),
                          Text("  Datos fisicos", style: TextStyle(color: ColorsGenerals().black, fontSize: 17,fontWeight: FontWeight.w400),),
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                height:  MediaQuery.of(context).size.height/11,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: ColorsGenerals().lightgrey,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("${peso}kg", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                    Container(
                                      width: 1,
                                      height: MediaQuery.of(context).size.height/10,
                                      color: ColorsGenerals().darkgrey,
                                    ),
                                    Text("${altura}cm", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(onPressed: (){}, icon: SvgPicture.asset("assets/Icons/lapiz.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/30,)),
                              ),
                              Positioned(
                                top: 1,
                                left: 0,
                                child: Text("   Peso: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 16,fontWeight: FontWeight.w500),),
                              ),
                              Positioned(
                                top: 1,
                                left: MediaQuery.of(context).size.width/2,
                                child: Text("Altura: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 16,fontWeight: FontWeight.w500),),
                              ),
                            ],
                          ),
                          Text("  Insulina", style: TextStyle(color: ColorsGenerals().black, fontSize: 17,fontWeight: FontWeight.w400),),
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                height:  MediaQuery.of(context).size.height/5,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: ColorsGenerals().lightgrey,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("${sensibilidad}", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                        Container(
                                          width: 1,
                                          height: MediaQuery.of(context).size.height/12,
                                          color: ColorsGenerals().darkgrey,
                                        ),
                                        Text("${ratio}", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 1,
                                      color: ColorsGenerals().darkgrey,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 26),
                                      child: Text("Prueba", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(onPressed: (){}, icon: SvgPicture.asset("assets/Icons/lapiz.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/30,)),
                              ),
                              Positioned(
                                top: 2,
                                left: 0,
                                child: Text("   Sensibilidad: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 16,fontWeight: FontWeight.w500),),
                              ),
                              Positioned(
                                top: 2,
                                left: MediaQuery.of(context).size.width/2,
                                child: Text("Ratio: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 16,fontWeight: FontWeight.w500),),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height/10,
                                left: 0,
                                child: Text("   Tipo de Insulina: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 16,fontWeight: FontWeight.w500),),
                              )
                            ],
                          ),
                        ],
                      )
                  ),
                ),
              );
              break;
            case profilestatus.error:
              return Text("Me petatie");
              break;
          }
        },
      ),
    );
  }
}