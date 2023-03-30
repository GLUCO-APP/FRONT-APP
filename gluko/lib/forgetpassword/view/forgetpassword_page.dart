import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gluko/colors/colorsGenerals.dart';

import '../cubit/forgetpassword_cubit.dart';


class forgetpasswordpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetpasswordCubit(),
      child: forgetpasswordview(),
    );
  }
}

class forgetpasswordview extends StatefulWidget {
  @override
  State<forgetpasswordview> createState() => _forgetpasswordviewState();
}

class  _forgetpasswordviewState extends State<forgetpasswordview>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: ColorsGenerals().lightgrey,
      appBar: AppBar(
        backgroundColor: ColorsGenerals().whith,
        elevation: 1,
        actions: [Text(
          " Recuperar contraseña ",
          style: TextStyle(color: Colors.black, fontSize: 22),
        )],
      ),
      body: BlocBuilder<ForgetpasswordCubit, ForgetpasswordState>(
        builder: (context, states) {
          switch (states.status) {
            case Forgetpasswordtatus.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case Forgetpasswordtatus.success:
              return Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                    children: <Widget>[
                      Column(

                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                child: Text(
                                    'Paso 1',
                                    style: TextStyle(color: Colors.black, fontSize: 16)
                                )
                            )
                          ]
                      )
                    ]
                )
              );
              break;
            case Forgetpasswordtatus.error:
              return Text("Me petatie");
              break;
          }
        },
      ),
    );
  }
}