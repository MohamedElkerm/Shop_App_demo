import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/presentation_layer/screens/login/login.dart';
import 'package:shop_app/presentation_layer/widgets/SharedWidgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/on_boarding1.gif',
        title: 'On Board 1',
        body: 'on board 1 body'),
    BoardingModel(
        image: 'assets/images/on_boarding3.gif',
        title: 'On Board 2',
        body: 'on board 2 body'),
    BoardingModel(
        image: 'assets/images/on_boarding2.gif',
        title: 'On Board 3',
        body: 'on board 3 body'),
  ];

  var boardController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#FFFFFF'),
        elevation: 0,
        actions: [
          TextButton(onPressed: (){navigateToAndReplacement(context, ShopLoginScreen());}, child: Text('Skip',style: TextStyle(color: HexColor('#F18D35')),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged:(index){
                  if(index==boarding.length-1){
                    setState((){
                      isLast = true;
                    });
                  }else{
                    setState((){
                      isLast = false;
                    });
                  }
                } ,
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect:ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    spacing: 5,
                    expansionFactor: 4,
                    activeDotColor:HexColor('#F18D35') ,
                  ) ,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast){
                      navigateToAndReplacement(context, ShopLoginScreen());
                    }else{
                      boardController.nextPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInBack);
                    }
                  },
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(model) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //PageView.builder(itemBuilder:(context,index)=>),
          Image.asset('${model.image}'),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 14),
          ),
        ],
      );
}
