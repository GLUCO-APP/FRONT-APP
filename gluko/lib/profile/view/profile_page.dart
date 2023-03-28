import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../colors/colorsGenerals.dart';
import '../cubit/profile_cubit.dart';

class profilepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: profileview(),
    );
  }
}

class profileview extends StatefulWidget {
  @override
  State<profileview> createState() => _profileviewState();
}

class  _profileviewState extends State<profileview>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, states) {
          switch (states.status) {
            case profilestatus.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case profilestatus.success:
              return Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(child: Text("perfil", style: TextStyle(color: ColorsGenerals().black),),),
              );
              break;
            case profilestatus.error:
              return Text("Me petatie");
              break;
          }
        },
      ),
    );
  }
}