import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gluko/colors/colorsGenerals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gluko_repository/gluko_repository.dart';
import '../cubit/assembleplate_cubit.dart';

class assembleplatepage extends StatelessWidget {
  final String glucosa;
  assembleplatepage({required this.glucosa});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssembleplateCubit(allfoodRepository())..getFoods(),
      child: assembleplateview( glucosa: glucosa ,),
    );
  }
}


class Posiciones{
  final double top;
  final double left;

  Posiciones({
    required this.top,
    required this.left
});
}




class assembleplateview extends StatefulWidget {
  final String glucosa;
  assembleplateview({required this.glucosa});
  @override
  State<assembleplateview> createState() => _assembleplateviewState();
}

double CalculoUnidades(double glAct, double graCarbo){
  double glucemiaObjetivo = 120;
  double glucemiaActual = glAct;
  double sensibilidad = 40;
  double dosisCorreccion = (glucemiaObjetivo - glucemiaActual)/sensibilidad;
  double gramosCarbohidratos = graCarbo;
  double ratioInsulina = 14;
  double dosisInsulina = gramosCarbohidratos/ratioInsulina;
  double unidInsulina =  dosisInsulina.abs()+dosisCorreccion.abs();
  return unidInsulina;
}



var buscar = TextEditingController();
String glucosa = "";
List<FoodDetail> foodsList = [];
List<FoodDetail> prueba = [];



Future<void> showMyPopup(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return  Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width/3,
          height: MediaQuery.of(context).size.height/1.5,
          color: Colors.transparent,
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width/1.2,
                    height: MediaQuery.of(context).size.height/2,
                    decoration: BoxDecoration(
                      color: ColorsGenerals().whith,
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                                  child: Text( hora > 0 && hora < 13 ?"Desayuno": hora > 13 && hora < 18 ? "Almuerzo": "Cena", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w500),),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                                  child: Text("${hora}:${TimeOfDay.now().minute}", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w500),),
                                )
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/1.6,
                              height: MediaQuery.of(context).size.height/5,
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("Glucemia",textAlign: TextAlign.left, style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w500)),
                                      Text("Insulina",textAlign: TextAlign.left, style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w500)),
                                      Text("Carbohidratos",textAlign: TextAlign.left, style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    width: 1,
                                    height: MediaQuery.of(context).size.height/6,
                                    color: ColorsGenerals().darkgrey,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("${glucosa}", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w500),),
                                      Text("${CalculoUnidades(double.parse(glucosa), carbohidrato).toInt()}U", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w500)),
                                      Text("${carbohidrato}g", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [ElevatedButton(
                                onPressed: () {
                                },
                                child: Text("Compartir",
                                  style: TextStyle(color: ColorsGenerals().whith),),
                                style: ElevatedButton.styleFrom(
                                  elevation: 8, // elevación de la sombra
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30), // radio de la esquina redondeada
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                  backgroundColor: Colors.red, // color de fondo
                                ),

                              ),
                                ElevatedButton(
                                  onPressed: () {
                                  },
                                  child: Text("Guardar Registro",
                                    style: TextStyle(color: ColorsGenerals().whith),),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8, // elevación de la sombra
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30), // radio de la esquina redondeada
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                    backgroundColor: Colors.red, // color de fondo
                                  ),

                                ),
                              ],
                            )
                          ],

                    ),
                  )
                ]
            ),
          ),
        ),
      );

    },
  );
}

List<FoodDetail> plato=[];
List<FoodDetail> aux=[];
double proteina = 0;
double carbohidrato = 0;
double verduar = 0;
double grasas = 0;
var hora = 0;


class _assembleplateviewState extends State<assembleplateview> {

  List<FoodDetail> bebidas = [];
  List<FoodDetail> sopas = [];
  List<Posiciones> pos = [
    Posiciones(top: 60, left: 60),
    Posiciones(top: 40, left: 110),
    Posiciones(top: 60, left: 170),
    Posiciones(top: 85, left: 110)
  ];


