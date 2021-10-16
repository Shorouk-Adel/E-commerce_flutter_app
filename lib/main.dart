import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_amit/Layout/Cubit/AppCubit.dart';
import 'package:graduation_project_amit/Layout/Cubit/AppStates.dart';
import 'package:graduation_project_amit/MyBlocObserver.dart';
import 'package:graduation_project_amit/OnBoarding/OnBoarding.dart';


  void main() {
    Bloc.observer = MyBlocObserver();

    runApp(myApp());
  }

Widget myApp(){
return BlocProvider(
      create:(BuildContext context) => AppCubit()..getHomeData(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context , state) {},
          builder: (context , state) {

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                //primarySwatch: Colors.red,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      //to control status bar
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.red[700],
                          statusBarIconBrightness: Brightness.light
                      )
                  ),

                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    //selectedItemColor: Colors.

                  )

              ),
              home: OnBoarding(),
            );
          }
      ));
}



