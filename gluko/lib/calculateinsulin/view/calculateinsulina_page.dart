import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../colors/colorsGenerals.dart';
import '../cubit/calculateinsulin_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class calculateinsuline_page extends StatelessWidget {
  final String carbohidratos;
  calculateinsuline_page({required this.carbohidratos}) ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculateinsulinCubit(),
      child: calculateinsulineview(),
    );
  }
}

class calculateinsulineview extends StatefulWidget {
  @override
  State<calculateinsulineview> createState() => _calculateinsulineviewState();
}

class  _calculateinsulineviewState extends State<calculateinsulineview>{
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
          children: [Text(
            "Calculo Insulina ",
            style: TextStyle(color: Colors.black, fontSize: 25),
          )
          ],
        )
        ],
      ),
      body: BlocBuilder<CalculateinsulinCubit, CalculateinsulinState>(
        builder: (context, states) {
          switch (states.status) {
            case Calculateinsulinstatus.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case Calculateinsulinstatus.success:
              return Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(child: Text("Calculo Insulina", style: TextStyle(color: ColorsGenerals().black)),),
              );
              break;
            case Calculateinsulinstatus.error:
              return Text("Me petatie");
              break;
          }
        },
      ),
    );
  }
}