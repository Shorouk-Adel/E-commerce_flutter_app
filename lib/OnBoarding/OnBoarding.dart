import 'package:flutter/material.dart';
import 'package:graduation_project_amit/Components/Components.dart';

import 'package:graduation_project_amit/MainScreens/Login/LoginPage.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardModel
{
  final String? image;
  final String? title;
  final String? body;

  BoardModel({this.image, this.title, this.body});
}


class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  List<BoardModel>boardScreens=[
    BoardModel(
        image:'images/body1.jpg',
        title: 'Choose your product',
        body: 'Where you can find a huge variety of whatever you want '
    ),
    BoardModel(
        image:'images/addCart.jpg',
        title: 'Add to Cart',
        body: 'With just 1 click you can buy all your needs'
    ),
    BoardModel(
        image:'images/body3.png',
        title: 'Enjoy Your Shopping',
        body: 'Get high quality products with best prices '
    )
  ];
  var boardController=PageController();
  bool isLast=false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: (){
              navigateAndFinish(
                context,
                LoginPage(),
              );
          },
            child: Text('SKIP',style: TextStyle(
                color: Colors.red[800],
                fontSize: 17,
                fontWeight: FontWeight.w500

            )
            ),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index){
                  if(index==boardScreens.length-1){
                    print('last one');
                    setState(() {
                      isLast=true;
                    });}
                  else{
                    print('not the last');
                    setState(() {
                      isLast=false;
                    });}

                },
                physics: BouncingScrollPhysics(),
                itemBuilder:
                    (context,index)=>buildBoardingItem(boardScreens[index]),
                itemCount: boardScreens.length,
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.red,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      spacing: 5.0,
                      expansionFactor: 4,

                    ),
                    count: boardScreens.length),

                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      navigateAndFinish(
                        context,
                        LoginPage(),
                      );

                    }
                    else{
                      boardController.nextPage(
                          duration: Duration(
                            milliseconds: 800,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  child:Icon(Icons.arrow_forward_ios),
                  backgroundColor: Colors.red[800],)
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget buildBoardingItem(BoardModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image.asset('${model.image}',)),
      SizedBox(height: 25.0,),
      Text('${model.title}',style:
      TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal
      )),
      SizedBox(height: 15.0,),
      Text('${model.body}',style:
      TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal
      )),
      SizedBox(height: 25.0,),

    ],
  );

}
