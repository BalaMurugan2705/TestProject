import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class TextFieldButton extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? inputType;
  Function(String)? onChange;
  Function(String)? onEditComplete;
  String? Function(String?)? validate;
  String labelText;
  String? hint;
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
        this.hint,
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
        this.onEditComplete,
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
      onFieldSubmitted: onEditComplete,
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
          contentPadding: EdgeInsets.only(bottom: 12),
          border: InputBorder.none,
          labelText: labelText,
          suffix: suffix,
          hintText:hint ,
          hintStyle: TextStyle(fontSize: 12,
          ),
          alignLabelWithHint: true,
          labelStyle: TextStyle(
              fontWeight: fontweight,
              fontSize: fontsize ?? 16,
              color: color ?? Colors.black),
          floatingLabelBehavior: floating),
    );
  }
}