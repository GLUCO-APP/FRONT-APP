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

final List<double> data = [25, 50, 75, 100, 125, 150, 175];

List<ReportDetail> reports = [];

class  _HistoryReportviewState extends State<HistoryReportview>{

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
            "Historial Reportes   ",
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
              return Container(
                padding: EdgeInsets.all(12),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
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
                                                    toY: double.parse(reports[0].Carbohydrates.toString()),
                                                    backDrawRodData:BackgroundBarChartRodData(toY:170,show: true,color: ColorsGenerals().whith),// Altura de la barra
                                                    color: ColorsGenerals().red,
                                                    width:15// Color de la barra
                                                ),
                                              ],
                                            ),
                                            BarChartGroupData(
                                              x: 0, // Índice de la barra
                                              barRods: [
                                                BarChartRodData(
                                                    toY: double.parse(reports[1].Carbohydrates.toString()),// Altura de la barra
                                                    backDrawRodData:BackgroundBarChartRodData(toY:170,show: true,color: ColorsGenerals().whith),
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
                                                    toY: double.parse(reports[2].Carbohydrates.toString()), // Altura de la barra
                                                    color: ColorsGenerals().red,
                                                    backDrawRodData:BackgroundBarChartRodData(toY:170,show: true,color: ColorsGenerals().whith),
                                                    width:15// Color de la barra
                                                ),
                                              ],
                                            ),
                                            BarChartGroupData(
                                              groupVertically:false,
                                              x: 1, // Índice de la barra
                                              barRods: [
                                                BarChartRodData(
                                                    toY: double.parse(reports[3].Carbohydrates.toString()), // Altura de la barra
                                                    color: ColorsGenerals().red,
                                                    backDrawRodData:BackgroundBarChartRodData(toY:170,show: true,color: ColorsGenerals().whith),
                                                    width:15// Color de la barra
                                                ),
                                              ],
                                            ),
                                            BarChartGroupData(
                                              groupVertically:false,
                                              x: 2, // Índice de la barra
                                              barRods: [
                                                BarChartRodData(
                                                    toY: double.parse(reports[4].Carbohydrates.toString()), // Altura de la barra
                                                    color: ColorsGenerals().red,
                                                    backDrawRodData:BackgroundBarChartRodData(toY:170,show: true,color: ColorsGenerals().whith),
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
                                                    toY: double.parse(reports[5].Carbohydrates.toString()),// Altura de la barra
                                                    color: ColorsGenerals().red,
                                                    backDrawRodData:BackgroundBarChartRodData(toY:170,show: true,color: ColorsGenerals().whith),
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
                                                    toY: double.parse(reports[6].Carbohydrates.toString()),// Altura de la barra
                                                    color: ColorsGenerals().red,
                                                    backDrawRodData:BackgroundBarChartRodData(toY:170,show: true,color: ColorsGenerals().whith),
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
                                    children: [
                                      Text('    04/01  ', style: TextStyle(fontSize: 8),),
                                      Text('    04/01  ', style: TextStyle(fontSize: 8)),
                                      Text('    04/01  ', style: TextStyle(fontSize: 8)),
                                      Text('    04/01  ', style: TextStyle(fontSize: 8)),
                                      Text('    04/01  ', style: TextStyle(fontSize: 8)),
                                      Text('    04/01  ', style: TextStyle(fontSize: 8)),
                                      Text('    04/01  ', style: TextStyle(fontSize: 8)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            'Ultimos 7 días',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
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
                          height: MediaQuery.of(context).size.height/3,
                          width: MediaQuery.of(context).size.width,
                          child: reportsAll(context),
                        ),
                      ),
                    ),
                  ],
                )
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