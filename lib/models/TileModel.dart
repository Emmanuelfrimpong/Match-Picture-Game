class ItemPojo{

  String imagePath;
  bool isSelected;

  ItemPojo({this.imagePath, this.isSelected});

  void setImageAssetPath(String getImageAssetPath){
    imagePath = getImageAssetPath;
  }

  String getImageAssetPath(){
    return imagePath;
  }

  void setIsSelected(bool getIsSelected){
    isSelected = getIsSelected;
  }

  bool getIsSelected(){
    return isSelected;
  }
}