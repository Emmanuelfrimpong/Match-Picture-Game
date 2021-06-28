import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectableButton extends StatelessWidget {
  final bool isSelected;
  final Color selectedColor, unSelectedColor;
  final String leble;
  final Function onTap;
  const SelectableButton(
      {Key key,
      this.isSelected,
      this.selectedColor,
      this.unSelectedColor,
      this.leble,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: isSelected ? selectedColor : unSelectedColor),
        child: Card(
          elevation:isSelected? 10:0,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
          leble,
          style: TextStyle(
                fontSize: 20, color: isSelected ? Colors.white : Colors.black),
        )),
            )),
      ),
    );
  }
}
