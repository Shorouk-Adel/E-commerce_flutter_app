

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Menu screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
