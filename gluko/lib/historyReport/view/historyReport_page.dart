import 'dart:ffi';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:intl/intl.dart';

import '../../colors/colorsGenerals.dart';
import '../cubit/history_report_cubit.dart';


class HistoryReportpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryReportCubit(allReportRepository())..getReports(),
      child: HistoryReportview(),
    );
  }
}


class HistoryReportview extends StatefulWidget {
  @override
  State<HistoryReportview> createState() => _HistoryReportviewState();
}


var day = DateTime.now();
var maxima = 170.0;
var tam = 30.0;
var tam1 = 30.0;
var tam2 = 30.0;

List<dynamic> days = [
  DateFormat('MM-dd').format(day.subtract(Duration(days: 6))),
  DateFormat('MM-dd').format(day.subtract(Duration(days: 5))),
  DateFormat('MM-dd').format(day.subtract(Duration(days: 4))),
  DateFormat('MM-dd').format(day.subtract(Duration(days: 3))),
  DateFormat('MM-dd').format(day.subtract(Duration(days: 2))),
  DateFormat('MM-dd').format(day.subtract(Duration(days: 1))),
  DateFormat('MM-dd').format(day),];
List<ReportDetail> reports = [];


class  _HistoryReportviewState extends State<HistoryReportview>{
  List<double> barras = [0, 0, 0, 0, 0, 0, 0];
  List<double> glucemia = [0, 0, 0];
  List<double> objetivoGlu = [25, 120];
  void calculoCarboPromedio(){
    for(int i = 0; i < days.length; i++){
      var suma = 0.0;
      for(int j = 0; j<reports.length; j++){
        if(reports[j].fecha.toString().contains(days[i])){
          suma = suma+ double.parse(reports[j].Carbohydrates);

          if(double.parse(reports[j].glucosa) < objetivoGlu[0]){
            glucemia[0]++;
            print(reports[j].glucosa);
          }
          if(double.parse(reports[j].glucosa) > objetivoGlu[0] &&  double.parse(reports[j].unidades_insulina) < objetivoGlu[1]){
            glucemia[1]++;
          }
          if(double.parse(reports[j].glucosa) > objetivoGlu[1]){
            glucemia[2]++;
          }
        }
      }
      barras[i]= suma;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<double> barras = [25, 50, 75, 100, 125, 10, 175];
    List<double> glucemia = [0, 0, 0];
    List<double> objetivoGlu = [25, 120];
  }

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
          children: const [Text(
            "Historial de reportes   ",
            style: TextStyle(color: Colors.black, fontSize: 22),
          )
          ],
        )
        ],
      ),
      body: BlocBuilder<HistoryReportCubit, HistoryReportState>(
        builder: (context, states) {
          switch (states.status) {
            case HistoryReportstatus.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case HistoryReportstatus.success:
              reports = context.read<HistoryReportCubit>().reports();
              var use = context.read<HistoryReportCubit>().infoUser();
              objetivoGlu[0] = use.hipo.toDouble();
              objetivoGlu[1] = use.hyper.toDouble();
              print(objetivoGlu);
              print(barras[0].toDouble());
              calculoCarboPromedio();
              maxima = barras.fold(barras.first, (a, b) => a > b ? a : b) + 30;
              print(glucemia);
              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                    physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                ),
                child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.all(12),
                      height: MediaQuery.of(context).size.height * 1.36,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            height: MediaQuery.of(context).size.height/2.3,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: ColorsGenerals().lightgrey,
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 16),
                                    RotatedBox(
                                      quarterTurns: -1,
                                      child: Text(
                                        'Carbohidratos en gramos',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context).size.height/3,
                                          width: MediaQuery.of(context).size.width/1.3,
                                          child: BarChart(
                                            BarChartData(
                                                groupsSpace: 50,
                                                barGroups: [
                                                  BarChartGroupData(
                                                    groupVertically:false,
                                                    x: 0, // Índice de la barra
                                                    barRods: [
                                                      BarChartRodData(
                                                          toY: barras[0].toDouble(),
                                                          backDrawRodData:BackgroundBarChartRodData(toY:maxima,show: true,color: ColorsGenerals().whith),// Altura de la barra
                                                          color: ColorsGenerals().red,
                                                          width:15// Color de la barra
                                                      ),
                                                    ],
                                                  ),
                                                  BarChartGroupData(
                                                    x: 0, // Índice de la barra
                                                    barRods: [
                                                      BarChartRodData(
                                                          toY: barras[1],// Altura de la barra
                                                          backDrawRodData:BackgroundBarChartRodData(toY:maxima,show: true,color: ColorsGenerals().whith),
                                                          color: ColorsGenerals().red,
                                                          width:15// Color de la barra
                                                      ),
                                                    ],
                                                  ),
                                                  BarChartGroupData(
                                                    groupVertically:false,
                                                    x: 0, // Índice de la barra
                                                    barRods: [
                                                      BarChartRodData(
                                                          toY: barras[2], // Altura de la barra
                                                          color: ColorsGenerals().red,
                                                          backDrawRodData:BackgroundBarChartRodData(toY:maxima,show: true,color: ColorsGenerals().whith),
                                                          width:15// Color de la barra
                                                      ),
                                                    ],
                                                  ),
                                                  BarChartGroupData(
                                                    groupVertically:false,
                                                    x: 1, // Índice de la barra
                                                    barRods: [
                                                      BarChartRodData(
                                                          toY: barras[3], // Altura de la barra
                                                          color: ColorsGenerals().red,
                                                          backDrawRodData:BackgroundBarChartRodData(toY:maxima,show: true,color: ColorsGenerals().whith),
                                                          width:15// Color de la barra
                                                      ),
                                                    ],
                                                  ),
                                                  BarChartGroupData(
                                                    groupVertically:false,
                                                    x: 2, // Índice de la barra
                                                    barRods: [
                                                      BarChartRodData(
                                                          toY: barras[4], // Altura de la barra
                                                          color: ColorsGenerals().red,
                                                          backDrawRodData:BackgroundBarChartRodData(toY:maxima,show: true,color: ColorsGenerals().whith),
                                                          width:15
                                                        // Color de la barra
                                                      ),
                                                    ],
                                                  ),
                                                  BarChartGroupData(
                                                    groupVertically:false,
                                                    x: 2, // Índice de la barra
                                                    barRods: [
                                                      BarChartRodData(
                                                          toY: barras[5],// Altura de la barra
                                                          color: ColorsGenerals().red,
                                                          backDrawRodData:BackgroundBarChartRodData(toY:maxima,show: true,color: ColorsGenerals().whith),
                                                          width:15
                                                        // Color de la barra
                                                      ),
                                                    ],
                                                  ),
                                                  BarChartGroupData(
                                                    groupVertically:false,
                                                    x: 2, // Índice de la barra
                                                    barRods: [
                                                      BarChartRodData(
                                                          toY: barras[6],// Altura de la barra
                                                          color: ColorsGenerals().red,
                                                          backDrawRodData:BackgroundBarChartRodData(toY:maxima,show: true,color: ColorsGenerals().whith),
                                                          width:15
                                                        // Color de la barra
                                                      ),
                                                    ],
                                                  ),
                                                ],// Cambiar el color de fondo del gráfico
                                                gridData: FlGridData(show: false),
                                                borderData: FlBorderData(show: false),
                                                titlesData: FlTitlesData(show: false)
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.max,
                                          children: days.map((day) => Text('    $day  ', style: TextStyle(fontSize: 8),),).toList() ,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  'Últimos 7 días',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(5),
                              width:
                              MediaQuery.of(context).size.width,
                              height:MediaQuery.of(context).size.height / 2.6,
                              decoration: BoxDecoration(
                                color: ColorsGenerals().lightgrey,
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                                  Text(
                                    'Porcentaje de nivel de glucemia de los últimos 7 días',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                  ),
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width,
                                    height:MediaQuery.of(context).size.height / 3.6,
                                    child: PieChart(
                                      PieChartData(
                                        sections:  glucemia.map((valor) => valor).reduce((a, b) => a + b)>0?[
                                          PieChartSectionData(
                                            value:glucemia[0],
                                            titleStyle:TextStyle( fontWeight: FontWeight.w500, fontSize: 17),
                                            color: Colors.lightBlueAccent,
                                            radius:  35,
                                            title: "${((glucemia[0]/(glucemia.reduce((a, b) => a + b)))*100).toStringAsFixed(1)}%",
                                            showTitle: true,
                                            titlePositionPercentageOffset: 1.7,
                                          ),
                                          PieChartSectionData(
                                            titleStyle:TextStyle( fontWeight: FontWeight.w500, fontSize: 17),
                                            value: glucemia[1],
                                            titlePositionPercentageOffset: 1.4,
                                            color: Colors.lightGreen,
                                            radius:  35,
                                            title: "${((glucemia[1]/(glucemia.reduce((a, b) => a + b)))*100).toStringAsFixed(1)}%",
                                            showTitle: true,
                                          ),
                                          PieChartSectionData(
                                            titleStyle:TextStyle( fontWeight: FontWeight.w500, fontSize: 17),
                                            value: glucemia[2],
                                            color: ColorsGenerals().red,
                                            titlePositionPercentageOffset: 1.5,
                                            radius: 35,
                                            title: "${((glucemia[2]/(glucemia.reduce((a, b) => a + b)))*100).toStringAsFixed(1)}%",
                                            showTitle: true,
                                          ),
                                        ]:[
                                          PieChartSectionData(
                                            value:100,
                                            titleStyle:TextStyle( fontWeight: FontWeight.w500, fontSize: 17),
                                            color: ColorsGenerals().whith,
                                            radius:  35,
                                            title: "0%",
                                            showTitle: true,
                                            titlePositionPercentageOffset: 1.7,
                                          ),
                                        ],
                                        centerSpaceRadius: 37,
                                        sectionsSpace: 3,
                                        startDegreeOffset: 270,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:Colors.lightBlueAccent,
                                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 0.1,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            height: MediaQuery.of(context).size.height/40,
                                            width: MediaQuery.of(context).size.height/40,
                                          ),
                                          Text(" Hipo")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.lightGreen,
                                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 0.1,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            height: MediaQuery.of(context).size.height/40,
                                            width: MediaQuery.of(context).size.height/40,
                                          ),
                                          Text(" Estable")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:ColorsGenerals().red,
                                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 0.1,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            height: MediaQuery.of(context).size.height/40,
                                            width: MediaQuery.of(context).size.height/40,
                                          ),
                                          Text(" Hiper")
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          Text(
                            'Registros',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          ScrollConfiguration(
                            behavior: const ScrollBehavior().copyWith(
                                physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                            ),
                            child: SingleChildScrollView(
                              child: Container(
                                height: MediaQuery.of(context).size.height/2.7,
                                width: MediaQuery.of(context).size.width,
                                child: reports.length > 0 ? reportsAll(context): Text("¡No tienes registrado reportes!", textAlign: TextAlign.center,),
                              ),
                            ),
                          ),
                        ],
                      )
                  ) ,
                ),
              );
              break;
            case HistoryReportstatus.error:
              return Text("Me petatie");
              break;
          }
        },
      ),
    );
  }

  Widget reportsAll(BuildContext context) =>
      ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            final rep = reports[index];
            return Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            child:Container(
              height: MediaQuery.of(context).size.height/9,
              width: MediaQuery.of(context).size.width/1.1,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorsGenerals().lightgrey,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(rep.type,style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(DateFormat('d MMM y h:mm a').format(DateTime.parse(rep.fecha)).toString(),style: TextStyle(fontWeight: FontWeight.w500),),
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
                          Text("${rep.glucosa} mg/dl", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: ColorsGenerals().black)),
                          Text("Glucemia", style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: ColorsGenerals().black),),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${rep.Carbohydrates}g", style: TextStyle(
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
                          Text("${rep.unidades_insulina}U", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorsGenerals().black)),
                          Text("Insulina", style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: ColorsGenerals().black)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            );
          }
      );

}