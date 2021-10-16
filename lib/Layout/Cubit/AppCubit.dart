import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_amit/Layout/Cubit/AppStates.dart';
import 'package:graduation_project_amit/MainScreens/Cart/CartModel.dart';
import 'package:graduation_project_amit/MainScreens/Cart/cart_screen.dart';
import 'package:graduation_project_amit/MainScreens/Categories/Categories.dart';
import 'package:graduation_project_amit/MainScreens/Home/Home.dart';
import 'package:graduation_project_amit/MainScreens/Menu/Menu.dart';

class AppCubit extends Cubit<AppStates> {
  // call Super constructor with initial State
  AppCubit() : super(AppInitialState());


  static AppCubit get(context) => BlocProvider.of(context);
  //Data

  int total = 0;
  int currentIndex = 0;
 static List<CartModel> cartData = [];



 void updateCartItemCount(int index , String sign){
   int old = AppCubit.cartData[index].count;
   if(sign == '+'){
     cartData[index].updateCount(old+1);
   }else {
     cartData[index].updateCount(old-1);
   }

  emit(AddTocartState());
 }




 String getTotalPrice(){
  String  totalText = '0';
    if(cartData.isEmpty == true){
      return totalText = "0";
    }else{
      total =0;
      for (int i = 0 ; i < cartData.length ; i++){
        total = (cartData[i].price * cartData[i].count)+ total ;
      }
      totalText = total.toString();
      return totalText;
    }



 }

void clearCart(){
  cartData.clear();

  emit(ClearcartState());
}
  void insertToCart(CartModel model){
    cartData.add(model);
    cartData.forEach((element) {
      print(element.name);
    });
    emit(AddTocartState());
  }


  List<Widget>MainScreens=[
    HomePage(),
    Categories(),
    CartScreen(),
    Menu(),

  ];


  List<BottomNavigationBarItem> bottomItems =
  [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home'),

    BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined),
        label: 'Categories'),

    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_outlined),
        label: 'Cart'),

    BottomNavigationBarItem(
        icon: Icon(Icons.menu_book_outlined),
        label: 'Menu'),
  ];

  //Actions
  void changeIndex(int newIndex){
    currentIndex = newIndex;
    if(currentIndex==0){
      emit(BottomNavBarItemMovedToHome());
    }
    else if(currentIndex==1){
      emit(BottomNavBarItemMovedToCategories());
    }
    else if(currentIndex==2){
      emit(BottomNavBarItemMovedToCart());
    }
    else{
      emit(BottomNavBarItemMovedToMenu());
    }

  }
  TextDirection appDirection = TextDirection.ltr;


  void getHomeData() {

    emit(HomeDataLoadingState());

  }



}