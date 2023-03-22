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

List<Posiciones> pos = [
  Posiciones(top: 60, left: 60),
  Posiciones(top: 40, left: 120),
  Posiciones(top: 60, left: 170),
  Posiciones(top: 80, left: 120)
];

class Comida{
  final String Nombre ;
  final String Fruta ;
  final int carbo;
  final String tipo;

  Comida({
    required this.Nombre,
    required this.Fruta,
    required this.carbo,
    required this.tipo
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
  double sensibilidad = 189;
  double dosisCorreccion = (glucemiaObjetivo - glucemiaActual)/sensibilidad;
  double gramosCarbohidratos = graCarbo;
  double ratioInsulina = 30;
  double dosisInsulina = gramosCarbohidratos/ratioInsulina;
  double unidInsulina =  dosisInsulina-dosisCorreccion;
  return unidInsulina;
}



var buscar = TextEditingController();
String glucosa = "";
List<FoodDetail> foodsList = [];
List<Comida> prueba = [
  Comida(Nombre: "Manzana", Fruta: "🍏", carbo: 100, tipo: "Grasa"),
  Comida(Nombre: "Pera", Fruta: "🍐", carbo: 70, tipo: "Proteina"),
  Comida(Nombre: "uva", Fruta: "🍇", carbo: 50, tipo: "Proteina"),
  Comida(Nombre: "coco", Fruta: "🥥", carbo: 20, tipo: "Verdura"),
  Comida(Nombre: "piña", Fruta: "🍍", carbo: 150, tipo: "Verdura"),
  Comida(Nombre: "tomate", Fruta: "🍅", carbo: 170, tipo: "Grasa")
];



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
                                  child: Text("Almuerzo", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w500),),
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
                                  child: Text("${TimeOfDay.now().hour}:${TimeOfDay.now().minute}", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w500),),
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

List<Comida> all = prueba;
List<FoodDetail> plato=[];
double proteina = 0;
double carbohidrato = 0;
double verduar = 0;
double grasas = 0;


class _assembleplateviewState extends State<assembleplateview> {

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
    buscar.clear();
    plato=[];
    proteina = 0;
    carbohidrato = 0;
    verduar = 0;
    grasas = 0;
    glucosa = widget.glucosa;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
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
                foodsList = states.foods;
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
                                              children: plato.length < 4
                                                  ? ComidasEnPlato(plato)
                                                  : ComidasEnPlato(plato)
                                                  .sublist(0, 4),
                                            ),
                                          ),
                                        ),
                                    onWillAccept: (data) => true,
                                    onAccept: (data) {
                                      print(data);
                                      for (int i = 0; i < foodsList.length; i++) {
                                        if (foodsList[i].id == data.id) {
                                          setState(() {
                                            carbohidrato = carbohidrato + foodsList[i].carbs;
                                            proteina =  proteina + foodsList[i].protein;
                                            grasas = grasas + foodsList[i].fats;
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
                                      Text("${grasas}g", style: TextStyle(
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
                                      Text("${carbohidrato}g", style: TextStyle(
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
                                      Text("${proteina}g", style: TextStyle(
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
                                    all = prueba;
                                  });
                                }else{
                                  setState(() {
                                    all = all.where((bus) => bus.Nombre.toLowerCase().contains(text)|| bus.tipo.toLowerCase().contains(text)).toList();
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
                            child: Image.asset("assets/Food/${foodsList[index].image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
                          ),
                        ),
                        feedback: Material(
                          color: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            height: 100,
                            padding: EdgeInsets.all(10),
                            child: Image.asset("assets/Food/${foodsList[index].image.replaceAll('.jpg', '.png')}", height: 100, width: 100,),
                          ),
                        ),
                        childWhenDragging: Material(
                          color: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            height: 80,
                            padding: EdgeInsets.all(10),
                            child: Image.asset("assets/Food/${foodsList[index].image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
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

    for (int i = 0; i < frut.length; i++) {
      final com = frut[i];
      if (i < pos.length) {
        widgets.add(
          Positioned(
            left: pos[i].left,
            top: pos[i].top,
            child: Material(
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                height: 80,
                padding: EdgeInsets.all(10),
                child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
              ),
            ),
          ),
        );
      } else {
        widgets.add(
          Positioned(
            left: 0,
            top: 0,
            child: Material(
            color: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              height: 80,
              padding: EdgeInsets.all(10),
              child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
            ),
          ),
          ),
        );
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
                      Text(foodsList[index].name.length > 17 ? foodsList[index].name.substring(0,16):foodsList[index].name, style: TextStyle(
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
                                child: Image.asset("assets/Food/${foodsList[index].image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
                              ),
                            ),
                          ),
                          IconButton(onPressed: () {
                            setState(() {
                              carbohidrato = carbohidrato - plato[index].carbs;
                              proteina = proteina - plato[index].protein;
                              grasas = grasas - plato[index].fats;
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

