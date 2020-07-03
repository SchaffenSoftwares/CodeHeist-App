import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:codeheist/constants.dart';
import 'package:codeheist/components/sizeConfig.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Container(
              child: Text(
                'Send Email Invite',
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Container(
                  child: TextField(
                    decoration: kTextFieldDecoration,
                  ),
                  width: SizeConfig.blockSizeHorizontal * 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 42,
                      color: kConstantBlueColor,
                    ),
                    onPressed: null),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8,30,0,0),
            child: Container(
              child: Text('View Invites',style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Muli',
                  fontWeight: FontWeight.w600),),
            ),
          ),
        ],
      ),
    );
  }
}