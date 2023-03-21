import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../colors/colorsGenerals.dart';
import '../cubit/report_cubit.dart';

class reportpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(),
      child: reportview(),
    );
  }
}

class reportview extends StatefulWidget {
  @override
  State<reportview> createState() => _reportviewState();
}

class  _reportviewState extends State<reportview>{
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
                child: Center(child: Text("Reportes", style: TextStyle(color: ColorsGenerals().black)),),
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