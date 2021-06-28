import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:match_the_picture/after-game-pages/game-over-page.dart';
import 'package:match_the_picture/after-game-pages/win-page.dart';
import 'package:match_the_picture/data/data.dart';
import 'package:match_the_picture/models/TileModel.dart';
import 'package:page_transition/page_transition.dart';

class NormalGamePage extends StatefulWidget {
  final bool withSound;
  const NormalGamePage({Key key, this.withSound = true}) : super(key: key);
  @override
  _NormalGamePageState createState() => _NormalGamePageState();
}

class _NormalGamePageState extends State<NormalGamePage> {
  List<ItemPojo> gridViewTiles = [];
  List<ItemPojo> questionPairs = [];
  bool start = false;
  bool stop = false;
  AudioPlayer player1 = new AudioPlayer();
  AudioPlayer player2 = new AudioPlayer();
  AudioPlayer backMusic = new AudioPlayer();
  @override
  void initState() {
    super.initState();
    if (widget.withSound) {
      AudioCache audioCache2 = AudioCache(fixedPlayer: backMusic);
      audioCache2.play('back.mp3');
      audioCache2.loop('back.mp3');
    }
    reStart();
  }
  void reStart() {
    points=0;
    myPairs = getPairs(); //here i bet the images for the game
    myPairs
        .shuffle(); //here i mix the imges so that it will not be easily identified
    gridViewTiles = myPairs;
    Future.delayed(const Duration(seconds: 10), () {
// Here you can write your code
      setState(() {
        // Here you can write your code for open new view
        questionPairs = getQuestionPairs();
        gridViewTiles = questionPairs;
        selected = false;
        start = true;
      });
    });
  }

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
        backgroundColor: Color(0xFF25383C),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: start
                      ? TimeCircularCountdown(
                          unit: CountdownUnit.second,
                          countdownTotal: 60,
                          diameter: 150,
                          countdownCurrentColor:
                              timeLeft > 10 ? Colors.blueAccent : Colors.red,
                          textStyle: TextStyle(
                              color: timeLeft > 10 ? Colors.white : Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          onUpdated: (unit, remainingTime) => lastSeconds(),
                          onFinished: () => checkAfterTimeElapse(),
                        )
                      : TimeCircularCountdown(
                          unit: CountdownUnit.second,
                          countdownTotal: 10,
                          diameter: 150,
                          countdownCurrentColor: Colors.red,
                          countdownTotalColor: Colors.redAccent,
                          textStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          onUpdated: (unit, remainingTime) => initSound(),
                          onFinished: () => onInitFinished(),
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "$points/8",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Text(
                      "Matches",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GridView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisSpacing: 0.0, maxCrossAxisExtent: 100.0),
                  children: List.generate(gridViewTiles.length, (index) {
                    return ItemCard(
                      imagePath: gridViewTiles[index].getImageAssetPath(),
                      itemIndex: index,
                      parentState: this,
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //here i will play a ticking sound prompting the user the time left to finish observing the images
  initSound() {
    AudioCache audioCache = AudioCache(fixedPlayer: player1);
    audioCache.play('tick.wav');
  }
  onInitFinished(){
    start=true;
    timeLeft=60;
  }

//===================================================
  //so the the time ticks and the user play the game,
  //i check if the user is getting close to finishing time
  lastSeconds() {
    timeLeft--;
    checkAfterTimeElapse();
    if (timeLeft < 11) {
      //if the time is left with just 10 seconds
      //i start to play a ticking sound, prompting the user , the time is close
      AudioCache audioCache2 = AudioCache(fixedPlayer: player2);
      audioCache2.play('tick.wav');
    }
  }

//here with this function, i check if the time is over
  //and the user is still not done matchig the images
  void checkAfterTimeElapse() {
    if (points == 8) {
      //so if the user point is 8
      //then the user is done matching even before time
      setState(() {
        //todo User failed
        backMusic.stop();
        backMusic.dispose();
        player2.stop();
        player2.dispose();
        player1.stop();
        player1.dispose();
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.size,
                alignment: Alignment.bottomCenter,
                child: YouWin(
                )));
      });
      //Todo User completed,go to next level
    } else if (timeLeft < 1) {
      //but if the time if finished
      //and the user is still not done, matching.
      // then the user has failed
      if (points != 8) {
        setState(() {
          //todo User failed
          backMusic.stop();
          backMusic.dispose();
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.size,
                  alignment: Alignment.bottomCenter,
                  child: GameOver(
                  )));
          print('Failed=-================================');
        });
      }
    }
  }
}

class ItemCard extends StatefulWidget {
  String imagePath;
  int itemIndex;
  _NormalGamePageState parentState;

  ItemCard({this.imagePath, this.itemIndex, this.parentState});

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  AudioPlayer advancedPlayer = new AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!selected) {
          //here i check if the image is not already selected
          setState(() {
            myPairs[widget.itemIndex].setIsSelected(
                true); //so here i set the selected value of the individual image to true
          });
          if (selectedTile != "") {
            // so this line will check if the image selected is not empty
            /// testing if the selected tiles are same
            if (selectedTile == myPairs[widget.itemIndex].getImageAssetPath()) {
              points = points + 1;
              ItemPojo itemPojo = new ItemPojo();
              selected = true;
              AudioCache audioCache2 = AudioCache(fixedPlayer: advancedPlayer);
              audioCache2.play('coins.mp3');
              Future.delayed(const Duration(seconds: 1), () {
                itemPojo.setImageAssetPath("");
                myPairs[widget.itemIndex] = itemPojo;
                myPairs[selectedIndex] = itemPojo;
                this.widget.parentState.setState(() {});
                setState(() {
                  selected = false;
                });
                selectedTile = "";
              });
            } else {
              selected = true;
              AudioCache audioCache2 = AudioCache(
                fixedPlayer: advancedPlayer,
              );
              audioCache2.play('failed.mp3');
              Future.delayed(const Duration(seconds: 1), () {
                this.widget.parentState.setState(() {
                  myPairs[widget.itemIndex].setIsSelected(false);
                  myPairs[selectedIndex].setIsSelected(false);
                });
                setState(() {
                  selected = false;
                });
              });

              selectedTile = "";
            }
          } else {
            setState(() {
              selectedTile = myPairs[widget.itemIndex].getImageAssetPath();
              selectedIndex = widget.itemIndex;
            });
          }
        }
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: myPairs[widget.itemIndex].getImageAssetPath() != ""
                    ? AssetImage(myPairs[widget.itemIndex].getIsSelected()
                        ? myPairs[widget.itemIndex].getImageAssetPath()
                        : widget.imagePath)
                    : AssetImage("assets/money.png"))),
        margin: EdgeInsets.all(5),
      ),
    );
  }
}
