import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/data/repository/auth_repository.dart';
import 'package:mobile/data/service/api_client.dart';
import 'package:mobile/ui/home/home.dart';
import 'package:mobile/ui/sign_in/sign_in.dart';
import 'package:mobile/ui/sign_in/sign_in_view_model.dart';
import 'package:mobile/ui/sign_up/sign_up.dart';
import 'package:mobile/ui/sign_up/sign_up_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<FlutterSecureStorage>(
          create: (_) => const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true)),
        ),
        Provider<ApiClient>(
          create: (context) => ApiClient(
            host: "http://10.0.2.2",
            port: 8080,
            baseHeaders: {"content-type": "application/json; charset=UTF-8"},
            flutterSecureStorage: context.read<FlutterSecureStorage>(),
          ),
        ),
        Provider<AuthRepository>(
          create: (context) => AuthRepository(
            apiClient: context.read<ApiClient>(),
            flutterSecureStorage: context.read<FlutterSecureStorage>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true, 
      ),
      routes: {
        '/home': (BuildContext context) => HomePage(),
        '/sign-in': (BuildContext context) => ChangeNotifierProvider(
          create: (_) => SignInViewModel(authRepository: context.read<AuthRepository>()),
          child: SignInPage(),
        ), 
        '/sign-up': (BuildContext context) => ChangeNotifierProvider(
          create: (_) => SignUpViewModel(authRepository: context.read<AuthRepository>()),
          child: SignUpPage(),
        ), 
      },
      initialRoute: '/sign-in',
    );
  }
}
