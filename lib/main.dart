import 'package:flutter/material.dart';
import 'package:puzle_hack/src/inject_dependencies.dart';
import 'package:puzle_hack/src/my_app.dart';

import 'package:url_strategy/url_strategy.dart';


void main() async {
  
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
 runApp(const MyApp());
 
}