import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_amit/Components/Components.dart';
import 'package:graduation_project_amit/Layout/Cubit/AppCubit.dart';
import 'package:graduation_project_amit/Layout/Cubit/AppStates.dart';

class CartScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var cartProduct;
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, Object? state) {

          },
          builder: (BuildContext context, state) {
            AppCubit cubit = AppCubit.get(context);
            print(AppCubit.cartData.toString());


            print(cartProduct);

            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height-150,
                  child: ListView.builder(
                    itemCount: AppCubit.cartData.length,
                    itemBuilder: (BuildContext context, int index) =>
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          //height: 100,
                          //  width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(5.0),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(AppCubit.cartData[index].image,
                                    width: 120,
                                    height:120),
                                SizedBox(width: 1.0,)  ,

                                SizedBox(
                                  width: MediaQuery.of(context).size.width-210,
                                  child: Column(
                                    children: [
                                      Text(AppCubit.cartData[index].name,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 15,color: Colors.black,
                                              fontWeight:FontWeight.w600 )),

                                      Text(AppCubit.cartData[index].title,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 10, color: Colors.black)),

                                      SizedBox(height: 45.0,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(AppCubit.cartData[index].price.toString(),
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w400,
                                            ),),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text('EGP',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w400,
                                            ),),
                                          SizedBox(width: 80.0,),

                                          Container(
                                              height: 30,
                                              width: 30,
                                              decoration:BoxDecoration(
                                                  color: Colors.red[700],
                                                  borderRadius: BorderRadius.circular(10)
                                              ) ,

                                              child: IconButton(onPressed: (){
                                                if(AppCubit.cartData[index].count > 1){
                                                  AppCubit.get(context).updateCartItemCount(index , "-");
                                                }




                                              },
                                                icon:Icon(Icons.remove),
                                                color: Colors.white,iconSize: 25,padding: EdgeInsets.only(),
                                              )),
                                          SizedBox(width: 5.0,),
                                          Text(AppCubit.cartData[index].count.toString(), style: TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                          ),),
                                          SizedBox(width: 7.0,),
                                          Container(
                                              height: 30,
                                              width: 30,
                                              decoration:BoxDecoration(
                                                  color: Colors.red[700],
                                                  borderRadius: BorderRadius.circular(10)
                                              ) ,

                                              child: IconButton(onPressed: (){
                                               AppCubit.get(context).updateCartItemCount(index , "+");

                                              },
                                                icon:Icon(Icons.add),
                                                color: Colors.white,iconSize: 25,padding: EdgeInsets.only(),
                                              )),

                                        ],
                                      ),
                                      /* Row(

                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(function: (){}, text: 'Clear Cart')
                        ],
                      )*/


                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),
                        ),

                      ),

                  ),
                ),
                Divider(thickness: 1,),
                ListTile(
                  leading: SizedBox(
                    height: 50,
                    width: 100,
                    child: CustomButton(function: (){
                      cubit.clearCart();

                    } , text: "Clear"),
                  ),
                  title: Column(
                    children: [
                      Text('total'),
                      Text(AppCubit.get(context).getTotalPrice())
                    ],
                  ),
                  trailing:SizedBox(
                    height: 50,
                    width: 110,
                    child: CustomButton(function: (){
                      cubit.clearCart();
                    } , text: "Check Out"),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
