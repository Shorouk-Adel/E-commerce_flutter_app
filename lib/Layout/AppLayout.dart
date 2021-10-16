import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_amit/Layout/Cubit/AppCubit.dart';
import 'package:graduation_project_amit/Layout/Cubit/AppStates.dart';


class AppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(BuildContext context) => AppCubit(),
        child: BlocConsumer<AppCubit,AppStates>(
            listener:(context,state){} ,
            builder: (context,state) {
              AppCubit cubit = AppCubit.get(context);
              return Scaffold(
                body: cubit.MainScreens[cubit.currentIndex],

                bottomNavigationBar: BottomNavigationBar(

                  unselectedItemColor: Colors.black54,
                  selectedItemColor: Colors.red[700],
                  elevation: 20.0,
                  items:
                  cubit.bottomItems,
                  currentIndex: cubit.currentIndex,
                  onTap: (index){
                    cubit.changeIndex(index);
                  },


                ),

              );
            }));
  }
}
