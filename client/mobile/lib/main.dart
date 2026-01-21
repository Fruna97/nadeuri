import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/data/repository/auth_repository.dart';
import 'package:mobile/data/repository/member_repository.dart';
import 'package:mobile/data/repository/nadeuri_repository.dart';
import 'package:mobile/data/service/api_client.dart';
import 'package:mobile/ui/core/app_snack_bar.dart';
import 'package:mobile/ui/home/home.dart';
import 'package:mobile/ui/home/home_view_model.dart';
import 'package:mobile/ui/sign_in/sign_in.dart';
import 'package:mobile/ui/sign_in/sign_in_view_model.dart';
import 'package:mobile/ui/sign_up/sign_up.dart';
import 'package:mobile/ui/sign_up/sign_up_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferencesWithCache prefsWithCache = await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(),
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<FlutterSecureStorage>(
          create: (_) => const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true)),
        ),
        Provider<SharedPreferencesWithCache>(create: (_) => prefsWithCache),
        Provider<AppSnackBar>(create: (_) => AppSnackBar()),
        Provider<RouteObserver<ModalRoute<void>>>(create: (_) => RouteObserver<ModalRoute<void>>()),
        Provider<ApiClient>(
          create: (context) => ApiClient(
            host: "http://10.0.2.2",
            port: 8080,
            baseHeaders: {"content-type": "application/json; charset=UTF-8"},
            flutterSecureStorage: context.read<FlutterSecureStorage>(),
          ),
        ),
        Provider<MemberRepository>(
          create: (context) => MemberRepository(
            apiClient: context.read<ApiClient>(),
            prefsWithCache: context.read<SharedPreferencesWithCache>(),
          ),
        ),
        Provider<AuthRepository>(
          create: (context) => AuthRepository(
            apiClient: context.read<ApiClient>(),
            flutterSecureStorage: context.read<FlutterSecureStorage>(),
          ),
        ),
        Provider<NadeuriRepository>(create: (context) => NadeuriRepository(apiClient: context.read<ApiClient>())),
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
      scaffoldMessengerKey: context.read<AppSnackBar>().scaffoldMessengerKey,
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
      navigatorObservers: [context.read<RouteObserver<ModalRoute<void>>>()],
      routes: {
        '/home': (BuildContext context) => ChangeNotifierProvider(
          create: (_) => HomeViewModel(
            memberRepository: context.read<MemberRepository>(),
            nadeuriRepository: context.read<NadeuriRepository>(),
            prefsWithCache: context.read<SharedPreferencesWithCache>(),
          ),
          child: HomePage(),
        ),
        '/sign-in': (BuildContext context) => ChangeNotifierProvider(
          create: (_) => SignInViewModel(authRepository: context.read<AuthRepository>()),
          child: SignInPage(),
        ),
        '/sign-up': (BuildContext context) => ChangeNotifierProvider(
          create: (_) => SignUpViewModel(memberRepository: context.read<MemberRepository>()),
          child: SignUpPage(),
        ),
      },
      initialRoute: '/home',
    );
  }
}
