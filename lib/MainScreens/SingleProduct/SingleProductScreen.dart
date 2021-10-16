import 'package:flutter/material.dart';
import 'package:graduation_project_amit/Components/Components.dart';
import 'package:graduation_project_amit/Layout/Cubit/AppCubit.dart';
import 'package:graduation_project_amit/MainScreens/Cart/CartModel.dart';
import 'package:graduation_project_amit/MainScreens/Home/ProductModel.dart';
class SingleProductScreen extends StatefulWidget {
  final ProductModel model;
  const SingleProductScreen(this.model, {Key? key}) : super(key: key);

  @override
  _SingleProductScreenState createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  static int counter=1;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon:Icon(Icons.arrow_back_ios,color: Colors.black),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(widget.model.image.toString(),
            height: 180,
            width: 150,
            fit: BoxFit.fitHeight,
          ),
          SizedBox(height: 5.0,),

          Text(widget.model.title.toString(),
            maxLines: 1,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500
            ),),
          SizedBox(
            height: 5.0,
          ),

          Text(widget.model.name.toString(),
            maxLines: 2,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),),
          SizedBox(
            height: 5.0,
          ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Divider(color: Colors.black,thickness: 1.0,),
          ),
          SizedBox(
            height: 5,
          ),

          Padding(
            padding: const EdgeInsets.all(11.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.model.price.toString(),
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),),
                SizedBox(
                  width: 2.5,
                ),
                Text('EGP',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),),
                SizedBox(width: 100.0,),

                Container(
                  height: 30,
                  width: 30,
                  decoration:BoxDecoration(
                    color: Colors.red[700],
                    borderRadius: BorderRadius.circular(20)
                  ) ,

                    child: IconButton(onPressed: (){
                      setState(() {
                        if(counter>1)
                        counter--;
                      });

                    },
                      icon:Icon(Icons.remove),
                      color: Colors.white,iconSize: 25,padding: EdgeInsets.only(),
                    )),
                SizedBox(width: 15.0,),
                Text('${counter}', style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                ),),
                SizedBox(width: 15.0,),
                Container(
                    height: 30,
                    width: 30,
                    decoration:BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: BorderRadius.circular(20)
                    ) ,

                    child: IconButton(onPressed: (){
                      setState(() {
                        counter++;
                      });

                    },
                      icon:Icon(Icons.add),
                      color: Colors.white,iconSize: 25,padding: EdgeInsets.only(),
                    )),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Divider(color: Colors.black,thickness: 1.0,),
          ),
          SizedBox(height: 5.0,),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(widget.model.description.toString(),
              maxLines: 2,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500
              ),),
          ),
          SizedBox(
            height: 45.0,
          ),
          CustomButton(function: (){
            AppCubit.get(context).insertToCart
              (new CartModel(widget.model.image.toString(),
                widget.model.name.toString(), widget.model.title.toString(),
                widget.model.price, counter));

          },
          text: 'Add To Cart',
             width: 350,
           radius: 30
          )


        ],
      ),

    );
  }
}

