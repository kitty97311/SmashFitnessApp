import 'package:flutter/material.dart';

import '../Themes.dart';
import '../main.dart';

class CustomSettingsListTile {
  Widget tile({String? icon, String? title, Widget? widget}) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration:
            BoxDecoration(color: GRAY, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Image.asset(
                    "assets/setting/$icon.png",
                    height: ipad ? 30 : 23,
                    width: ipad ? 30 : 23,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  t.mediumText(text: title, size: ipad ? 30 : 16, color: WHITE),
                ],
              ),
            ),
            widget!,
            SizedBox(width: 20),
          ],
        ));
  }

  Widget iconTile({required String icon, String? title, Widget? widget}) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration:
            BoxDecoration(color: GRAY, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Image.asset(
                    icon,
                    height: ipad ? 30 : 23,
                    width: ipad ? 30 : 23,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  t.mediumText(text: title, size: ipad ? 30 : 16, color: WHITE),
                ],
              ),
            ),
            widget!,
            SizedBox(width: 20),
          ],
        ));
  }
}