  editplato(BuildContext context) {
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
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(color: ColorsGenerals().whith,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Camida en plato", style: TextStyle(
                          color: ColorsGenerals().black,
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height / 30),),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 2.3,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: PlatoEditar(context),
                      ),
                    ],
                  ),
                );
              });
        });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscar.text = "";
    plato=[];
    proteina = 0;
    carbohidrato = 0;
    verduar = 0;
    grasas = 0;
    glucosa = widget.glucosa;
  }
  int p = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                hora = TimeOfDay.now().hour;
              });
              showMyPopup(context);
            },
            child: Text("Calculo Insulina",
              style: TextStyle(color: ColorsGenerals().whith),),
            style: ElevatedButton.styleFrom(
              elevation: 8, // elevación de la sombra
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    30), // radio de la esquina redondeada
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              backgroundColor: Colors.red, // color de fondo
            ),

          ),
        ),
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
                "Armar Plato ",
                style: TextStyle(color: Colors.black, fontSize: 25),
              )
              ],
            )
            ],
        ),
        body: BlocBuilder<AssembleplateCubit, AssembleplateState>(
          builder: (context, states) {
            switch (states.status) {
              case Assembleplatestatus.loading:
                return Center(child: CircularProgressIndicator(color: ColorsGenerals().red,));
                break;
              case Assembleplatestatus.success:
                prueba = states.foods;
                return Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  color: ColorsGenerals().whith,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 2.9,
                        decoration: BoxDecoration(
                            color: ColorsGenerals().lightgrey,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () {
                                editplato(context);
                              },
                              child: Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(100)),
                                ),
                                child: Center(
                                  child: DragTarget<FoodDetail>(
                                    builder: (BuildContext context,
                                        List incoming,
                                        List<dynamic> rejected) =>
                                        Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width / 1.2,
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height / 3,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/Food/plato_v1.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Container(
                                            child: Stack(
                                              children: plato.length < 6
                                                  ? ComidasEnPlato(plato)
                                                  : ComidasEnPlato(plato)
                                                  .sublist(0, 6),
                                            ),
                                          ),
                                        ),
                                    onWillAccept: (data) => true,
                                    onAccept: (data) {
                                      print(data.name);
                                      for (int i = 0; i < foodsList.length; i++) {
                                        if (foodsList[i].id == data.id) {
                                          setState(() {
                                            carbohidrato = carbohidrato + data.carbs;
                                            proteina =  proteina + data.protein;
                                            grasas = grasas + data.fats;
                                            if(data.tag == "bebida"){
                                              bebidas.add(data);
                                            }
                                            if(data.tag == "sopa"){
                                              sopas.add(data);
                                            }
                                            plato.add(data);
                                          });
                                        }
                                      }
                                    },
                                    onLeave: (data) {},
                                  ),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(
                                vertical: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 100)),
                            Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 15,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${double.parse(grasas.toStringAsFixed(1)).abs()}g", style: TextStyle(
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
                                      Text("${double.parse(carbohidrato.toStringAsFixed(1)).abs()}g", style: TextStyle(
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
                                      Text("${double.parse(proteina.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorsGenerals().black)),
                                      Text("Proteina", style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: ColorsGenerals().black)),
                                    ],
                                  ),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery
                          .of(context)
                          .size
                          .height / 90)),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextField(
                              onChanged: (text){
                                if(text.isEmpty){
                                  setState(() {
                                    foodsList = prueba;
                                  });
                                }else{
                                  setState(() {
                                    foodsList = states.foods.where((bus) => bus.name.toLowerCase().contains(text)|| bus.tag.toLowerCase().contains(text)).toList();
                                  });
                                }
                              },
                              controller: buscar,
                              cursorColor: ColorsGenerals().black,
                              style: TextStyle(color: ColorsGenerals().black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorsGenerals().lightgrey,
                                hintText: 'Buscar...',
                                hintStyle: TextStyle(
                                    color: ColorsGenerals().black),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
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
                                prefixIcon: Icon(Icons.search,
                                    color: ColorsGenerals().black),
                              ),
                            ),
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
                                  .height / 2.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorsGenerals().lightgrey,
                              ),
                              child: Alimentos(context),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
                break;
              case Assembleplatestatus.error:
                return Text("Me petatie");
                break;
            }
          },
        ));
  }



  Widget Alimentos(BuildContext context) =>
      ListView.builder(
          itemCount: foodsList.length,
          itemBuilder: (context, index) {
            final favor = foodsList[index];
            return Container(
              padding: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height / 150),
              child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 10,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(foodsList[index].name.length > 17 ? foodsList[index].name.substring(0,16):foodsList[index].name, style: TextStyle(
                          fontSize: 16, color: ColorsGenerals().black)),
                      Draggable<FoodDetail>(
                        data: foodsList[index],
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            height: 80,
                            padding: EdgeInsets.all(10),
                            child: Image.asset("assets/Food/${foodsList[index].image}", height: 60, width: 60,),
                          ),
                        ),
                        feedback: Material(
                          color: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            height: 100,
                            padding: EdgeInsets.all(10),
                            child: Image.asset("assets/Food/${foodsList[index].image}", height: 100, width: 100,),
                          ),
                        ),
                        childWhenDragging: Material(
                          color: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            height: 80,
                            padding: EdgeInsets.all(10),
                            child: Image.asset("assets/Food/${foodsList[index].image}", height: 60, width: 60,),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            );
          }
      );

  List<Widget> ComidasEnPlato(List<FoodDetail> frut) {
    List<Widget> widgets = [];
    int platoPos = 0;
    for (int i = 0; i < frut.length; i++) {
      final com = frut[i];
      if (platoPos < pos.length && com.tag != "bebida" && com.tag != "sopa") {
        widgets.add(
          Positioned(
            left: pos[platoPos].left,
            top: pos[platoPos].top,
            child: Material(
              color: Colors.transparent,
              child:  Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 80, width: 80,),
            ),
          ),
        );
        platoPos++;
      } else {
        if(com.tag == "bebida"){
          print("Pone la bebida");
          widgets.add(
            Positioned(
              left: 10,
              top: 120,
              child: Material(
                color: Colors.transparent,
                child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 80, width: 80,),
              ),
            ),
          );
        }
        else{
          if(com.tag == "sopa"){
            widgets.add(
              Positioned(
                left: 200,
                top: 120,
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 80, width: 80,),
                ),
              ),
            );
          }else{
            widgets.add(
              Positioned(
                left: 400,
                top: 400,
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 80, width: 80,),
                ),
              ),
            );
          }
        }

      }
    }
    return widgets;
  }
  Widget PlatoEditar(BuildContext context) =>
      ListView.builder(
          itemCount: plato.length,
          itemBuilder: (context, index) {
            final favor = plato[index];
            return Container(
              padding: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height / 150),
              child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 10,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorsGenerals().lightgrey,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(plato[index].name.length > 17 ? plato[index].name.substring(0,16):plato[index].name, style: TextStyle(
                          fontSize: 20, color: ColorsGenerals().black)),
                      Row(
                        children: [
                          Container(
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                alignment: Alignment.center,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/Food/${plato[index].image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
                              ),
                            ),
                          ),
                          IconButton(onPressed: () {
                            setState(() {
                              carbohidrato = carbohidrato - double.parse(plato[index].carbs.toStringAsFixed(1));
                              proteina = proteina - double.parse(plato[index].protein.toStringAsFixed(1));
                              grasas = grasas - double.parse(plato[index].fats.toStringAsFixed(1));
                              plato.removeAt(index);
                            });
                            Navigator.pop(context);
                          },
                              icon: Icon(Icons.delete_outline,
                                color: ColorsGenerals().red,))
                        ],
                      ),
                    ],
                  )
              ),
            );
          }
      );
}

