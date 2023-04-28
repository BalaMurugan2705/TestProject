
import 'package:flutter/material.dart';

import '../helper/utils.dart';

Widget customButton({String? buttonTitle,Function()? onTap,IconData? icon}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: icon!=null,
              child: Icon(icon,color: Colors.white,),),


          Text(
            buttonTitle??"",
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customContainer(String txt,
    {int size = 11,   Color? color , EdgeInsets? padding}) {
  return Row(
    children: [
      Container(
        padding: padding ?? EdgeInsets.symmetric(horizontal: (color==null)? 0: 8, vertical: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color ?? Colors.transparent),
        child: Text(
          txt,
          style: TextStyle(fontSize: size.toDouble()),
        ),
      ),
    ],
  );
}
customToast({required ToastStatusEnum status, required String message,required BuildContext context}) {
  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    duration: const Duration(seconds: 2),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Material(
            borderRadius: BorderRadius.circular(15),
            color: status == ToastStatusEnum.success
                ? Colors.green
                : status == ToastStatusEnum.warning
                ? Colors.orange
                : status == ToastStatusEnum.error
                ? Colors.red
                : Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 5, bottom: 5, right: 5),
              child: Text(
                message.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}