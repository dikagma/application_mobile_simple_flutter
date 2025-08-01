import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/mydrawer.widget.dart';

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
      title: Text("Home"),
    ),
        body: Center( child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ Text( "Home Page ..",style: Theme.of(context).textTheme.bodyMedium,
          ),
          ],
        ),
        )
    );

  }

}