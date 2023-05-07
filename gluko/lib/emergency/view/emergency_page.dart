import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gluko_repository/gluko_repository.dart';
import '../../colors/colorsGenerals.dart';
import '../cubit/emergency_cubit.dart';

class emergencypage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmergencyCubit(EmergencyRepository(),RegisterReportRepository(), RegisterPlateRepository()),
      child: emergencyview(),
    );
  }
}


class emergencyview extends StatefulWidget {
  @override
  State<emergencyview> createState() => _emergencyviewState();
}

class  _emergencyviewState extends State<emergencyview>{
  List<FoodDetail> snaks = [];
  int estado = 4;
  int unidades = 3;
  var glucosa = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool visible = false;

  Future<void> _registrarSnak(FoodDetail food) async {
    var response =  await context.read<EmergencyCubit>().RegisterPlate(PlateRegister([plateId(food.id)],double.parse(glucosa.text.toString()),food.carbs, food.protein, food.fats, "Snack", 0,0,0,"","","Sin titulo xd"),int.parse(glucosa.text),0);
    if(response){
      glucosa.clear();
      setState(() {
        estado = 4;
        visible = false;
      });
      Fluttertoast.showToast(
          msg: "Snak Registrado", fontSize: 20);
    }else{
      Fluttertoast.showToast(
          msg: "Error al registrar plato Intenta Mas Tarde", fontSize: 20);
    }
  }

