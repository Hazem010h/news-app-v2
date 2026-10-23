import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'AppStates.dart';
import 'BlocObserver.dart';
import 'NewsCubit.dart';
import 'cache_helper.dart';
import 'constants.dart';
import 'dio_helper.dart';
import 'layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark =CacheHelper.getData(key: darkModeKey);
  runApp(MyApp(isDark: isDark,));
}

class MyApp extends StatelessWidget {

  final isDark;
  const MyApp({super.key, this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit()..getData(category: 'business')..changeTheme(fromShared: isDark),
      child: BlocConsumer<NewsCubit,AppStates>(
        listener: (context,state){},
        builder:(context,state)=> MaterialApp(
          home: const Layout(),
          themeMode: NewsCubit.get(context).darkTheme?ThemeMode.dark:ThemeMode.light,
          theme: ThemeData(
            textTheme: TextTheme(
            ),
            primarySwatch: Colors.deepOrange,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white,
              ),
              backgroundColor: Colors.white,
              actionsIconTheme: IconThemeData(
                color: Colors.black,
              ),
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: Colors.deepOrange,
              type: BottomNavigationBarType.fixed,
            ),
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.deepOrange,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor:Color(0xFF333739),
              ),
              backgroundColor: Color(0xFF333739),
              actionsIconTheme: IconThemeData(
                color: Colors.white,
              ),
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            scaffoldBackgroundColor: Color(0xFF333739),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF333739),
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.deepOrange,
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

