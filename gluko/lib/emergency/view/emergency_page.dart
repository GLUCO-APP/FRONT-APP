import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../colors/colorsGenerals.dart';
import '../cubit/emergency_cubit.dart';

class emergencypage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmergencyCubit(),
      child: emergencyview(),
    );
  }
}

class emergencyview extends StatefulWidget {
  @override
  State<emergencyview> createState() => _emergencyviewState();
}

class  _emergencyviewState extends State<emergencyview>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: BlocBuilder<EmergencyCubit, EmergencyState>(
        builder: (context, states) {
          switch (states.status) {
            case Emergencystatus.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case Emergencystatus.success:
              return Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(child: Text("Emergencia", style: TextStyle(color: ColorsGenerals().black)),),
              );
              break;
            case Emergencystatus.error:
              return Text("Me petatie");
              break;
          }
        },
      ),
    );
  }
}