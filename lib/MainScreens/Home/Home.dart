import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:graduation_project_amit/MainScreens/Cart/CartModel.dart';
import 'package:http/http.dart' as http;
import 'package:graduation_project_amit/Layout/Cubit/AppCubit.dart';
import 'package:graduation_project_amit/MainScreens/Home/ProductModel.dart';
import 'package:graduation_project_amit/MainScreens/SingleProduct/SingleProductScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {

  List? listOfMaps;
  List listOfProducts=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
            'Home',
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[100],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            childAspectRatio: 1 / 1.40,
            children: List.generate(
              listOfProducts.length,
              (index) => Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 2.0,
                            start: 2.0,
                            end: 2.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SingleProductScreen(
                                          listOfProducts[index])));
                            },
                            child: Card(

                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AspectRatio(
                                    aspectRatio: 6.0 / 6.0,
                                    child: Image.network(
                                      listOfProducts[index].image.toString(),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        1.0, 1.0,1.0, 1.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          listOfProducts[index].title,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 9.5,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 1.0,
                                        ),
                                        Text(listOfProducts[index].name,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 8.5,
                                                fontWeight: FontWeight.w500)),
                                       
                                        Row(
                                          children: [
                                            IconButton(
                                              iconSize: 40.0,
                                              padding: new EdgeInsets.fromLTRB(
                                                  0, 3.0, 0, 0.0),
                                              icon: new Icon(
                                                Icons.add_box_rounded,
                                                size: 30.0,
                                                color: Colors.red[700],
                                              ),
                                              onPressed: () {

                                                AppCubit.get(context).insertToCart(new CartModel(listOfProducts[index].image.toString(), listOfProducts[index].name.toString(), listOfProducts[index].title.toString(), listOfProducts[index].price, 1));



                                              },
                                            ),
                                            SizedBox(width: 15,),
                                            Row(
                                              children: [
                                                Text(listOfProducts[index]
                                                    .price
                                                    .toString(),style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                    color: Colors.red[700]
                                                ),),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  " EGP",style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                  color: Colors.red[700]
                                                ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ])),
            ),
          ),
        ),
      ),
    );
  }

  Future <void>  fetchData() async {
    final  response = await http.get(Uri.parse(
        'https://retail.amit-learning.com/api/products'));
    if (response.statusCode == 200) {
      print('response status code is: ${response.statusCode}');
      print('ok.. data is retrieved successfully');
      listOfMaps = jsonDecode(response.body)['products'];
      //  print(listOfMaps);

      setState(() {
        for (int i = 0; i < listOfMaps!.length; i++) {
          listOfProducts.add(ProductModel(
              listOfMaps![i]['id'],
              listOfMaps![i]['name'],
              listOfMaps![i]['title'],
              listOfMaps![i]['category_id'],
              listOfMaps![i]['description'].toString(),
              listOfMaps![i]['price'],
              listOfMaps![i]['avatar']));
        }
      });
    }
    else{
      throw Exception('unfortunately.. data has some problems');}
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();

  }
}
