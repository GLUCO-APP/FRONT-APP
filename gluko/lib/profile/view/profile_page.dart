import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../colors/colorsGenerals.dart';
import '../cubit/profile_cubit.dart';

class profilepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
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

class profileview extends StatefulWidget {
  @override
  State<profileview> createState() => _profileviewState();
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
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
                          height:  MediaQuery.of(context).size.height/4.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: ColorsGenerals().lightgrey,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 6),
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
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: ColorsGenerals().black,)),
                        ),
                      ],
                    ),
                    Text("  Objetivos glucometria", style: TextStyle(color: ColorsGenerals().black, fontSize: 17,fontWeight: FontWeight.w400),),
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          height:  MediaQuery.of(context).size.height/4.8,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: ColorsGenerals().lightgrey,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 6),
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
                                height: MediaQuery.of(context).size.height/4.9,
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
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: ColorsGenerals().black,)),
                        ),
                      ],
                    ),
                    Text("  Datos fisicos", style: TextStyle(color: ColorsGenerals().black, fontSize: 17,fontWeight: FontWeight.w400),),
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          height:  MediaQuery.of(context).size.height/9,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: ColorsGenerals().lightgrey,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 6),
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
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: ColorsGenerals().black,)),
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
                                offset: Offset(0, 6),
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
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: ColorsGenerals().black,)),
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