import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gluko/colors/colorsGenerals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gluko/recommendePlate/view/recommendPlate_page.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:intl/intl.dart';
import '../../assembleplate/view/assembleplate_page.dart';
import '../../calculateinsulin/view/calculateinsulina_page.dart';
import '../../historyReport/view/historyReport_page.dart';
import '../../notifications/pushNotification.dart';
import '../cubit/begin_cubit.dart';
import 'package:fl_chart/fl_chart.dart';

class beginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BeginCubit(ActualStatusRepository())..getEstadoActual()..getRecomendacion(),
      child: beginview(),
    );
  }
}

class beginview extends StatefulWidget {
  @override
  State<beginview> createState() => _beginviewState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();
bool _isPressed = false;
var consumido = 100.0;
var objetivo = 130.0;
var insuObje = 4.3;
var insuRest = 1.3;
var glucoActual = 148.0;
var glucoMax = 190.0;
var hora = "8:30";

ActualStateDetail actualEstado = ActualStateDetail(0, 0, 0, "", 0,0);
List<PlateRecomend> plates = [];

List<Posiciones> pos = [
  Posiciones(top: 50, left: 25),
  Posiciones(top: 30, left: 50),
  Posiciones(top: 50, left: 80),
  Posiciones(top: 60, left: 50)
];

class _beginviewState extends State<beginview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BeginCubit, BeginState>(
        builder: (context, states) {
          switch (states.status) {
            case Beginstatus.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case Beginstatus.success:
              actualEstado = context.read<BeginCubit>().getEstado();
              consumido = actualEstado.sum_carbs;
              objetivo = actualEstado.objective_carbs;
              insuObje = 10;
              insuRest = actualEstado.unidades_insulina;
              glucoActual = actualEstado.glucosa;
              glucoMax = actualEstado.glucemiamax;
              String fechaString = actualEstado.fecha;
              DateTime fecha = DateTime.parse(fechaString);

              String horatipo = DateFormat('h:mm a')
                  .format(fecha);
              String hora = "$horatipo";
              plates = states.recomend;
              print(plates.length);
              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                    physics:
                        BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                    ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryReportpage()));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                MediaQuery.of(context).size.height / 150,
                                horizontal:
                                MediaQuery.of(context).size.width / 50),
                            width: MediaQuery.of(context).size.width/1.1,
                            height: MediaQuery.of(context).size.height / 3.6,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Ultima toma: $hora",textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height / 4.5,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: MediaQuery.of(context).size.width/36,
                                        top: MediaQuery.of(context).size.height / 10,
                                        child: Container(
                                          width:
                                          MediaQuery.of(context).size.width /
                                              4,
                                          height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                          child: Column(
                                            children: [
                                              Container(
                                                  width:
                                                  MediaQuery.of(context).size.height /
                                                      20,
                                                  height:
                                                  MediaQuery.of(context).size.height /
                                                      20,
                                                  child: Stack(
                                                    children: [
                                                      PieChart(
                                                        PieChartData(
                                                          sections: [
                                                            PieChartSectionData(
                                                                value: consumido < objetivo
                                                                    ? consumido
                                                                    : objetivo,
                                                                color: consumido < objetivo
                                                                    ? Colors.lightGreen
                                                                    : ColorsGenerals()
                                                                    .whith,
                                                                radius: 10,
                                                                showTitle: false),
                                                            PieChartSectionData(
                                                                value: consumido < objetivo
                                                                    ? objetivo - consumido
                                                                    : consumido - objetivo,
                                                                color: consumido < objetivo
                                                                    ? ColorsGenerals().whith
                                                                    : ColorsGenerals().red,
                                                                radius: 10,
                                                                showTitle: false),
                                                          ],
                                                          centerSpaceRadius: 30,
                                                          sectionsSpace: 2,
                                                          borderData:
                                                          FlBorderData(show: false),
                                                          startDegreeOffset: 270,
                                                          pieTouchData:
                                                          PieTouchData(enabled: false),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          "${consumido.toInt()} g",
                                                          style: TextStyle(
                                                              color: ColorsGenerals().black,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 13),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                              Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height /60,)),
                                              Text("Carbohidratos", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),)
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: MediaQuery.of(context).size.width/3,
                                        top: MediaQuery.of(context).size.height / 20,
                                        child: Container(
                                          width:
                                          MediaQuery.of(context).size.width /
                                              5,
                                          height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                  width:
                                                  MediaQuery.of(context).size.height /
                                                      20,
                                                  height:
                                                  MediaQuery.of(context).size.height /
                                                      20,
                                                  child: Stack(
                                                    children: [
                                                      PieChart(
                                                        PieChartData(
                                                          sections: [
                                                            PieChartSectionData(
                                                                value: glucoActual < glucoMax
                                                                    ? glucoActual
                                                                    : glucoMax,
                                                                color: glucoActual < glucoMax
                                                                    ? Colors.lightGreen
                                                                    : ColorsGenerals()
                                                                    .whith,
                                                                radius: 12,
                                                                showTitle: false),
                                                            PieChartSectionData(
                                                                value: glucoActual < glucoMax
                                                                    ? glucoMax - glucoActual
                                                                    : glucoActual - glucoMax,
                                                                color: glucoActual < glucoMax
                                                                    ? ColorsGenerals().whith
                                                                    : ColorsGenerals().red,
                                                                radius: 12,
                                                                showTitle: false),
                                                          ],
                                                          centerSpaceRadius: 45,
                                                          sectionsSpace: 2,
                                                          borderData:
                                                          FlBorderData(show: false),
                                                          startDegreeOffset: 270,
                                                          pieTouchData:
                                                          PieTouchData(enabled: false),
                                                        ),
                                                      ),
                                                      Center(
                                                        child:  Container(
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "${glucoActual.toInt()}",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                    color: ColorsGenerals().black,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 17),
                                                              ),
                                                              Text(
                                                                "mg/dl",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                    color: ColorsGenerals().black,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 13),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                              Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height /40,)),
                                              Text("Glucemia", style: TextStyle(fontSize: 14),)
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: MediaQuery.of(context).size.width/1.6,
                                        top: MediaQuery.of(context).size.height / 10,
                                        child: Container(
                                          width:
                                          MediaQuery.of(context).size.width /
                                              5,
                                          height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                          child: Column(
                                            children: [
                                              Container(
                                                  width:
                                                  MediaQuery.of(context).size.height /
                                                      20,
                                                  height:
                                                  MediaQuery.of(context).size.height /
                                                      20,
                                                  child: Stack(
                                                    children: [
                                                      PieChart(
                                                        PieChartData(
                                                          sections: [
                                                            PieChartSectionData(
                                                                value: insuRest,
                                                                color: Colors.lightGreen,
                                                                radius: 10,
                                                                showTitle: false),
                                                            PieChartSectionData(
                                                                value: insuObje - insuRest,
                                                                color:
                                                                ColorsGenerals().whith,
                                                                radius: 10,
                                                                showTitle: false),
                                                          ],
                                                          centerSpaceRadius: 30,
                                                          sectionsSpace: 2,
                                                          borderData:
                                                          FlBorderData(show: false),
                                                          startDegreeOffset: 270,
                                                          pieTouchData:
                                                          PieTouchData(enabled: false),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          "${insuRest}U",
                                                          style: TextStyle(
                                                              color: ColorsGenerals().black,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                              Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height /70,)),
                                              Text("Insulina",textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "¿Qué deseas comer?",
                              style: TextStyle(
                                  color: ColorsGenerals().black, fontSize: 20),
                            ),
                            SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height / 50,
                                    horizontal:
                                        MediaQuery.of(context).size.width / 40),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4.3,
                                  width: MediaQuery.of(context).size.width,
                                  child: states.recomendS ? plates.length > 0? Alimentos(context):
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width / 1.2,
                                    height: MediaQuery.of(context).size.height / 5,
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
                                    child: Center(
                                      child: Text("No hay recomendaciones disponibles"),
                                    ),
                                  ):Container(
                                    padding: EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width / 1.2,
                                    height: MediaQuery.of(context).size.height / 5,
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
                                    child: Center(
                                      child: CircularProgressIndicator(color: ColorsGenerals().red,),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  height: MediaQuery.of(context).size.height / 10,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/Logo/gluko_bot_hi.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  "GlukoBot te saluda",
                                  style: TextStyle(
                                      color: ColorsGenerals().black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => assembleplatepage()));
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
                                Text(
                                  "Armar plato",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorsGenerals().black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ],
                            )
                          ],
                        )
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

  Widget Alimentos(BuildContext context) => ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: plates.length,
      itemBuilder: (context, index) {
        final plComp = plates[index];
        return Padding(
          padding: EdgeInsets.all(0),
          child: GestureDetector(
            onTap: () async {
              var validation = await checkLocationPermission();
              if (!validation) {
                await requestLocationPermission();
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecomemendePlatepage(plComp)));
              }
            },
            child: Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 5,
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
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 5.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 3.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/Food/plato_v1.png"),
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
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              color: ColorsGenerals().whith,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListView(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: plComp.foods
                                      .map((food) => Text("-${food.name}",
                                          style: TextStyle(fontSize: 11)))
                                      .toList(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: ColorsGenerals().black,
                          size: 14,
                        ),
                        Text(
                          "¿Dónde encontrarlo?",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    )
                  ],
                )),
          ),
        );
      });

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
              child: Image.asset(
                "assets/Food/${com.image.replaceAll('.jpg', '.png')}",
                height: 40,
                width: 40,
              ),
            ),
          ),
        );
        platoPos++;
      } else {
        if (com.tag == "bebida") {
          print("Pone la bebida");
          widgets.add(
            Positioned(
              left: 10,
              top: 75,
              child: Material(
                color: Colors.transparent,
                child: Image.asset(
                  "assets/Food/${com.image.replaceAll('.jpg', '.png')}",
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          );
        } else {
          if (com.tag == "sopa") {
            widgets.add(
              Positioned(
                left: 200,
                top: 75,
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset(
                    "assets/Food/${com.image.replaceAll('.jpg', '.png')}",
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
            );
          } else {
            widgets.add(
              Positioned(
                left: 400,
                top: 400,
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset(
                    "assets/Food/${com.image.replaceAll('.jpg', '.png')}",
                    height: 40,
                    width: 40,
                  ),
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
