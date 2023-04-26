import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gluko/colors/colorsGenerals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gluko/recommendePlate/view/recommendPlate_page.dart';
import 'package:gluko_repository/gluko_repository.dart';
import '../../assembleplate/view/assembleplate_page.dart';
import '../cubit/begin_cubit.dart';
import 'package:fl_chart/fl_chart.dart';

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

var glucosa = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
bool _isPressed = false;
var consumido = 100.0;
var objetivo = 130.0;
var insuObje = 4.3;
var insuRest = 1.3;
List<PlateRecomend> plates = [
  PlateRecomend([
    FoodDetail(38, "Arepa de maíz", 30.00, 2.00, 1.00, "imagen_arepa.png", 1, "pan"),
    FoodDetail(39, "Huevo batido", 0.00, 6.00, 5.00, "imagen_huevo.png", 1, "proteina"),
    FoodDetail(40, "Pan integral", 20.00, 4.00, 2.00, "imagen_pan.png", 1, "pan"),
    FoodDetail(41, "Tostadas integrales", 25.00, 3.00, 1.00, "imagen_tostadas.png", 1, "pan"),
  ], 190, 120, 34, 56, "Almuerzo", 4.6628781, -74.1380667, "Cra. 88 #17b-10, Fontibón, Bogotá, Cundinamarca", "Un almuerzo en el local 34 de hayuelos", 1), PlateRecomend([
    FoodDetail(38, "Arepa de maíz", 30.00, 2.00, 1.00, "imagen_arepa.png", 1, "pan"),
    FoodDetail(39, "Huevo batido", 0.00, 6.00, 5.00, "imagen_huevo.png", 1, "proteina"),
    FoodDetail(40, "Pan integral", 20.00, 4.00, 2.00, "imagen_pan.png", 1, "pan"),
    FoodDetail(41, "Tostadas integrales", 25.00, 3.00, 1.00, "imagen_tostadas.png", 1, "pan"),
  ], 190, 120, 34, 56, "Almuerzo", 4.6628781, -74.1380667, "Cra. 88 #17b-10, Fontibón, Bogotá, Cundinamarca", "Un almuerzo en el local 34 de hayuelos", 1),PlateRecomend([
    FoodDetail(38, "Arepa de maíz", 30.00, 2.00, 1.00, "imagen_arepa.png", 1, "pan"),
    FoodDetail(39, "Huevo batido", 0.00, 6.00, 5.00, "imagen_huevo.png", 1, "proteina"),
    FoodDetail(40, "Pan integral", 20.00, 4.00, 2.00, "imagen_pan.png", 1, "pan"),
    FoodDetail(41, "Tostadas integrales", 25.00, 3.00, 1.00, "imagen_tostadas.png", 1, "pan"),
  ], 190, 120, 34, 56, "Almuerzo", 4.6628781, -74.1380667, "Cra. 88 #17b-10, Fontibón, Bogotá, Cundinamarca", "Un almuerzo en el local 34 de hayuelos", 1),PlateRecomend([
    FoodDetail(38, "Arepa de maíz", 30.00, 2.00, 1.00, "imagen_arepa.png", 1, "pan"),
    FoodDetail(39, "Huevo batido", 0.00, 6.00, 5.00, "imagen_huevo.png", 1, "proteina"),
    FoodDetail(40, "Pan integral", 20.00, 4.00, 2.00, "imagen_pan.png", 1, "pan"),
    FoodDetail(41, "Tostadas integrales", 25.00, 3.00, 1.00, "imagen_tostadas.png", 1, "pan"),
  ], 190, 120, 34, 56, "Almuerzo", 4.6628781, -74.1380667, "Cra. 88 #17b-10, Fontibón, Bogotá, Cundinamarca", "Un almuerzo en el local 34 de hayuelos", 1),];

List<Posiciones> pos = [
  Posiciones(top: 50, left: 25),
  Posiciones(top: 30, left: 50),
  Posiciones(top: 50, left: 80),
  Posiciones(top: 60, left: 50)
];
class  _beginviewState extends State<beginview>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void armarplato() async{

