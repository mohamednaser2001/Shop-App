import 'package:flutter/material.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/models.dart';
import '../shared/network/local/cache_helper.dart';

class OnBoardingScreen extends  StatelessWidget {

  List<OnBoardingItem> items = [
    OnBoardingItem(image: 'assets/images/on_boarding1.jpg', body: 'Shop from a wide selection of products from top brands, with over 50.000 product on our online shop.', title: 'Shop App'),
    OnBoardingItem(image: 'assets/images/on_boarding2.jpg', body: 'Choose all the products you like, and buy it with the lowest price and the highest quality.', title: 'Buy'),
    OnBoardingItem(image: 'assets/images/on_boarding3.jpg', body: 'You can order any product from anywhere, and we will deliver it to you.', title: 'Delivery'),
  ];
  var onBoardController = PageController();
  bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child:const Text(
                'skip'
            ),
            onPressed: (){
              CacheHelper.saveData(key: 'onBoarding',value: true).then((value) {
                if(value==true){
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context)=>LoginScreen(),),
                        (route) => false,
                  );
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(

                itemBuilder: (context,index) => onBoardingScreen(items[index]),
                onPageChanged: (index){
                  if(index==items.length-1){
                    isLast=true;
                  }else {
                    isLast=false;
                  }
                },
                physics: BouncingScrollPhysics(),
                itemCount: items.length,
                controller: onBoardController,
              ),
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: onBoardController,
                    count: items.length,
                    effect:const ExpandingDotsEffect(
                      activeDotColor: Colors.deepOrange,
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      expansionFactor: 3,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                ),
                Spacer(),
                FloatingActionButton(
                  child: Icon(
                    Icons.arrow_forward_rounded,
                  ),
                    onPressed: (){
                    if(isLast){
                      CacheHelper.saveData(key: 'onBoarding',value: true).then((value) {
                        if(value==true){
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context)=>LoginScreen(),),
                                (route) => false,
                          );
                        }
                      });
                    }else {
                      onBoardController.nextPage(
                        duration: Duration(milliseconds: 750,),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                    }

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
