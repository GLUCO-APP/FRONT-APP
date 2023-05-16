
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:open_file/open_file.dart';
import '../../colors/colorsGenerals.dart';
import '../cubit/report_cubit.dart';


class reportpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(ReportPDFRepository()),
      child: reportview(),
    );
  }
}

class reportview extends StatefulWidget {
  @override
  State<reportview> createState() => _reportviewState();
}

class  _reportviewState extends State<reportview>{
  List<bool> _buttonStates = [false, false, false,false];
  List<int> dias = [7,15,30,2];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, states) {
          switch (states.status) {
            case Reportstatus.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case Reportstatus.success:
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
                    ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(
                          physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tipos de reportes", style: TextStyle(color: ColorsGenerals().black, fontSize: 18),),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height /1.8,
                              child: ListView(
                                children: [
                                  Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height /80)),
                                  Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(20),
                                        width: MediaQuery.of(context).size.width /1.1,
                                        height: MediaQuery.of(context).size.height /6,
                                        decoration: BoxDecoration(
                                          color: ColorsGenerals().regulargrey,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(20), bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                                        ),
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("  Días:", style: TextStyle(color: ColorsGenerals().black),),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _buttonStates[2] = false;
                                                      _buttonStates[1] = false;
                                                      _buttonStates[0] = !_buttonStates[0];
                                                    });
                                                  },
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height /20,
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                      color: _buttonStates[0]
                                                          ? ColorsGenerals().darkblue
                                                          : ColorsGenerals().darkgrey,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text("Últimos 7", style: TextStyle(fontSize: MediaQuery.of(context).size.height /60, color: ColorsGenerals().whith),),
                                                        _buttonStates[0] ? Icon(Icons.check, size:  MediaQuery.of(context).size.height /40,color: ColorsGenerals().whith,) : SizedBox(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _buttonStates[0] = false;
                                                      _buttonStates[2] = false;
                                                      _buttonStates[3] = false;
                                                      _buttonStates[1] = !_buttonStates[1];
                                                    });
                                                  },
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height /20,
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                      color: _buttonStates[1]
                                                          ? ColorsGenerals().darkblue
                                                          : ColorsGenerals().darkgrey,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text('Últimos 15', style: TextStyle(fontSize: MediaQuery.of(context).size.height /60, color: ColorsGenerals().whith),),
                                                        _buttonStates[1] ? Icon(Icons.check, size:  MediaQuery.of(context).size.height /40,color: ColorsGenerals().whith,) : SizedBox(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _buttonStates[0] = false;
                                                      _buttonStates[1] = false;
                                                      _buttonStates[3] = false;
                                                      _buttonStates[2] = !_buttonStates[2];
                                                    });
                                                  },
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height /20,
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                      color: _buttonStates[2]
                                                          ? ColorsGenerals().darkblue
                                                          : ColorsGenerals().darkgrey,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text('Últimos 30', style: TextStyle(fontSize: MediaQuery.of(context).size.height /60, color: ColorsGenerals().whith),),
                                                        _buttonStates[2] ? Icon(Icons.check, size:  MediaQuery.of(context).size.height /40,color: ColorsGenerals().whith,) : SizedBox(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width /1.1,
                                        height: MediaQuery.of(context).size.height /16,
                                        decoration: BoxDecoration(
                                          color: ColorsGenerals().lightgrey,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(20), bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 1,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Center(child: Text("Lista de controles", style: TextStyle(color: ColorsGenerals().black, fontSize: 20),),),
                                      ),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height /80)),
                                  Stack(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(20),
                                          width: MediaQuery.of(context).size.width /1.1,
                                          height: MediaQuery.of(context).size.height /6,
                                          decoration: BoxDecoration(
                                            color: ColorsGenerals().regulargrey,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(20), bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                                          ),
                                          child:Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("  Seleccionar reporte:", style: TextStyle(color: ColorsGenerals().black),),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _buttonStates[0] = false;
                                                    _buttonStates[1] = false;
                                                    _buttonStates[2] = false;
                                                    _buttonStates[3] = !_buttonStates[3];
                                                  });
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height /20,
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    color: _buttonStates[3]
                                                        ? ColorsGenerals().darkblue
                                                        : ColorsGenerals().darkgrey,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text('Graficos', style: TextStyle(fontSize: MediaQuery.of(context).size.height /60, color: ColorsGenerals().whith),),
                                                      _buttonStates[3] ? Icon(Icons.check, size:  MediaQuery.of(context).size.height /40,color: ColorsGenerals().whith,) : SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width /1.1,
                                        height: MediaQuery.of(context).size.height /16,
                                        decoration: BoxDecoration(
                                          color: ColorsGenerals().lightgrey,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(20), bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 1,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Center(child: Text("Estadísticas y gráficos", style: TextStyle(color: ColorsGenerals().black, fontSize: 20),),),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        bool  realizo = false;
                        for(int i = _buttonStates.length -1; 0 <= i; i--) {
                          if (_buttonStates[i]) {
                            realizo = true;
                            if(dias[i] != 2){
                              var field = await context.read<ReportCubit>().getPDF(
                                  dias[i]);
                              if(field.estado){
                                OpenFile.open(field.pdf.path);
                                break;
                              }else{
                                Fluttertoast.showToast(
                                    msg: "No tiene reportes", fontSize: 20);
                                break;
                              }
                            }else{
                              var field = await context.read<ReportCubit>().getPDFGraft();
                              if(field.estado){
                                OpenFile.open(field.pdf.path);
                                break;
                              }else{
                                Fluttertoast.showToast(
                                    msg: "No tiene reportes", fontSize: 20);
                                break;
                              }
                            }

                          }
                        }
                        if(!realizo){
                          Fluttertoast.showToast(
                              msg: "Seleccione algun reporte", fontSize: 20);
                        }
                      },
                      child: Text("Descargar en PDF",
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

                    )
                  ],
                )
              );
              break;
            case Reportstatus.error:
              return Text("Me petatie");
              break;
          }
        },
      ),
    );
  }
}