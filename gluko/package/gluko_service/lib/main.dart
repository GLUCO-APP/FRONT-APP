import 'dart:convert';

import 'package:gluko_service/src/Data/allfood_service.dart';

Future<void> main() async {
  List<dynamic> prueba = await AllfoodService().getAllFood();
  print(prueba[1]['name']);
}

