
import 'package:flutter/material.dart';

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