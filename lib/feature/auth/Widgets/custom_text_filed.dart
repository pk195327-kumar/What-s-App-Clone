import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';
import 'package:whats_app_me/common/utils/coloors.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({
    super.key,
    this.controller,
    this.hintText,
    this.readOnly,
    this.textAlign,
    this.keyboradType,
    this.prefixText,
    this.onTap,
    this.suffixIcone,
    this.onChanged, this.fontSize, this.autoFocus,this.maxLength
  });
  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboradType;
  final String? prefixText;
  final VoidCallback? onTap;
  final Widget? suffixIcone;
  final Function(String)? onChanged;
  final double? fontSize;
  final bool? autoFocus;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      textAlign: textAlign ?? TextAlign.center,
      keyboardType: readOnly == null ? keyboradType : null,
      onChanged: onChanged,
      style: TextStyle(fontSize: fontSize),
      autofocus: autoFocus ?? false,
      decoration: InputDecoration(
        isDense: true,
        prefixText: prefixText,
        suffix: suffixIcone,
        hintText: hintText,
        hintStyle: TextStyle(color: context.theme.graycolor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: coloors.greendark),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: coloors.greendark, width: 2),
        ),
      ),
    );
  }
}