    var info = glucosa.text.toString();
    print(info);
    glucosa.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                assembleplatepage(glucosa: info.toString() ))
    );
  }

  recibirGlucosa(BuildContext context) {
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
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Registra tu nivel de Glucosa", textAlign: TextAlign.center,style: TextStyle(
                          color: ColorsGenerals().black,
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height / 30),),
                    Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              maxLength: 3,
                              controller: glucosa,
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              cursorColor: ColorsGenerals().black,
                              style: TextStyle(color: ColorsGenerals().black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorsGenerals().lightgrey,
                                hintText: 'Inserte Nivel de glucosa',
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
                                prefixIcon: Icon(Icons.crisis_alert,
                                    color: ColorsGenerals().black),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese su nivel de glucosa';
                                }
                                return null;
                              },
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/200)),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.pop(context);
                                  armarplato();
                                }
                              },
                              child: Text("Armar plato",
                                style: TextStyle(color: ColorsGenerals().whith, fontSize: 15),),
                              style: ElevatedButton.styleFrom(
                                elevation: 8, // elevación de la sombra
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // radio de la esquina redondeada
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                backgroundColor: ColorsGenerals().red, // color de fondo
                              ),
                            )
                          ],
                        ),
                    ),
                    ],
                  ),
                );
              });
        });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          recibirGlucosa(context);
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SvgPicture.asset("assets/Icons/plato.svg",color: ColorsGenerals().whith,cacheColorFilter: false, width: MediaQuery.of(context).size.height/15,),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: ColorsGenerals().red,
          minimumSize: Size(60, 60),
        ),

      ),
      body: BlocBuilder<BeginCubit, BeginState>(
        builder: (context, states) {
          switch (states.status) {
            case Beginstatus.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case Beginstatus.success:
              return ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(
                      physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                  ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/1.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width /4,
                              height: MediaQuery.of(context).size.height /7,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:AssetImage("assets/Logo/gluko_bot_hi.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text("GlukoBot te saluda", style: TextStyle(color: ColorsGenerals().black, fontWeight: FontWeight.w500),)
                          ] ,
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
                                blurRadius: 1,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text("Tu estado actual", style: TextStyle(color: ColorsGenerals().black),),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.height/20,
                                    height: MediaQuery.of(context).size.height/20,
                                    child: Stack(
                                      children: [PieChart(
                                        PieChartData(
                                          sections: [
                                            PieChartSectionData(
                                                value: consumido,
                                                color: Colors.lightGreen,
                                                radius: 10,
                                                showTitle:false
                                            ),
                                            PieChartSectionData(
                                                value: objetivo - consumido,
                                                color: ColorsGenerals().whith,
                                                radius: 10,
                                                showTitle:false
                                            ),
                                          ],
                                          centerSpaceRadius: 30,
                                          sectionsSpace: 2,
                                          borderData: FlBorderData(show: false),
                                          startDegreeOffset: 270,
                                          pieTouchData: PieTouchData(enabled: false),
                                        ),
                                      ),
                                        Center(
                                          child: Text("${consumido.toInt()} g", style: TextStyle(color: ColorsGenerals().black, fontWeight: FontWeight.w500, fontSize: 14),),
                                        )
                                      ],
                                    )
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
                                  Container(
                    width: MediaQuery.of(context).size.height/20,
                    height: MediaQuery.of(context).size.height/20,
                    child: Stack(
                      children: [PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                                value: insuRest,
                                color: Colors.lightGreen,
                                radius: 10,
                                showTitle:false
                            ),
                            PieChartSectionData(
                                value: insuObje - insuRest,
                                color: ColorsGenerals().whith,
                                radius: 10,
                                showTitle:false
                            ),
                          ],
                          centerSpaceRadius: 30,
                          sectionsSpace: 2,
                          borderData: FlBorderData(show: false),
                          startDegreeOffset: 270,
                          pieTouchData: PieTouchData(enabled: false),
                        ),
                      ),Center(child: Text("${insuRest}U", style: TextStyle(color: ColorsGenerals().black, fontWeight: FontWeight.w500, fontSize: 17),),)
                      ],
                    )
                ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("¿Que deseas comer?",style: TextStyle(color: ColorsGenerals().black, fontSize: 20),),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height /50, horizontal: MediaQuery.of(context).size.width /20),
                                child: Container(
                                  height: MediaQuery.of(context).size.height /4.3,
                                  width: MediaQuery.of(context).size.width ,
                                  child: Alimentos(context),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
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

  Widget Alimentos(BuildContext context) =>
      ListView.builder(
          scrollDirection:Axis.horizontal,
          itemCount: plates.length,
          itemBuilder: (context, index) {
            final plComp = plates[index];
            return Padding(
              padding: EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RecomemendePlatepage(plComp))
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width/1.2,
                  height: MediaQuery.of(context).size.height /5,
                  decoration: BoxDecoration(
                    color: ColorsGenerals().lightgrey,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.2,
                        height: MediaQuery.of(context).size.height /5.5,
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2.5,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 3.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/Food/plato_v1.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                child: Stack(
                                  children: plComp.foods.length < 6
                                      ? ComidasEnPlato(plComp.foods)
                                      : ComidasEnPlato(plComp.foods)
                                      .sublist(0, 6),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height /6,
                              width: MediaQuery.of(context).size.width/3,
                              decoration: BoxDecoration(
                                color: ColorsGenerals().whith,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("-${plComp.foods[0].name}", style: TextStyle(fontSize: 11),),
                                  Text("-${plComp.foods[1].name}", style: TextStyle(fontSize: 11),),
                                  Text("-${plComp.foods[2].name}", style: TextStyle(fontSize: 11),),
                                  Text("-${plComp.foods[3].name}", style: TextStyle(fontSize: 11),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max ,children: [Icon(Icons.location_on_outlined, color: ColorsGenerals().black, size: 14,), Text("Donde Encontrarlo", style: TextStyle(fontSize: 14),)],)
                    ],
                  )
                ),
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
              child:  Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 40, width: 40,),
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
}