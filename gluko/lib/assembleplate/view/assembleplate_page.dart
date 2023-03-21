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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssembleplateCubit(allfoodRepository())..getFoods(),
      child: assembleplateview(),
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
  @override
  State<assembleplateview> createState() => _assembleplateviewState();
}

var buscar = TextEditingController();
List<Comida> prueba = [
  Comida(Nombre: "Manzana", Fruta: "🍏", carbo: 100, tipo: "Grasa"),
  Comida(Nombre: "Pera", Fruta: "🍐", carbo: 70, tipo: "Proteina"),
  Comida(Nombre: "uva", Fruta: "🍇", carbo: 50, tipo: "Proteina"),
  Comida(Nombre: "coco", Fruta: "🥥", carbo: 20, tipo: "Verdura"),
  Comida(Nombre: "piña", Fruta: "🍍", carbo: 150, tipo: "Verdura"),
  Comida(Nombre: "tomate", Fruta: "🍅", carbo: 170, tipo: "Grasa")
];
class _assembleplateviewState extends State<assembleplateview> {
  List<Comida> all = prueba;
  List<Comida> plato=[];
  int proteina = 0;
  int carbohidrato = 0;
  int verduar = 0;
  int grasas = 0;
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
                print(states.foods.toString());
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
                                  child: DragTarget<String>(
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
                                      for (int i = 0; i < all.length; i++) {
                                        if (all[i].Fruta == data) {
                                          print(all[i].Fruta);
                                          setState(() {
                                            carbohidrato =
                                                carbohidrato + all[i].carbo;
                                          });
                                          switch (all[i].tipo) {
                                            case "Proteina":
                                              setState(() {
                                                proteina =
                                                    proteina + all[i].carbo;
                                                plato.add(all[i]);
                                              });
                                              break;
                                            case "Grasa":
                                              setState(() {
                                                grasas = grasas + all[i].carbo;
                                                plato.add(all[i]);
                                              });
                                              break;
                                            case "Verdura":
                                              setState(() {
                                                verduar =
                                                    verduar + all[i].carbo;
                                                plato.add(all[i]);
                                              });
                                              break;
                                          }
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
                      Text(plato[index].Nombre, style: TextStyle(
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
                                child: Text(
                                  plato[index].Fruta,
                                  style: TextStyle(
                                    color: Colors.black, fontSize: 30,),
                                ),
                              ),
                            ),
                          ),
                          IconButton(onPressed: () {
                            setState(() {
                              carbohidrato = carbohidrato - plato[index].carbo;
                              switch (plato[index].tipo) {
                                case "Proteina":
                                  setState(() {
                                    proteina = proteina - plato[index].carbo;
                                  });
                                  break;
                                case "Grasa":
                                  setState(() {
                                    grasas = grasas - plato[index].carbo;
                                  });
                                  break;
                                case "Verdura":
                                  setState(() {
                                    verduar = verduar - plato[index].carbo;
                                  });
                                  break;
                              }
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


  Widget Alimentos(BuildContext context) =>
      ListView.builder(
          itemCount: all.length,
          itemBuilder: (context, index) {
            final favor = all[index];
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
                      Text(all[index].Nombre, style: TextStyle(
                          fontSize: 20, color: ColorsGenerals().black)),
                      Draggable<String>(
                        data: all[index].Fruta.toString(),
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            height: 80,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              all[index].Fruta,
                              style: TextStyle(
                                color: Colors.black, fontSize: 30,),
                            ),
                          ),
                        ),
                        feedback: Material(
                          color: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            height: 100,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              all[index].Fruta,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 70),
                            ),
                          ),
                        ),
                        childWhenDragging: Material(
                          color: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            height: 80,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              all[index].Fruta,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 30),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            );
          }
      );

  List<Widget> ComidasEnPlato(List<Comida> frut) {
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
                height: 70,
                child: Text(
                  com.Fruta,
                  style: TextStyle(color: Colors.black, fontSize: 60),
                ),
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
                height: 70,
                child: Text(
                  com.Fruta,
                  style: TextStyle(color: Colors.black, fontSize: 60),
                ),
              ),
            ),
          ),
        );
      }
    }
    return widgets;
  }

}

