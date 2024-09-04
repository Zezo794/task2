import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:task2/shared/component/style.dart';

Widget defaultbutton({
  double width = double.infinity,
  Color background = Colors.blue,
  @required String? text,
  @required VoidCallback? function,
}) {
  return Container(
    width: width,
    color: background,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        "$text",
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget defaultTextForm({
  @required TextEditingController? textEditingController,
  @required TextInputType? type,
  bool obscureText = false,
  @required void Function(String? m)? onsubmit,
  void Function(String? m)? onchanged,
  void Function()? ontap,
  void Function()? suffux,
  @required String? text,
  @required IconData? prefix,
  IconData? suffix,
  @required String? Function(String? m)? validate,
  int? maxlength,
}) {
  return TextFormField(
    validator: validate,
    controller: textEditingController,
    keyboardType: type,
    obscureText: obscureText,
    onTap: ontap,
    onChanged: onchanged,
    maxLength: maxlength,
    onFieldSubmitted: onsubmit,
    decoration: InputDecoration(
      labelText: "${text}",
      counterText: "",
      border: const OutlineInputBorder(),
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(onPressed: suffux, icon: Icon(suffix))
          : null,
    ),
  );
}

void showSnackBar({
  required BuildContext context,
  required String text,
  required Color color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: color,
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

void NavigateTo(context, Widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Widget;
  }));
}

void NavigateToFinsh(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}



enum ToastStates { Sucsess, Erorr, Warning }

Color choseColor(ToastStates state1) {
  Color color;
  switch (state1) {
    case ToastStates.Sucsess:
      color = Colors.green;
      break;

    case ToastStates.Erorr:
      color = Colors.red;
      break;

    case ToastStates.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildProfileItem(
    {@required title, required Widget shape, @required function}) =>
    Expanded(
      child: GestureDetector(
        onTap: function,
        child: Container(
          height: 140.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15.0,
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 10,
                blurRadius: 15,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30.0,
                child: shape,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                title.toString(),
                style: black16Bold(),
              ),
            ],
          ),
        ),
      ),
    );
