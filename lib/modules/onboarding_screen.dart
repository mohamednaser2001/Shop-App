import 'package:flutter/material.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/models.dart';
import '../shared/network/local/cache_helper.dart';

class OnBoardingScreen extends  StatelessWidget {

  List<OnBoardingItem> items = [
    OnBoardingItem(image: 'assets/images/onboarding1.jpg', body: 'body 1', title: 'page 1'),
    OnBoardingItem(image: 'assets/images/onboarding1.jpg', body: 'body 2', title: 'page 2'),
    OnBoardingItem(image: 'assets/images/onboarding1.jpg', body: 'body 3', title: 'page 3'),
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
