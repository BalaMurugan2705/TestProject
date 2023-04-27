import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class TextFieldButton extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? inputType;
  Function(String)? onChange;
  String? Function(String?)? validate;
  String labelText;
  double? fontsize;
  double? borderRadius;
  Color? color;
  int ? maxLines;
  Color? enableColor;
  FontWeight? fontweight;
  bool? obscure;
  Color? textFontColor;
  String? textFontFamily;
  String? labelFontFamily;
  double? textFontSize;
  FontWeight? textFontWeight;
  Widget? suffix;
  Function()? onTap;
  List<TextInputFormatter>? inputFormat;
  FloatingLabelBehavior? floating;
  FocusNode? focusNode;
  TextFieldButton(
      {Key? key,
        this.suffix,
        this.inputFormat,
        this.enableColor,
        this.textFontColor,
        this.textFontFamily,
        this.textFontSize,
        this.textFontWeight,
        this.borderRadius,
        this.fontweight,
        this.fontsize,
        this.labelText = "",
        this.controller,
        this.onChange,
        this.inputType,
        this.validate,
        this.color,
        this.obscure,
        this.maxLines,
        this.labelFontFamily,
        this.onTap,
        this.floating = FloatingLabelBehavior.auto,
        this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      inputFormatters: inputFormat,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChange,
      keyboardType: inputType,
      validator: validate,
      maxLines: maxLines,
      style: const TextStyle(
          fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
      cursorColor:Colors.black,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          labelText: labelText,
          suffix: suffix,
          labelStyle: TextStyle(
              fontWeight: fontweight,
              fontSize: fontsize ?? 16,
              color: color ?? Colors.black),
          floatingLabelBehavior: floating),
    );
  }
}