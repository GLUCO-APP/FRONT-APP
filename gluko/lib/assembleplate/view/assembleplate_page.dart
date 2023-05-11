import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gluko/colors/colorsGenerals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gluko_repository/gluko_repository.dart';
import '../../calculateinsulin/view/calculateinsulina_page.dart';
import '../cubit/assembleplate_cubit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


class assembleplatepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssembleplateCubit(allfoodRepository(),fooBarcodeRepository())..getFoods(),
      child: assembleplateview(),
    );
  }
}

Future<bool> checkCameraPermissions() async {
  // Verifica si ya se han concedido los permisos de la cámara
  PermissionStatus cameraPermissionStatus = await Permission.camera.status;
  if (cameraPermissionStatus.isGranted) {
    // Los permisos ya han sido concedidos, no se necesita pedirlos de nuevo
    return true;
  } else if (cameraPermissionStatus.isDenied || cameraPermissionStatus.isRestricted) {
    // Si los permisos han sido negados o restringidos, solicita los permisos de nuevo
    Map<Permission, PermissionStatus> permissions = await [
      Permission.camera,
    ].request();
    if (permissions[Permission.camera] == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  } else {
    // Si los permisos aún no han sido solicitados, solicítalos
    PermissionStatus status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}



class assembleplateview extends StatefulWidget {
  @override
  State<assembleplateview> createState() => _assembleplateviewState();
}



var buscar = TextEditingController();
var glucosa = TextEditingController();
List<FoodDetail> foodsList = [];
List<FoodDetail> prueba = [];





List<FoodDetail> plato=[];
List<FoodDetail> aux=[];
double proteina = 0;
double carbohidrato = 0;
double verduar = 0;
double grasas = 0;
var hora = 0;


class _assembleplateviewState extends State<assembleplateview> {

  List<FoodDetail> bebidas = [];
  List<FoodDetail> sopas = [];
  List<Posiciones> pos = [
    Posiciones(top: 60, left: 60),
    Posiciones(top: 40, left: 110),
    Posiciones(top: 60, left: 170),
    Posiciones(top: 85, left: 110)
  ];

  Future<void> agregarAlimentosync( FoodDetail food) async{
    setState(() {
      carbohidrato = carbohidrato + food.carbs;
      proteina =  proteina + food.protein;
      grasas = grasas + food.fats;
      if(food.tag == "bebida"){
        bebidas.add(food);
      }
      if(food.tag == "sopa"){
        sopas.add(food);
      }
      plato.add(food);
    });
  }

  void CalculoInsulina() async{

    var info = glucosa.text.toString();
    print(info);
    glucosa.clear();
    List<plateId> foods = plato.map((food) => plateId(food.id)).toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                calculateinsuline_page(info: DetailInsulin(carbohidrato, info, proteina, grasas), foods: foods,))
    );
  }

  AgregarAlimentoScaneado(BuildContext context, FoodDetail food) {
    return showModalBottomSheet(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.0),
            topRight: Radius.circular(100.0),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height/2.6,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(color: ColorsGenerals().whith,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Alimento escaneado", style: TextStyle(
                          color: ColorsGenerals().black,
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height / 30),),
                      Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorsGenerals().lightgrey,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 0.5,
                                offset: Offset(0, 1),
                              ),
                            ]
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(food.name.length > 17 ? food.name.substring(0,16):food.name, style: TextStyle(
                                    fontSize: 20, color: ColorsGenerals().black)),
                                Row(
                                  children: [
                                    Container(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 80,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/Food/${food.image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                                    Text("${double.parse(food.fats.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: ColorsGenerals().black)),
                                    Text("Grasas", style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: ColorsGenerals().black),),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("${double.parse(food.carbs.toStringAsFixed(1)).abs()}g", style: TextStyle(
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
                                    Text("${double.parse(food.protein.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorsGenerals().black)),
                                    Text("Proteina", style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: ColorsGenerals().black)),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          agregarAlimentosync(food);
                          Navigator.pop(context);
                        },
                        child: Text("Agregar al plato",
                          style: TextStyle(color: ColorsGenerals().whith),),
                        style: ElevatedButton.styleFrom(
                          elevation: 8, // elevación de la sombra
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // radio de la esquina redondeada
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                          backgroundColor: ColorsGenerals().red, // color de fondo
                        ),

                      )
                    ],
                  ),
                );
              });
        });
  }

  editplato(BuildContext context) {
    return showModalBottomSheet(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.0),
            topRight: Radius.circular(100.0),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(color: ColorsGenerals().whith,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Camida en plato", style: TextStyle(
                          color: ColorsGenerals().black,
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height / 30),),
                      ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(
                            physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 2.3,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: plato.length == 0?
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ColorsGenerals().lightgrey,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 0.5,
                                      offset: Offset(0, 1),
                                    ),
                                  ]
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "¡Tu plato esta vacio!",
                                    style: TextStyle(
                                        color: ColorsGenerals().black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 23
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 2,
                                    height: MediaQuery.of(context).size.height / 4,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/Logo/gluko_bot_angry.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Agrega alimentos a tu plato",
                                    style: TextStyle(
                                        color: ColorsGenerals().black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15
                                    ),
                                  ),
                                ],
                              ) ,
                            ):PlatoEditar(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  recibirGlucosa(BuildContext context) {
    return showModalBottomSheet(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.0),
            topRight: Radius.circular(100.0),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(color: ColorsGenerals().whith,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Registra tu nivel de Glucosa", textAlign: TextAlign.center,style: TextStyle(
                          color: ColorsGenerals().black,
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height / 30),),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              maxLength: 3,
                              controller: glucosa,
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              cursorColor: ColorsGenerals().black,
                              style: TextStyle(color: ColorsGenerals().black),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorsGenerals().lightgrey,
                                  hintText: 'Inserte Nivel de glucosa',
                                  hintStyle: TextStyle(color: ColorsGenerals().black),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: SvgPicture.asset("assets/Icons/glucometro.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/40,),
                                  )
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese su nivel de glucosa';
                                }
                                return null;
                              },
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/200)),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.pop(context);
                                  CalculoInsulina();
                                }
                              },
                              child: Text("Calculo Insulina",
                                style: TextStyle(color: ColorsGenerals().whith, fontSize: 15),),
                              style: ElevatedButton.styleFrom(
                                elevation: 8, // elevación de la sombra
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // radio de la esquina redondeada
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                backgroundColor: ColorsGenerals().red, // color de fondo
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  Future<void> showMyPopupPlateConfirm(BuildContext context) async {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return  GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.3,
              color: Colors.transparent,
              child: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width/1.1,
                          height: MediaQuery.of(context).size.height/1.3,
                          decoration: BoxDecoration(
                            color: ColorsGenerals().whith,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(-5, 6),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Alimentos", style: TextStyle(
                                  color: ColorsGenerals().black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 35)),
                              ScrollConfiguration(
                                behavior: const ScrollBehavior().copyWith(
                                    physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                                ),
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10,
                                        vertical: 20),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 1.7,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Platoinfo(context),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 8, // elevación de la sombra
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30), // radio de la esquina redondeada
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                      backgroundColor: ColorsGenerals().red, // color de fondo
                                    ),
                                    child: Text("Cancelar",
                                      style: TextStyle(color: ColorsGenerals().whith),),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      recibirGlucosa(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 8, // elevación de la sombra
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30), // radio de la esquina redondeada
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                      backgroundColor: ColorsGenerals().red, // color de fondo
                                    ),
                                    child: Text("Confirmar plato",
                                      style: TextStyle(color: ColorsGenerals().whith),),
                                  ),
                                ],
                              )
                            ],
                          )
                      ),
                    ]
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscar.text = "";
    plato=[];
    proteina = 0;
    carbohidrato = 0;
    verduar = 0;
    grasas = 0;
  }
  int p = 0;
  int selectedIndexPlato = -1;
  bool isExpandedDelet = false;
  int selectedIndex = -1;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              showMyPopupPlateConfirm(context);
            },
            child: Text("Confirmar",
              style: TextStyle(color: ColorsGenerals().whith),),
            style: ElevatedButton.styleFrom(
              elevation: 8, // elevación de la sombra
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    30), // radio de la esquina redondeada
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              backgroundColor: Colors.red, // color de fondo
            ),

          ),
        ),
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
                "Armar Plato ",
                style: TextStyle(color: Colors.black, fontSize: 25),
              )
              ],
            )
            ],
        ),
        body: BlocBuilder<AssembleplateCubit, AssembleplateState>(
          builder: (context, states) {
            switch (states.status) {
              case Assembleplatestatus.loading:
                return Center(child: CircularProgressIndicator(color: ColorsGenerals().red,));
                break;
              case Assembleplatestatus.success:
                prueba = states.getFoodsAll();
                if(foodsList.isEmpty)
                  foodsList = prueba;
                return ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(
                      physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height/1.05,
                      color: ColorsGenerals().whith,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 2.9,
                            decoration: BoxDecoration(
                                color: ColorsGenerals().lightgrey,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 3),
                                  ),
                                ]
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    editplato(context);
                                  },
                                  child: Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                    ),
                                    child: Center(
                                      child: DragTarget<FoodDetail>(
                                        builder: (BuildContext context,
                                            List incoming,
                                            List<dynamic> rejected) =>
                                            Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width / 1.2,
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height / 3,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/Food/plato_v1.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: Container(
                                                child: Stack(
                                                  children: plato.length < 6
                                                      ? ComidasEnPlato(plato)
                                                      : ComidasEnPlato(plato)
                                                      .sublist(0, 6),
                                                ),
                                              ),
                                            ),
                                        onWillAccept: (data) => true,
                                        onAccept: (data) {
                                          print(data.name);
                                          for (int i = 0; i < foodsList.length; i++) {
                                            if (foodsList[i].id == data.id) {
                                              setState(() {
                                                carbohidrato = carbohidrato + data.carbs;
                                                proteina =  proteina + data.protein;
                                                grasas = grasas + data.fats;
                                                if(data.tag == "bebida"){
                                                  bebidas.add(data);
                                                }
                                                if(data.tag == "sopa"){
                                                  sopas.add(data);
                                                }
                                                plato.add(data);
                                              });
                                            }
                                          }
                                        },
                                        onLeave: (data) {},
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 100)),
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 15,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("${double.parse(grasas.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: ColorsGenerals().black)),
                                          Text("Grasas", style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: ColorsGenerals().black),),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("${double.parse(carbohidrato.toStringAsFixed(1)).abs()}g", style: TextStyle(
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
                                          Text("${double.parse(proteina.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ColorsGenerals().black)),
                                          Text("Proteina", style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: ColorsGenerals().black)),
                                        ],
                                      ),
                                    ],
                                  ),
                                )

                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery
                              .of(context)
                              .size
                              .height / 90)),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 2,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width/1.5,
                                      decoration: BoxDecoration(
                                          color: ColorsGenerals().lightgrey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(0, 3),
                                            ),
                                          ]
                                      ),
                                      child: TextField(
                                        onChanged: (text){
                                          if(text.isEmpty){
                                            setState(() {
                                              foodsList = prueba;
                                            });
                                          }else{
                                            setState(() {
                                              foodsList = states.foods.where((bus) => bus.name.toLowerCase().contains(text)|| bus.tag.toLowerCase().contains(text)).toList();
                                            });
                                          }
                                        },
                                        controller: buscar,
                                        cursorColor: ColorsGenerals().black,
                                        style: TextStyle(color: ColorsGenerals().black),
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: ColorsGenerals().lightgrey,
                                            hintText: 'Buscar alimentos',
                                            hintStyle: TextStyle(
                                                color: ColorsGenerals().black),
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 15.0),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            prefixIcon: Container( padding: EdgeInsets.all(10),child: SvgPicture.asset("assets/Icons/buscar.svg",color: ColorsGenerals().black, width: MediaQuery.of(context).size.width/70, height: MediaQuery.of(context).size.height/70,),)
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: ColorsGenerals().lightgrey,
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: IconButton( icon: SvgPicture.asset("assets/Icons/codigo-de-barras.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/30,),
                                          onPressed: () async {
                                              var permisos = await checkCameraPermissions();
                                              if (permisos){
                                                String barcode = await FlutterBarcodeScanner.scanBarcode(
                                                  '#ff6666', // Color de fondo de la pantalla de escaneo
                                                  'Cancelar', // Texto del botón de cancelar
                                                  true, // Si debe mostrar una ventana de ayuda
                                                  ScanMode.BARCODE, // Modo de escaneo (código de barras en este caso)
                                                );
                                                if(barcode != "-1"){
                                                  print("Codigo de barras");
                                                  print(barcode);
                                                  var food = await context.read<AssembleplateCubit>().getFoodBarcode(barcode);
                                                  setState(() {
                                                    int valido = 0;
                                                    foodsList.map((f) => {
                                                      if(f.id == food.id)
                                                        valido++
                                                    });
                                                    if(valido > 0)
                                                      foodsList.add(food);
                                                  });
                                                  if(food.id != 0){
                                                    AgregarAlimentoScaneado(context, food);
                                                  }else{
                                                    Fluttertoast.showToast(
                                                        msg: "Alimento no encontrado", fontSize: 20);
                                                  }
                                                }

                                              }else{
                                                print("Solicitar permisos");
                                              }
                                          }
                                      ),
                                    )
                                  ],
                                ),
                                Padding(padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 100)),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10,
                                      vertical: 20),
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 2.4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: ColorsGenerals().lightgrey,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(0, 3),
                                        ),
                                      ]
                                  ),
                                  child: Alimentos(context),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
                break;
              case Assembleplatestatus.error:
                return Center(child: Text("Me petatie", style: TextStyle(color: Colors.black),),);
                break;
            }
          },
        ));
  }




  void _toggleExpand(int index) {
    setState(() {
      if (selectedIndex == index) {
        selectedIndex = -1;
        isExpanded = false;
      } else {
        selectedIndex = index;
        isExpanded = true;
      }
    });
  }
  void _toggleExpandDelete(int index) {
    setState(() {
      if (selectedIndexPlato == index) {
        selectedIndexPlato = -1;
        isExpandedDelet = false;
      } else {
        selectedIndexPlato = index;
        isExpandedDelet = true;
      }
    });
  }

  Widget Alimentos(BuildContext context) =>
      ListView.builder(
          itemCount: foodsList.length,
          itemBuilder: (context, index) {
            final favor = foodsList[index];
            return Container(
              padding: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height / 150, left: 3, right: 3),
              child: GestureDetector(
                onTap: () {
                  _toggleExpand(index);
                },
                child: Container(
                    height: isExpanded && selectedIndex == index
                        ? MediaQuery.of(context).size.height / 5
                        : MediaQuery.of(context).size.height / 10,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 0.5,
                            offset: Offset(0, 1),
                          ),
                        ]
                    ),
                    padding: EdgeInsets.all(10),
                    child: isExpanded && selectedIndex == index? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(foodsList[index].name, style: TextStyle(
                              fontSize: 18, color: ColorsGenerals().black)),
                          Draggable<FoodDetail>(
                            data: foodsList[index],
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                alignment: Alignment.center,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/Food/${foodsList[index].image}", height: 60, width: 60,),
                              ),
                            ),
                            feedback: Material(
                              color: Colors.transparent,
                              child: Container(
                                alignment: Alignment.center,
                                height: 100,
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/Food/${foodsList[index].image}", height: 100, width: 100,),
                              ),
                            ),
                            childWhenDragging: Material(
                              color: Colors.transparent,
                              child: Container(
                                alignment: Alignment.center,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/Food/${foodsList[index].image}", height: 60, width: 60,),
                              ),
                            ),
                          )
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
                                Text("${double.parse(foodsList[index].fats.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: ColorsGenerals().black)),
                                Text("Grasas", style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ColorsGenerals().black),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${double.parse(foodsList[index].carbs.toStringAsFixed(1)).abs()}g", style: TextStyle(
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
                                Text("${double.parse(foodsList[index].protein.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorsGenerals().black)),
                                Text("Proteina", style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ColorsGenerals().black)),
                              ],
                            ),
                          ],
                        )
                      ],
                    ):Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(foodsList[index].name.length > 17 ? foodsList[index].name.substring(0,16):foodsList[index].name, style: TextStyle(
                            fontSize: 18, color: ColorsGenerals().black)),
                        Draggable<FoodDetail>(
                          data: foodsList[index],
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              alignment: Alignment.center,
                              height: 80,
                              padding: EdgeInsets.all(10),
                              child: Image.asset("assets/Food/${foodsList[index].image}", height: 60, width: 60,),
                            ),
                          ),
                          feedback: Material(
                            color: Colors.transparent,
                            child: Container(
                              alignment: Alignment.center,
                              height: 100,
                              padding: EdgeInsets.all(10),
                              child: Image.asset("assets/Food/${foodsList[index].image}", height: 100, width: 100,),
                            ),
                          ),
                          childWhenDragging: Material(
                            color: Colors.transparent,
                            child: Container(
                              alignment: Alignment.center,
                              height: 80,
                              padding: EdgeInsets.all(10),
                              child: Image.asset("assets/Food/${foodsList[index].image}", height: 60, width: 60,),
                            ),
                          ),
                        )
                      ],
                    )
                ),
              ),
            );
          }
      );


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
              child:  Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 80, width: 80,),
            ),
          ),
        );
        platoPos++;
      } else {
        if(com.tag == "bebida"){
          print("Pone la bebida");
          widgets.add(
            Positioned(
              left: 10,
              top: 120,
              child: Material(
                color: Colors.transparent,
                child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 80, width: 80,),
              ),
            ),
          );
        }
        else{
          if(com.tag == "sopa"){
            widgets.add(
              Positioned(
                left: 200,
                top: 120,
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 80, width: 80,),
                ),
              ),
            );
          }else{
            widgets.add(
              Positioned(
                left: 400,
                top: 400,
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 80, width: 80,),
                ),
              ),
            );
          }
        }

      }
    }
    return widgets;
  }


  Widget PlatoEditar(BuildContext context) =>
      ListView.builder(
          itemCount: plato.length,
          itemBuilder: (context, index) {
            final favor = plato[index];
            return Container(
              padding: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height / 150, left: 3, right: 3),
              child: Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorsGenerals().lightgrey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 0.5,
                          offset: Offset(0, 1),
                        ),
                      ]
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(plato[index].name.length > 17 ? plato[index].name.substring(0,16):plato[index].name, style: TextStyle(
                              fontSize: 20, color: ColorsGenerals().black)),
                          Row(
                            children: [
                              Container(
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 80,
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset("assets/Food/${plato[index].image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
                                  ),
                                ),
                              ),
                              IconButton(onPressed: () {
                                setState(() {
                                  carbohidrato = carbohidrato - double.parse(plato[index].carbs.toStringAsFixed(1));
                                  proteina = proteina - double.parse(plato[index].protein.toStringAsFixed(1));
                                  grasas = grasas - double.parse(plato[index].fats.toStringAsFixed(1));
                                  plato.removeAt(index);
                                });
                                Navigator.pop(context);
                              },
                                  icon: Icon(Icons.delete_outline,
                                    color: ColorsGenerals().red,))
                            ],
                          ),
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
                              Text("${double.parse(plato[index].fats.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: ColorsGenerals().black)),
                              Text("Grasas", style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorsGenerals().black),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${double.parse(plato[index].carbs.toStringAsFixed(1)).abs()}g", style: TextStyle(
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
                              Text("${double.parse(plato[index].protein.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorsGenerals().black)),
                              Text("Proteina", style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorsGenerals().black)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
              )
            );
          }
      );

  Widget Platoinfo(BuildContext context) =>
      ListView.builder(
          itemCount: plato.length,
          itemBuilder: (context, index) {
            final favor = plato[index];
            return Container(
                padding: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height / 150, left: 3, right: 3),
                child: Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorsGenerals().lightgrey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 0.5,
                          offset: Offset(0, 1),
                        ),
                      ]
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(plato[index].name.length > 17 ? plato[index].name.substring(0,16):plato[index].name, style: TextStyle(
                              fontSize: 13, color: ColorsGenerals().black)),
                          Container(
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                alignment: Alignment.center,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/Food/${plato[index].image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
                              ),
                            ),
                          ),
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
                              Text("${double.parse(plato[index].fats.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: ColorsGenerals().black)),
                              Text("Grasas", style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorsGenerals().black),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${double.parse(plato[index].carbs.toStringAsFixed(1)).abs()}g", style: TextStyle(
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
                              Text("${double.parse(plato[index].protein.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorsGenerals().black)),
                              Text("Proteina", style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorsGenerals().black)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
            );
          }
      );
}

