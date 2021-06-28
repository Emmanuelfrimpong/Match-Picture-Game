import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:match_the_picture/data/data.dart';
import 'package:match_the_picture/normal-level/normal-game-page.dart';
import 'package:page_transition/page_transition.dart';

class GameOver extends StatefulWidget {
  const GameOver({Key key}) : super(key: key);

  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  AudioPlayer player = new AudioPlayer();
  bool withMusic=true;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    timeLeft=60;
    AudioCache audioCache2 = AudioCache(fixedPlayer: player);
    audioCache2.play('gamefailed.MP3');
  }
  @override
  void dispose() {
    // TODO: implement dispose
    player.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
              Card(
                elevation: 15,
                margin: EdgeInsets.all(15),
                child: Container(
                  width: double.infinity,
                  height:MediaQuery.of(context).size.height/3 ,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/failed.jpg'), fit: BoxFit.fill)),
                ),
              ),
              SizedBox(height: 15,),

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
              SizedBox(height: 20,),
              Container(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.size,
                                    alignment: Alignment.bottomCenter,
                                    child: NormalGamePage(withSound: withMusic,)));
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            "Play Again",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: _onWillPop,
                        child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            "Exit Game",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
