import 'package:exercise_app/Screens/SetUpProfileScreen.dart';

import '../AllText.dart';
import '../Themes.dart';
import 'TabsScreen.dart';
import 'package:exercise_app/CustomWidgets/CustomTextWidget.dart';
import 'package:exercise_app/main.dart';
import 'package:flutter/material.dart';

class IntroSlider extends StatefulWidget {
  @override
  _IntroSliderState createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> with TickerProviderStateMixin{

  TabController? tabController;
  List<CustomWidgetClass> list = [];
  List<Widget> widgetList = [];
  int index = 0;
  CustomTextWidget customWidgetClass=CustomTextWidget();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(initialIndex: 0, vsync: this, length: 3);
    tabController!.addListener(() {
      setState(() {
        index = tabController!.index;
      });
    });
    setState(() {
      list.add(CustomWidgetClass(
        "assets/splash/1 crop.png",
        HEADING1[LANGUAGE_TYPE],
        SUB_HEADING1[LANGUAGE_TYPE],
        TAG_LINE1[LANGUAGE_TYPE],
        BUTTON_TEXT1[LANGUAGE_TYPE],
      ));
      list.add(CustomWidgetClass(
        "assets/splash/3 crop.png",
        HEADING2[LANGUAGE_TYPE],
        SUB_HEADING2[LANGUAGE_TYPE],
        TAG_LINE2[LANGUAGE_TYPE],
        BUTTON_TEXT2[LANGUAGE_TYPE],
      ));
      list.add(CustomWidgetClass(
        "assets/splash/2 crop.png",
        HEADING3[LANGUAGE_TYPE],
        SUB_HEADING3[LANGUAGE_TYPE],
        TAG_LINE3[LANGUAGE_TYPE],
        BUTTON_TEXT3[LANGUAGE_TYPE],
      ));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  body(){
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              TabBarView(
                controller: tabController,
                children: [
                  customWidget(list[0].image, list[0].heading, list[0].tagLine, list[0].subHeading, list[0].buttonText),
                  customWidget(list[1].image, list[1].heading, list[1].tagLine, list[1].subHeading, list[1].buttonText),
                  customWidget(list[2].image, list[2].heading, list[2].tagLine, list[2].subHeading, list[2].buttonText),
                ],
              ),
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SetUpProfileScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: customWidgetClass.mediumText(text: SKIP,size: ipad ? 30 : 18,color: LIGHT_GREY_TEXT)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: index == 0 ? BLUE : TAB_GREY,
              ),
            ),
            SizedBox(width: 10,),
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: index == 1 ? BLUE :TAB_GREY,
              ),
            ),
            SizedBox(width: 10,),
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: index == 2 ? BLUE :TAB_GREY,
              ),
            )
          ],
        ),
        SizedBox(height: 20,),
        InkWell(
          onTap: (){
            if(index < 2){

              tabController!.animateTo(index + 1, curve: Curves.easeIn, duration: Duration(milliseconds: 500));

            }
            else if(index==2){

              Navigator.push(context, MaterialPageRoute(builder: (context) => SetUpProfileScreen()));
    }
          },

            child: Card(
              color: BLUE,
              elevation: 3,
              shadowColor: BLUE.withOpacity(0.5),
              child: Padding(
                padding: EdgeInsets.fromLTRB(70, 17, 70, 17),
                child: customWidgetClass.mediumText(text: BUTTON_TEXT1,size: ipad ? 30 :15,color: WHITE),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),

        SizedBox(height: 20,),
      ],
    );
  }

  customWidget(String image, String heading, String tagLine, String subHeading, String buttonText){
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 180,
                child: Center(
                  child: Image.asset(
                    "assets/splash/bg.png",
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          image,
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width - 20,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),
        customWidgetClass.heavyText(text: heading,size: ipad ? 55 : 30,color: BLACK),
       customWidgetClass.mediumText(text: subHeading,size: ipad ? 40 : 20,color: DARK_GREY_TEXT),
        SizedBox(height: 10,),
        Container(
          margin: EdgeInsets.only(left: 60,right: 60),
          child: customWidgetClass.regularText(text: tagLine,size: ipad ? 30 : 15,color: LIGHT_GREY_TEXT,alignment: TextAlign.center),
        ),
        SizedBox(height: 20,),
      ]
    );
  }

}

class CustomWidgetClass{
  String image;
  String heading;
  String subHeading;
  String tagLine;
  String buttonText;

  CustomWidgetClass(
  this.image, this.heading, this.subHeading, this.tagLine, this.buttonText);
}
