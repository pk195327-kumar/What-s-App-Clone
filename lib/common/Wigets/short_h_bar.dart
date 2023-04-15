import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';

class ShortHBar extends StatelessWidget {
  const ShortHBar({super.key, this.height, this.weight, this.color});
  final double? height;
  final double? weight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 4,
      width: weight ?? 25,
      decoration: BoxDecoration(
        color: color ?? context.theme.graycolor!.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
