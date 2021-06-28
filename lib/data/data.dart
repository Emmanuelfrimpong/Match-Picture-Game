import 'package:match_the_picture/models/TileModel.dart';

//This is a list of path of the images we have in the appliction
List allImage = [
  'assets/image_01.jpeg',
  'assets/image_02.jpeg',
  'assets/image_03.jpeg',
  'assets/image_04.jpeg',
  'assets/image_05.jpeg',
  'assets/image_06.jpeg',
  'assets/image_07.jpeg',
  'assets/image_08.jpeg',
  'assets/image_09.jpeg',
  'assets/image_10.jpeg',
  'assets/image_11.jpeg',
  'assets/image_12.jpeg',
  'assets/image_13.jpeg',
  'assets/image_14.jpeg',
  'assets/image_15.jpeg',
  'assets/image_16.jpeg',
  'assets/image_17.jpeg',
  'assets/image_18.jpeg',
  'assets/image_19.jpeg',
  'assets/image_20.jpeg',
  'assets/image_21.jpeg',
  'assets/image_22.jpeg',
  'assets/image_23.jpeg',
  'assets/image_24.jpeg',
  'assets/image_25.jpeg',
  'assets/image_26.jpeg',
  'assets/image_27.jpeg',
  'assets/image_28.jpeg',
  'assets/image_29.jpeg',
];
//=======================================================

String selectedTile = "";
int selectedIndex;
bool selected = true;
int points = 0;
int timeLeft=60;

List<ItemPojo> myPairs = [];
List<bool> clicked = [];

List<bool> getClicked() {
  List<bool> yoClicked = [];
  List<ItemPojo> myairs = [];
  myairs = getPairs();
  for (int i = 0; i < myairs.length; i++) {
    yoClicked[i] = false;
  }

  return yoClicked;
}

List<ItemPojo> getPairs() {
  List<ItemPojo> pairs = [];//this is the initial list of pictures that will be userd for playing
  //here i create an instance of the ItemPojo class in oder to add the details of the ind
  ItemPojo tileModel = new ItemPojo();

  allImage.shuffle();
  //here i loop through all the images and randomly select 8 of them that will be used for playing
  for(int i=0;i<8;i++){
    tileModel.setImageAssetPath(allImage[i]);
    tileModel.setIsSelected(false);
    //Note each image is added twice for matching
    pairs.add(tileModel);
    pairs.add(tileModel);
    //======================================
    tileModel = new ItemPojo();
  }
  return pairs;
}
//===========================================

//here i create a list of mask pictures(question mark) which is equivalent to the list of images that will be used
List<ItemPojo> getQuestionPairs() {
  List<ItemPojo> pairs = [];
  ItemPojo tileModel = new ItemPojo();
  for(int i=0;i<8;i++){//here a add the same number of images
    tileModel.setImageAssetPath("assets/question.png");
    tileModel.setIsSelected(false);
    //i add the image twice in order to get the equivalent number of images
    pairs.add(tileModel);
    pairs.add(tileModel);
    tileModel = new ItemPojo();
  }
  return pairs;
}
