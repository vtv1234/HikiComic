import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  // final String label;
  final IconData icon;
  final Function() onTap;
  //final Size? iconSize;
  const ButtonIcon({
    Key? key,
    // required this.label,
    required this.icon,
    required this.onTap,
    // this.iconSize = const Size(40, 40),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Material(
        //color: Colors.amberAccent,
        child: InkWell(
          //splashColor: Colors.green,
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Icon(icon, size: 25), // <-- Icon
                      // Text(
                      //   label,
                      //   maxLines: 1,
                      //   textAlign: TextAlign.center,
                      // ), // <-- Text
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
