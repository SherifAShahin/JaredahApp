import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jaredah/cubit/mode_cubit.dart';
import 'package:jaredah/layout/home_screen.dart';
import 'package:jaredah/network/local/cashe_helper.dart';
import 'package:jaredah/network/remote/dio_helper.dart';
import 'package:jaredah/shared/constants.dart';
import 'cubit/bloc_observer.dart';
import 'cubit/cubit.dart';
import 'cubit/mode_states.dart';
import 'cubit/states.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CasheHelper.init();

  bool? isDark = CasheHelper.getBoolean(key: 'isDark');

  if(isDark == null)
  {
    isDark = false;
  }
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final bool isDark;

  MyApp(
      this.isDark,
      );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => JaredahModeCubit()..changeAppMode(fromShared: isDark)),
        BlocProvider(create: (context) => JaredahCubit()..getBusinessData()),
      ],
      child: BlocConsumer<JaredahModeCubit, JaredahModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          JaredahModeCubit cubit = JaredahModeCubit.get(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.dark,
                    systemNavigationBarColor: Colors.white,
                    systemNavigationBarIconBrightness: Brightness.dark
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                  size: 35.0,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.deepOrange,
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              scaffoldBackgroundColor: HexColor('#000114'),
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('#010554'),
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.light,
                    systemNavigationBarColor: HexColor('#010554'),
                    systemNavigationBarIconBrightness: Brightness.light
                ),
                backgroundColor: HexColor('#010554'),
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.white,
                  size: 35.0,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('#010554'),
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.deepOrange,
              ),
            ),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}


// theme: ThemeData(
//   primarySwatch: Colors.deepOrange,
//   appBarTheme: AppBarTheme(
//     systemOverlayStyle: SystemUiOverlayStyle(
//       statusBarColor: Colors.white,
//       statusBarIconBrightness: Brightness.dark,
//     ),
//     color: Colors.white,
//     titleTextStyle: TextStyle(
//       fontSize: 25.0,
//       fontWeight: FontWeight.bold,
//       color: Colors.black,
//     ),
//     iconTheme: IconThemeData(
//       color: Colors.black,
//     ),
//     elevation: 0.0,
//   ),
//   scaffoldBackgroundColor: Colors.white,
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     type: BottomNavigationBarType.fixed,
//     backgroundColor: Colors.white,
//     selectedItemColor: Colors.deepOrange,
//   ),
// ),