import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'TrackerClass.g.dart';

@HiveType(typeId: 102)
class TrackerClass {
  @HiveField(0)
  String? date;
  @HiveField(1)
  String? cups;
  @HiveField(2)
  String? drink;
  @HiveField(3)
  String? steps;
  @HiveField(4)
  String? walk;

  TrackerClass();

  TrackerClass.constructor(
      this.date, this.cups, this.drink, this.steps, this.walk);

  addWater(
      {DateTime? dateTime,
      String? cups,
      String? drink,
      BuildContext? context}) async {
    await Hive.openBox("tracker").then((value) {
      final data = value.get(dateTime.toString().substring(0, 10));
      if (data == null) {
        print("Data added for first time");
        value
            .put(
                dateTime.toString().substring(0, 10),
                (TrackerClass.constructor(dateTime.toString().substring(0, 10),
                    cups!, drink!, "0", "0")))
            .then((value) {
          print("Data Added Successfully");
        }).catchError((e) {
          print(e.toString());
        });
      } else {
        value
            .put(
                dateTime.toString().substring(0, 10),
                (TrackerClass.constructor(
                    data.date, cups, drink, data.steps, data.walk)))
            .then((value) {
          print("Data Updated Successfully");
        });
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  addStep(
      {DateTime? dateTime,
      String? steps,
      String? walk,
      BuildContext? context}) async {
    await Hive.openBox("tracker").then((value) {
      final data = value.get(dateTime.toString().substring(0, 10));
      if (data == null) {
        print("Data added for first time");
        value
            .put(
                dateTime.toString().substring(0, 10),
                (TrackerClass.constructor(dateTime.toString().substring(0, 10),
                    "0", "0", steps, walk)))
            .then((value) {
          print("Data Added Successfully");
        }).catchError((e) {
          print(e.toString());
        });
      } else {
        value
            .put(
                dateTime.toString().substring(0, 10),
                (TrackerClass.constructor(
                    data.date, data.cups, data.drink, steps, walk)))
            .then((value) {
          print("Data Updated Successfully");
        });
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<List<TrackerClass>> readData({DateTime? dateTime}) async {
    List<TrackerClass> list = [];
    await Hive.openBox("tracker").then((value) {
      final data = value.get(dateTime.toString().substring(0, 10));
      if (data != null) {
        list.add(TrackerClass.constructor(
            data.date, data.cups, data.drink, data.steps, data.walk));
      } else {
        list.add(TrackerClass.constructor("0", "0", "0", "0", "0"));
      }
    }).catchError((e) {
      print(e.toString());
    });
    return list;
  }

  Future<List<TrackerClass>> readAllData() async {
    List<TrackerClass> list = [];
    await Hive.openBox("tracker").then((value) {
      for (int i = 0; i < value.length; i++) {
        final data = value.getAt(i);
        if (data != null) {
          list.add(TrackerClass.constructor(
              data.date, data.cups, data.drink, data.steps, data.walk));
        } else {
          list.add(TrackerClass.constructor("0", "0", "0", "0", "0"));
        }
      }
    }).catchError((e) {
      print(e.toString());
    });
    return list;
  }

  clearData() async {
    final box = await Hive.openBox("tracker");
    box.clear();
  }
}
