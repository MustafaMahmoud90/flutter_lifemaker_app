import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:lifemaker/modules/views/auth/cubit/auth_cubit.dart';
import 'package:lifemaker/modules/views/auth/login.dart';
import 'package:lifemaker/modules/views/splash_screen/splash_screen.dart';
import 'package:lifemaker/modules/widgets/layout.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lifemaker/repo/layout/cubit/layout_cubit.dart';
import 'package:lifemaker/repo/shared/constans/constans.dart';
import 'package:lifemaker/repo/shared/network/local_network.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cacheInitialization();
  token = await CacheNetwork.getCacheData(key: "token");

  Widget widget;
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  token = CacheNetwork.getData(key: 'token');

  if (token != null && token != '') {
    widget = LayoutMaker();
  } else {
    widget = LoginScreen();
  }

  print("Your Exbended Token is : $token");
  // print("Your name : ${LayoutCubit().userModal!.username}");
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
            create: (context) => LayoutCubit()
              ..getVoters()
              ..vote(context)
              ..refreshData()
              ..checkInternetConnection(context),
              ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ar', 'AE')],
        title: 'Life Makers',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Alamiri',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: OfflineBuilder(
          connectivityBuilder: (BuildContext context,
              ConnectivityResult connectivity, Widget child) {
            if (connectivity != ConnectivityResult.none) {
              // Network connectivity is available
              return Directionality(
                textDirection: TextDirection.rtl,
                child: AnimatedSplashScreen(
                  splash: const SplashScreen(),
                  nextScreen: startWidget,
                  splashIconSize: double.infinity,
                  animationDuration: const Duration(seconds: 0),
                  splashTransition: SplashTransition.fadeTransition,
                ),
              );
              // return ThanksScreen();
            } else {
              // Network connectivity is not available
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/offline.gif', // replace with your offline image
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          // Retry the internet connection check
                          BlocProvider.of<LayoutCubit>(context)
                              .checkInternetConnection(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                              color: Color(0xffE9791E),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Text('إعادة المحاولة',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
          child: Container(),
        ),
      ),
    );
  }
}
