import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

String moneyChanger(double value, {String? customLabel}) {
  return NumberFormat.currency(
          name: customLabel ?? 'Rp', decimalDigits: 0, locale: 'id')
      .format(value.round());
}

void showSnackbar(BuildContext context,
    {required String title, Color? customColor}) {
  final snack = SnackBar(
    content: Text(
      title,
      style: TextStyle(fontSize: 12.0, color: Colors.white),
    ),
    backgroundColor: customColor ?? Theme.of(context).primaryColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}

class CustomButton extends StatefulWidget {
  final double? minWidth;
  final VoidCallback onTap;
  final bool pressAble;
  final Widget? trailing;
  final String text;
  final EdgeInsetsGeometry? padding;
  final LinearGradient? gradient;
  const CustomButton(
      {Key? key,
      this.minWidth,
      required this.onTap,
      this.trailing,
      required this.text,
      required this.pressAble,
      this.padding,
      this.gradient})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  var duration = Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      decoration: BoxDecoration(
          gradient: !widget.pressAble
              ? LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.6),
                    Colors.grey.withOpacity(0.6)
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp,
                )
              : widget.gradient ??
                  LinearGradient(
                    colors: [Colors.blue, Colors.lightBlue],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
          borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: InkWell(
          onTap: widget.pressAble ? widget.onTap : () {},
          splashColor: !widget.pressAble
              ? Colors.transparent
              : Colors.white.withOpacity(0.3),
          highlightColor: !widget.pressAble
              ? Colors.transparent
              : Colors.white.withOpacity(0.3),
          child: Container(
              constraints: BoxConstraints(minWidth: widget.minWidth ?? 0),
              padding: widget.padding ??
                  EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: !widget.pressAble
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: widget.trailing ?? SizedBox(),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final void Function(String?)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final String borderType;
  final TextInputFormatter? inputFormatter;
  final double? verticalPadding;
  final int? maxLines;
  final Color? fillColor;
  final Color? hintTextColor;
  final Widget? suffixIcon;
  final bool isError;
  final FocusNode? focus;
  final bool enabled;

  const InputField({
    Key? key,
    this.hintText,
    required this.controller,
    this.focus,
    required this.onChanged,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.borderType = "none",
    this.inputFormatter,
    this.verticalPadding,
    this.maxLines,
    this.fillColor,
    this.hintTextColor,
    this.suffixIcon,
    this.isError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      focusNode: focus,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: (maxLines != null) ? maxLines : 1,
      textAlignVertical: TextAlignVertical.center,
      onChanged: onChanged,
      inputFormatters: (inputFormatter != null) ? [inputFormatter!] : null,
      style: TextStyle(
        fontSize: 12,
      ),
      decoration: InputDecoration(
        filled: true,
        errorStyle: TextStyle(fontSize: 12, color: Colors.red),
        isCollapsed: true,
        fillColor: fillColor ?? Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12,
          color: hintTextColor ?? Colors.grey,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: verticalPadding ?? 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: borderType == "none"
              ? BorderSide.none
              : BorderSide(
                  color:
                      isError ? Colors.red : Colors.black87.withOpacity(0.75),
                  width: 1,
                ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: borderType == "none"
              ? BorderSide.none
              : BorderSide(
                  color:
                      isError ? Colors.red : Colors.black87.withOpacity(0.75),
                  width: 1,
                ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

Future<bool> yesOrNoDialog(BuildContext context,
    {required String title,
    required String desc,
    String? customYesTitle,
    String? customNoTitle}) async {
  bool returnValue = false;

  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            elevation: 2,
            backgroundColor: Colors.white,
            child: Container(
                constraints: BoxConstraints(maxWidth: 500),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 2.0),
                        child: Text(title,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87))),
                    SizedBox(
                      height: 10,
                    ),
                    Text(desc,
                        maxLines: 5,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 14.0, color: Colors.black87)),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Flexible(
                            flex: 10,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 0.5, color: Colors.blue)),
                                  alignment: Alignment.center,
                                  child: Text(customNoTitle ?? 'Tidak',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold))),
                            )),
                        Flexible(
                            flex: 1, child: SizedBox(width: double.infinity)),
                        Flexible(
                            flex: 10,
                            child: InkWell(
                              onTap: () {
                                returnValue = true;
                                Navigator.pop(context);
                              },
                              child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.blue),
                                  alignment: Alignment.center,
                                  child: Text(customYesTitle ?? 'Ya',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                            ))
                      ],
                    )
                  ],
                )));
      });

  return returnValue;
}

Future<String> reasonDialog(BuildContext context,
    {required String title,
    required String desc,
    String? customYesTitle,
    String? customNoTitle}) async {
  bool returnValue = false;
  String alasanController = '';
  TextEditingController controller = TextEditingController();

  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, state) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 2,
              backgroundColor: Colors.white,
              child: Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 2.0),
                          child: Text('Alasan Pembatalan',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87))),
                      SizedBox(
                        height: 10,
                      ),
                      InputField(
                          controller: controller,
                          borderType: 'border',
                          hintText: 'Alasan',
                          onChanged: (value) {
                            alasanController = value!;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Flexible(
                              flex: 10,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 0.5, color: Colors.blue)),
                                    alignment: Alignment.center,
                                    child: Text(customNoTitle ?? 'Batal',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold))),
                              )),
                          Flexible(
                              flex: 1, child: SizedBox(width: double.infinity)),
                          Flexible(
                              flex: 10,
                              child: InkWell(
                                onTap: () {
                                  returnValue = true;
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.blue),
                                    alignment: Alignment.center,
                                    child: Text(customYesTitle ?? 'Konfirmasi',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ))
                        ],
                      )
                    ],
                  )));
        });
      });

  return returnValue ? alasanController : '';
}
