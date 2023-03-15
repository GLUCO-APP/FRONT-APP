import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/assembleplate_cubit.dart';

class assembleplatepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssembleplateCubit(),
      child: assembleplateview(),
    );
  }
}


class Comida{
  final String Nombre ;
  final String Fruta ;
  final int carbo;
  final String tipo;
  final double top;
  final double  left;

  Comida({
    required this.Nombre,
    required this.Fruta,
    required this.carbo,
    required this.tipo,
    required this.left,
    required this.top
  });
}
List<Comida> all = [
  Comida(Nombre: "Manzana", Fruta: "🍏", carbo: 100, tipo: "Grasa",top: 10,left: 90),
  Comida(Nombre: "Pera", Fruta: "🍐", carbo: 70, tipo: "Proteina",top: 20,left: 40),
  Comida(Nombre: "uva", Fruta: "🍇", carbo: 50, tipo: "Proteina",top: 20,left: 40),
  Comida(Nombre: "coco", Fruta: "🥥", carbo: 20, tipo: "Verdura",top: 40,left: 90),
  Comida(Nombre: "piña", Fruta: "🍍", carbo: 150, tipo: "Verdura",top: 40,left: 90),
  Comida(Nombre: "tomate", Fruta: "🍅", carbo: 170, tipo: "Grasa",top: 20,left: 140)
];
List<Comida> verdura=[];
List<Comida> Carbos=[];
List<Comida> Protes=[];
List<Comida> plato=[];
var buscar = TextEditingController();

int proteina = 0;
int carbohidrato = 0;
int verduar = 0;
int grasas = 0;

class assembleplateview extends StatefulWidget {
  @override
  State<assembleplateview> createState() => _assembleplateviewState();
}

class _assembleplateviewState extends State<assembleplateview>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomInset:false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Armar Plato",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<AssembleplateCubit, AssembleplateState>(
          builder: (context, states) {
            switch (states.status) {
              case Assembleplatestatus.loading:
                return Center(child: CircularProgressIndicator());
                break;
              case Assembleplatestatus.success:
                return Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(100)),
                    color: Color.fromARGB(255, 234, 234, 234),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, -5),
                        blurRadius: 2,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                            height: MediaQuery.of(context).size.height /3.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                            ),
                            child: Center(
                              child: DragTarget<String>(
                                builder: (BuildContext context, List incoming, List<dynamic> rejected) => Container(
                                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height /14, horizontal: MediaQuery.of(context).size.width /13),
                                    width: MediaQuery.of(context).size.width /1.2,
                                    height: MediaQuery.of(context).size.height /3,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/Food/plato_v1.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Container(
                                      child: Stack(
                                        children: ComidasEnPlato(plato),
                                      ),
                                    ),
                                ),
                                onWillAccept: (data)=> true,
                                onAccept: (data){
                                  print(data);
                                  for(int i = 0 ; i <all.length;i++){
                                    if(all[i].Fruta == data){
                                      setState(() {
                                        carbohidrato = carbohidrato + all[i].carbo;
                                        switch(all[i].tipo){
                                          case "Proteina":
                                            proteina = proteina + all[i].carbo;
                                            plato.add(all[i]);
                                            print(Protes);
                                            break;
                                          case "Grasa":
                                            grasas = grasas + all[i].carbo;
                                            plato.add(all[i]);
                                            break;
                                          case "Verdura":
                                            verduar = verduar + all[i].carbo;
                                            plato.add(all[i]);
                                            break;
                                        }
                                      });
                                    }
                                  }
                                },
                                onLeave: (data){
                                },
                              ),
                            ),
                          ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            Container(
                              height: MediaQuery.of(context).size.height/15,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Carbohidratos: ${carbohidrato}g", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      Text("Grasas: ${grasas}g", style: TextStyle(fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Proteina: ${proteina}g", style: TextStyle(fontWeight: FontWeight.w500)),
                                      Text("Verdura: ${verduar}g", style: TextStyle(fontWeight: FontWeight.w500)),
                                    ],
                                  )
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.3,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextField(
                              controller: buscar,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 54, 54, 68),
                                hintText: 'Buscar...',
                                hintStyle: TextStyle(color: Colors.white),
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
                                prefixIcon: Icon(Icons.search, color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height /2.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(255, 217, 217, 217),
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

  Widget Alimentos(BuildContext context1) => ListView.builder(
      itemCount: all.length,
      itemBuilder: (context, index){
        final favor = all[index];
        return Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/150),
          child: Container(
              height: MediaQuery.of(context).size.height/10 ,
              width: MediaQuery.of(context).size.width ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(all[index].Nombre, style: TextStyle(fontSize: 20)),
                  Draggable<String>(
                    data: all[index].Fruta.toString(),
                    child:  Material(
                      color: Colors.transparent,
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          all[index].Fruta,
                          style: TextStyle(color: Colors.black, fontSize: 30),
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
                          style: TextStyle(color: Colors.black, fontSize: 70),
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
                          style: TextStyle(color: Colors.black, fontSize: 30),
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
    return frut.map((com) =>
        Positioned(
          left: com.left,
          top: com.top,
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
          )
        ),

    ).toList();
  }
}

