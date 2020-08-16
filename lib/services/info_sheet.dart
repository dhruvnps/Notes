import "package:intl/intl.dart";

import 'package:flutter/material.dart';
import 'package:notes/services/theme.dart';
import 'package:notes/services/data.dart';

class InfoSheet extends StatelessWidget {
  final bool isInfoOpen;
  final int noteIndex;
  InfoSheet({this.isInfoOpen, this.noteIndex});

  final double infoPadding = 25;
  final double infoHeight = 202;
  final int animMilliseconds = 500;
  final DateFormat format = DateFormat('dd/MM/yy, HH:mm');

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.symmetric(horizontal: 15),
      color: appBarColor,
      height: isInfoOpen ? infoHeight : 0,
      width: MediaQuery.of(context).size.width,
      duration: Duration(milliseconds: animMilliseconds),
      curve: Curves.fastOutSlowIn,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: infoPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Words',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    Data.notes[noteIndex].text
                        .replaceAll('\n', ' ')
                        .split(' ')
                        .where((word) => word != '')
                        .length
                        .toString(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              SizedBox(height: infoPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Characters'),
                  Text(
                    Data.notes[noteIndex].text.length.toString(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              SizedBox(height: infoPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Modified'),
                  Text(
                    format.format(Data.notes[noteIndex].dateModified),
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
              SizedBox(height: infoPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Created'),
                  Text(
                    format.format(Data.notes[noteIndex].dateCreated),
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
              SizedBox(height: infoPadding),
            ],
          ),
        ),
      ),
    );
  }
}
