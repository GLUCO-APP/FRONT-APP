import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gluko_repository/gluko_repository.dart';

import '../cubit/history_report_cubit.dart';


class HistoryReportpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryReportCubit(allReportRepository()),
      child: HistoryReportview(),
    );
  }
}


class HistoryReportview extends StatefulWidget {
  @override
  State<HistoryReportview> createState() => _HistoryReportviewState();
}


class  _HistoryReportviewState extends State<HistoryReportview>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: BlocBuilder<HistoryReportCubit, HistoryReportState>(
        builder: (context, states) {
          switch (states.status) {
            case HistoryReportstatus.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case HistoryReportstatus.success:
              return Container();
              break;
            case HistoryReportstatus.error:
              return Text("Me petatie");
              break;
          }
        },
      ),
    );
  }
}