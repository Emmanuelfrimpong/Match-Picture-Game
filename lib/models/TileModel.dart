
///this is the class for getting individual pictures and details
class ItemPojo{
  String imagePath;//the picture path as string
  bool isSelected;// to check id the picture is selected
  ItemPojo({this.imagePath, this.isSelected});

  //here we can set the path value of the picture
  void setImageAssetPath(String getImageAssetPath){
    imagePath = getImageAssetPath;
  }

  //here we can get the path value of the pictur
  String getImageAssetPath(){
    return imagePath;
  }

  //here we can set the selected value of the picture
  void setIsSelected(bool getIsSelected){
    isSelected = getIsSelected;
  }

  //here we can get the selected value of the picture.
  bool getIsSelected(){
    return isSelected;
  }
}