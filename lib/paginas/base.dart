import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'package:testeflutter/servico/firebase_options.dart';

// TODO(codelab user): Get API key
const clientId = '975121165368-8ap9933p65bpt2afkkol98jgtih6ofmp.apps.googleusercontent.com';

void main2() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
