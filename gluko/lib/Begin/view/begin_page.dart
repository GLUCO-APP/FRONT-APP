import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gluko/colors/colorsGenerals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../assembleplate/view/assembleplate_page.dart';
import '../cubit/begin_cubit.dart';
import 'circlesprogress.dart';

class beginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BeginCubit(),
      child: beginview(),
    );
  }
}

class beginview extends StatefulWidget {
  @override
  State<beginview> createState() => _beginviewState();
}

bool _isPressed = false;

class  _beginviewState extends State<beginview>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: BlocBuilder<BeginCubit, BeginState>(
        builder: (context, states) {
          switch (states.status) {
            case Beginstatus.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case Beginstatus.success:
              return Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width /3,
                              height: MediaQuery.of(context).size.height /5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/Logo/gluko_bot_hi.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text("GlukoBot te saluda", style: TextStyle(color: ColorsGenerals().black, fontWeight: FontWeight.w500),)
                          ] ,
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            assembleplatepage())
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: SvgPicture.asset("assets/Icons/plato.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/15,),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                backgroundColor: ColorsGenerals().regulargrey,
                                minimumSize: Size(60, 60),
                              ),

                            ),
                            Text("Arma tu plato", style: TextStyle( color: ColorsGenerals().black),)
                          ],
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height /150,horizontal: MediaQuery.of(context).size.width /50),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height /5,
                      decoration: BoxDecoration(
                          color: ColorsGenerals().lightgrey,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(-5, 6),
                          ),
                        ],
                        ),
                      child: Column(
                        children: [
                          Text("Tu estado actual", style: TextStyle(color: ColorsGenerals().black),),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomPaint(
                                painter: RingPainter(
                                  progress: 0.25, // Cambia esto al porcentaje de progreso deseado
                                  strokeWidth: 10.0, // Cambia esto al ancho de trazo deseado
                                  background: Colors.grey[300]!, // Cambia esto al color de fondo deseado
                                  color: Colors.transparent,
                                  titulo: "180g"// Esto se ignora, el color se controla por el porcentaje de progreso
                                ),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width/4,
                                  height: MediaQuery.of(context).size.height/7,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width/4,
                                    height: MediaQuery.of(context).size.height/15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      color: Colors.orange,
                                    ),
                                    child: Center(
                                      child: Text("148 mg/dl", style: TextStyle(color: ColorsGenerals().black),),
                                    )
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/4,
                                    height: MediaQuery.of(context).size.height/15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                      color: Colors.white,
                                    ),
                                      child: Center(
                                        child: Text("8:20 pm", style: TextStyle(color: ColorsGenerals().black),),
                                      )
                                  )
                                ],
                              ),
                              CustomPaint(
                                painter: RingPainter(
                                    progress: 0.25, // Cambia esto al porcentaje de progreso deseado
                                    strokeWidth: 10.0, // Cambia esto al ancho de trazo deseado
                                    background: Colors.grey[300]!, // Cambia esto al color de fondo deseado
                                    color: Colors.transparent,
                                    titulo: "1.6 u"// Esto se ignora, el color se controla por el porcentaje de progreso
                                ),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width/4,
                                  height: MediaQuery.of(context).size.height/7,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("¿Que deseas comer?",style: TextStyle(color: ColorsGenerals().black),),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height /50, horizontal: MediaQuery.of(context).size.width /20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height /150,),
                                  width: MediaQuery.of(context).size.width /1.5,
                                  height: MediaQuery.of(context).size.height /5,
                                  decoration: BoxDecoration(
                                    color: ColorsGenerals().lightgrey,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5), // Color de la sombra
                                        spreadRadius: 2, // El tamaño de la sombra
                                        blurRadius: 7, // La cantidad de difuminado de la sombra
                                        offset: Offset(-5, 6), // La posición de la sombra
                                      ),
                                    ],
                                  ),

                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height /150,),
                                  width: MediaQuery.of(context).size.width /1.5,
                                  height: MediaQuery.of(context).size.height /5,
                                  decoration: BoxDecoration(
                                    color: ColorsGenerals().lightgrey,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5), // Color de la sombra
                                        spreadRadius: 2, // El tamaño de la sombra
                                        blurRadius: 7, // La cantidad de difuminado de la sombra
                                        offset: Offset(-5, 6), // La posición de la sombra
                                      ),
                                    ],
                                  ),

                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height /150,),
                                  width: MediaQuery.of(context).size.width /1.5,
                                  height: MediaQuery.of(context).size.height /5,
                                  decoration: BoxDecoration(
                                    color: ColorsGenerals().lightgrey,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5), // Color de la sombra
                                        spreadRadius: 2, // El tamaño de la sombra
                                        blurRadius: 7, // La cantidad de difuminado de la sombra
                                        offset: Offset(-5, 6), // La posición de la sombra
                                      ),
                                    ],
                                  ),

                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height /150,),
                                  width: MediaQuery.of(context).size.width /1.5,
                                  height: MediaQuery.of(context).size.height /5,
                                  decoration: BoxDecoration(
                                    color: ColorsGenerals().lightgrey,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(-5, 6),
                                      ),
                                    ],
                                  ),

                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
              break;
            case Beginstatus.error:
              return Text("Me petatie");
              break;
          }
        },
      ),
    );
  }
}