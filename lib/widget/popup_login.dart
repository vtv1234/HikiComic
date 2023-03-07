import 'package:flutter/material.dart';
import 'package:hikicomic/img_path.dart';

Dialog loginDialog = Dialog(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  elevation: 16,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('One-click social media sign in'),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                  iconSize: 60,
                  onPressed: () {},
                  icon: Image.asset(
                    ImagePath.googleIconPath,
                    //height: ,
                    //width: 300,
                  )),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  iconSize: 60,
                  onPressed: () {},
                  icon: Image.asset(
                    ImagePath.googleIconPath,
                    //height: ,
                    //width: 300,
                  )),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  iconSize: 60,
                  onPressed: () {},
                  icon: Image.asset(
                    ImagePath.googleIconPath,
                    //height: ,
                    //width: 300,
                  )),
            ),
          ],
        ),
        Text('Sign In with email'),
        TextFormField(),
        TextFormField(),
        SizedBox(
          //width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Sign In'),
          ),
        )
      ],
    ),
  ),
);