  RegistrarSnak(BuildContext context, FoodDetail food) {
    return showModalBottomSheet(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.0),
            topRight: Radius.circular(100.0),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height/3,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(color: ColorsGenerals().whith,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("¿Consumirás este snack?", textAlign: TextAlign.center,style: TextStyle(
                          color: ColorsGenerals().black,
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height / 30),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(food.name, style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: ColorsGenerals().black)),
                              Text("Alimento", style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorsGenerals().black),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(glucosa.text, style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: ColorsGenerals().black)),
                              Text("Glucemia", style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorsGenerals().black),),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          _registrarSnak(food);
                          Navigator.pop(context);
                        },
                        child: Text("Registrar snack",
                          style: TextStyle(color: ColorsGenerals().whith, fontSize: 18),),
                        style: ElevatedButton.styleFrom(
                          elevation: 8, // elevación de la sombra
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // radio de la esquina redondeada
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          backgroundColor: Colors.red, // color de fondo
                        ),

                      )
                    ],
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: BlocBuilder<EmergencyCubit, EmergencyState>(
        builder: (context, states) {
          switch (states.status) {
            case Emergencystatus.loading:
              return Center(child: CircularProgressIndicator(color: ColorsGenerals().red,));
              break;
            case Emergencystatus.success:
              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                    physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                ),
                child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/1.21,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Ingresa tu medida de Glucemia", style: TextStyle(color: ColorsGenerals().black, fontSize: MediaQuery.of(context).size.height/45, fontWeight: FontWeight.w400),),
                                Container(
                                  padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/40 ),
                                  height: MediaQuery.of(context).size.height/8,
                                  width: MediaQuery.of(context).size.width/1.2,
                                  child: TextFormField(
                                    maxLength: 3,
                                    controller: glucosa,
                                    keyboardType: TextInputType.number,
                                    cursorColor: ColorsGenerals().black,
                                    style: TextStyle(color: ColorsGenerals().black),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: ColorsGenerals().lightgrey,
                                        hintText: 'Glucemia',
                                        hintStyle: TextStyle(color: ColorsGenerals().black),
                                        contentPadding:
                                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: SvgPicture.asset("assets/Icons/glucometro.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/40,),
                                        )
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Ingrese su nivel de glucosa';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          visible?
                              estado == 0?
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height/1.8,
                                child: Column(
                                  children: [
                                    Text("!Tu medida es peligrosamente baja!\nToma algo para incrementarla:", style: TextStyle(color: ColorsGenerals().black, fontSize: MediaQuery.of(context).size.height/45, fontWeight: FontWeight.w400),),
                                    Padding(padding: EdgeInsets.symmetric(
                                        vertical: MediaQuery
                                            .of(context)
                                            .size
                                            .height / 100)),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10,
                                          vertical: 20),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 2.2,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: ColorsGenerals().lightgrey,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(0, 3),
                                            ),
                                          ]
                                      ),
                                      child: Snaks(context),
                                    )
                                  ],
                                ),
                              ) :estado == 1?
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height/1.8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /1.5,
                                      height: MediaQuery.of(context).size.height /2.5,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:AssetImage("assets/Logo/gluko_bot_happy.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                                    Text("!Estás estable!", style: TextStyle(color: ColorsGenerals().black, fontSize: MediaQuery.of(context).size.height/20, fontWeight: FontWeight.w500),)
                                  ] ,
                                ),
                              ) :
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height/1.8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /1.5,
                                      height: MediaQuery.of(context).size.height /2.5,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:AssetImage("assets/Logo/gluko_bot_angry.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                    ),
                                    Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                                    Text("!Tu medida es peligrosamente alta!,\nadministra ${unidades} unidades de insulina \npara bajarla.", style: TextStyle(color: ColorsGenerals().black, fontSize: MediaQuery.of(context).size.height/40, fontWeight: FontWeight.w500),)
                                  ] ,
                                ),
                              ) :
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height/1.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width /1.5,
                                  height: MediaQuery.of(context).size.height /2.5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:AssetImage("assets/Logo/gluko_bot_hi.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                                Text("¿Cómo te sientes?", style: TextStyle(color: ColorsGenerals().black, fontSize: MediaQuery.of(context).size.height/23, fontWeight: FontWeight.w100),)
                              ] ,
                            ),
                          ),
                          estado == 2?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: ()  {
                                  setState(() {
                                    visible = false;
                                    glucosa.clear();
                                    estado = 3;
                                  });
                                },
                                child: Text("Cancelar",
                                  style: TextStyle(color: ColorsGenerals().whith, fontSize: 18),),
                                style: ElevatedButton.styleFrom(
                                  elevation: 8, // elevación de la sombra
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30), // radio de la esquina redondeada
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                                  backgroundColor: Colors.red, // color de fondo
                                ),

                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  var response =  await context.read<EmergencyCubit>().RegisterPlate(PlateRegister([],0,0,0,0,"Registro Insulina",0, 0,0,"","","Sin titulo xd"),int.parse(glucosa.text),unidades);
                                  if(response){
                                    glucosa.clear();
                                    setState(() {
                                      visible = false;
                                      estado = 3;
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Reporte registrado", fontSize: 20);
                                  }else{
                                    Fluttertoast.showToast(
                                        msg: "Error al registrar plato Intenta Mas Tarde", fontSize: 20);
                                  }
                                },
                                child: Text("Registrar",
                                  style: TextStyle(color: ColorsGenerals().whith, fontSize: 18),),
                                style: ElevatedButton.styleFrom(
                                  elevation: 8, // elevación de la sombra
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30), // radio de la esquina redondeada
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                                  backgroundColor: Colors.red, // color de fondo
                                ),

                              ),
                            ],
                          ):
                          estado == 0?
                          ElevatedButton(
                            onPressed: ()  {
                              setState(() {
                                visible = false;
                                glucosa.clear();
                                estado = 3;
                              });
                            },
                            child: Text("Cancelar",
                              style: TextStyle(color: ColorsGenerals().whith, fontSize: 18),),
                            style: ElevatedButton.styleFrom(
                              elevation: 8, // elevación de la sombra
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30), // radio de la esquina redondeada
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                              backgroundColor: Colors.red, // color de fondo
                            ),

                          )
                              :ElevatedButton(
                            onPressed: () async {
                              if(formKey.currentState!.validate()){
                                var gluco = glucosa.text;
                                EmergencyDetail response = await context.read<EmergencyCubit>().Emeregencia(gluco);
                                print(response.messege);
                                switch(response.stadeEmergency){
                                  case 0 :
                                    setState(() {
                                      visible = true;
                                      estado = response.stadeEmergency;
                                      unidades = response.insulina;
                                      snaks = response.food;
                                    });
                                    break;
                                  case 1 :
                                    setState(() {
                                      visible = true;
                                      estado = response.stadeEmergency;
                                      unidades = response.insulina;
                                    });
                                    break;
                                  case 2 :
                                    setState(() {
                                      visible = true;
                                      estado = response.stadeEmergency;
                                      unidades = response.insulina;
                                    });
                                    break;
                                  case 3 :
                                    Fluttertoast.showToast(
                                        msg: "Algo Fallo", fontSize: 20);
                                    break;
                                }
                              }
                            },
                            child: Text("Revisar",
                              style: TextStyle(color: ColorsGenerals().whith, fontSize: 18),),
                            style: ElevatedButton.styleFrom(
                              elevation: 8, // elevación de la sombra
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30), // radio de la esquina redondeada
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                              backgroundColor: Colors.red, // color de fondo
                            ),

                          )
                        ],
                      )
                  ),
                ),
              );
              break;
            case Emergencystatus.error:
              return Text("Me petatie");
              break;
          }
        },
      ),
    );
  }


  Widget Snaks(BuildContext context) =>
      ListView.builder(
          itemCount: snaks.length,
          itemBuilder: (context, index) {
            final favor = snaks[index];
            return GestureDetector(
              onTap: () {
                RegistrarSnak(context, snaks[index]);
              },
              child: Container(
                  padding: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height / 150, left: 3, right: 3),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorsGenerals().whith,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 0.5,
                            offset: Offset(0, 1),
                          ),
                        ]
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(snaks[index].name.length > 17 ? snaks[index].name.substring(0,16):snaks[index].name, style: TextStyle(
                                fontSize: 20, color: ColorsGenerals().black)),
                            Container(
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset("assets/Food/${snaks[index].image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment
                              .spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${double.parse(snaks[index].fats.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: ColorsGenerals().black)),
                                Text("Grasas", style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ColorsGenerals().black),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${double.parse(snaks[index].carbs.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: ColorsGenerals().black)),
                                Text("Carbohidratos", style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ColorsGenerals().black),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${double.parse(snaks[index].protein.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorsGenerals().black)),
                                Text("Proteína", style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ColorsGenerals().black)),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              )
            );
          }
      );
}

