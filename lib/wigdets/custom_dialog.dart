import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDialog {
  static Future<bool> yesOrNoDialog(BuildContext context,
      {required String title,
      required String desc,
      String? customYesTitle,
      String? customNoTitle}) async {
    bool returnValue = false;

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              alignment: Alignment.center,
              child: Container(
                  padding: EdgeInsets.all(20),
                  width: 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(desc,
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 13, color: Colors.black87)),
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
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    alignment: Alignment.center,
                                    child: Text(customNoTitle ?? 'Tidak',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold))),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                              flex: 10,
                              child: InkWell(
                                onTap: () {
                                  returnValue = true;
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Theme.of(context).primaryColor),
                                    alignment: Alignment.center,
                                    child: Text(customYesTitle ?? 'Ya',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ))
                        ],
                      )
                    ],
                  )),
            ),
          );
        });

    return returnValue;
  }
}
