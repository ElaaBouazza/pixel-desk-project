import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/functions/category.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/Screens/home/functions/dashboard.dart';
import 'package:flutter_auth/Screens/home/functions/category.dart';
import 'package:flutter_auth/Screens/home/functions/statistics.dart';
import 'package:flutter_auth/Screens/home/functions/timetable.dart';
import 'package:flutter_auth/services/auth.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

class Home extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Dashboard(),
    Timetable(),
    Statistics(),
    Categories(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard(); 
  @override
  void initState(){
        
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    
    super.initState();
  }
  final AuthService _auth = AuthService();
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:kPrimaryColor,
      appBar: AppBar(
        backgroundColor:kPrimaryColor,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: kPrimaryLightColor,),
            label: Text('logout'), textColor: kPrimaryLightColor,
            onPressed: () async {await _auth.signOut();},
          )          
        ],
        ),


        // Flaoting Action button Icon 
      
      
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            MaterialButton(minWidth:40, onPressed: (){ setState((){currentScreen = Dashboard(); currentTab = 0;});
            },
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.dashboard_rounded, color: currentTab==0 ? retroCo: kPrimaryLightColor,
              ),
              Text('Dasboard', style: TextStyle(color:currentTab==0 ? retroCo: kPrimaryLightColor, fontFamily: 'Pixel',
              ),
              ),
            ],
            ),
            ),
            MaterialButton(minWidth: 40, onPressed: () {setState(() {currentScreen = Timetable(); currentTab = 1;});},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.calendar_today_rounded, color: currentTab == 1 ? retroCo: kPrimaryLightColor,
                        ),
                  Text(
                    'TimeTable',
                    style: TextStyle(color: currentTab == 1 ? retroCo: kPrimaryLightColor, fontFamily: 'Pixel',
                      ),
                    ),
                ],
                ),
              )
            ],
          ),
          //Right Tab bar icons
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            MaterialButton(minWidth: 40, onPressed: () {
              setState(() {currentScreen = Categories(); // if user taps on this dashboard tab will be active
                currentTab = 2;
                      });
                    },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.dvr_rounded,
                  color: currentTab == 2 ? retroCo: kPrimaryLightColor,
                        ),
                  Text(
                          'Categories',
                          style: TextStyle(
                            color: currentTab == 2 ? retroCo: kPrimaryLightColor, fontFamily: 'Pixel',
                          ),
                        ),
                      ],
                    ),
                  ),
              MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Statistics(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.insert_chart,
                    color: currentTab == 3 ? retroCo: kPrimaryLightColor,
                        ),
                  Text(
                          'Statistics',
                          style: TextStyle(
                            color: currentTab == 3 ? retroCo: kPrimaryLightColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )

            ],
            ),
          
          ),
      ),


      
    );
    
  }
}