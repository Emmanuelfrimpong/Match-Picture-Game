import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_the_picture/normal-level/normal-game-page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:slider_button/slider_button.dart';

import 'widgets/selectable-buttons.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String level = 'Normal';
  bool withMusic = true;

  // function to show a messge at the bottom of the app
  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
//==============================================================
  //this function will check if the user wants to exit the game
  //and prompt the user before exiting
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit the Game? '),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  //=================================================
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/back.jpg'), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  elevation: 15,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info,
                                size: 30,
                                color: Color(0xFF000080),
                              ),
                              Text(
                                'Please Note !',
                                style: TextStyle(
                                    color: Color(0xFF000080),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 5,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'You have 10 Seconds to Observe Images.',
                                style: TextStyle(
                                    height: 1.5, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 5,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'You Have 60 Seconds to Match all Pictures.',
                                style: TextStyle(
                                    height: 1.5, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 5,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'You can Restart Game if time Expire',
                                style: TextStyle(
                                    height: 1.5, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SelectableButton(
                onTap: () {
                  setState(() {
                    level = 'Normal';
                  });
                },
                unSelectedColor: Colors.white,
                leble: 'Normal',
                isSelected: level == 'Normal' ? true : false,
                selectedColor: Colors.red,
              ),
              SelectableButton(
                onTap: () {
                  setState(() {
                    level = 'Hard';
                  });
                },
                unSelectedColor: Colors.white,
                leble: 'Hard',
                isSelected: level == 'Hard' ? true : false,
                selectedColor: Colors.red,
              ),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                      value: withMusic,
                      activeColor: Colors.red,
                      onChanged: (onChanged) {
                        setState(() {
                          //check if the user wants the background music or not
                          withMusic = onChanged;
                        });
                      }),
                  Text(
                    'Play Background Music',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SliderButton(
                    dismissible: false,
                    action: () {
                      setState(() {
                        if (level.trim().isNotEmpty) {
                          if (level == 'Normal') {
                            //if the user wants to play normal....then i display the game to the user
                            //with the help of page transition, i can add a little animation
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.size,
                                    alignment: Alignment.bottomCenter,
                                    child: NormalGamePage(
                                      withSound: withMusic,
                                    )));
                          } else {
                            //if the user select hard
                            //here i tell the user that feature is not available yet
                            showInSnackBar(
                                'The Feature is not Available is Demo Mode');
                          }
                        }
                      });
                    },
                    label: Text(
                      "Slide to start Game",
                      style: TextStyle(
                          color: Color(0xff4a4a4a),
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                    icon: Center(
                        child: Icon(
                      Icons.games,
                      color: Colors.red,
                      size: 40.0,
                    )),
                    boxShadow: BoxShadow(
                      color: Colors.black,
                      blurRadius: 4,
                    ),
                    width: 300,
                    radius: 40,
                    buttonColor: Color(0xffd60000),
                    backgroundColor: Colors.white,
                    highlightedColor: Colors.white,
                    baseColor: Colors.red,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
