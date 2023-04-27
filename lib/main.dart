
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:test_project/bloc/user_cubit.dart';
import 'helper/nav_helper.dart';
import 'helper/nav_observer.dart';
import 'helper/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: MaterialApp(  title: 'Test APP',
        navigatorObservers: [NavObserver.instance],
        navigatorKey: NavObserver.navKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of the application.
          primarySwatch: Colors.blue,
        ),
        initialRoute: landingRoute,
        onGenerateRoute: generateRoute,

        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              if (Platform.isIOS) {
                hideKeyboard(context);
              }
            },
            child: child,
          );
        },
      ),
    );
  }
}


