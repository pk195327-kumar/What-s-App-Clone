import 'package:flutter/material.dart';

import 'package:whats_app_me/common/utils/coloors.dart';

class Custom_ElevatedButton extends StatelessWidget {
  final double? buttonwidth;
  final VoidCallback? onPressed;
  final String? text;
  const Custom_ElevatedButton({
    Key? key,
    this.buttonwidth,
    this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: buttonwidth ?? MediaQuery.of(context).size.width - 100,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: coloors.greendark,
              foregroundColor: coloors.backgrounddark,
              splashFactory: NoSplash.splashFactory,
              elevation: 0,
              shadowColor: Colors.transparent),
          child: Text("$text")),
    );
  }
}
