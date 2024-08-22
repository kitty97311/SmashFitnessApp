import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:toast/toast.dart';
part 'ProgressClass.g.dart';

@HiveType(typeId: 1)
class ProgressClass {
  @HiveField(0)
  String? calories;
  @HiveField(1)
  String? workOuts;
  @HiveField(2)
  String? seconds;

  ProgressClass();

  ProgressClass.constructor(this.calories, this.workOuts, this.seconds);

  addData(
      {String? calories,
      String? workOuts,
      String? seconds,
      BuildContext? context}) async {
    DateTime dateTime = DateTime.now();

    print(DateTime.now().toString().substring(0, 10));
    await Hive.openBox("${dateTime.toString().substring(0, 10)}").then((value) {
      final data = value.get(dateTime.hour.toString());
      if (data == null) {
        print("Data added for first time");
        value
            .put(dateTime.hour.toString(),
                (ProgressClass.constructor(calories!, workOuts!, seconds!)))
            .then((value) {
          print("Data Added Successfully");
        });
      } else {
        print(data.calories);
        int cal = int.parse(data.calories) + int.parse(calories!);
        int min = int.parse(data.seconds) + int.parse(seconds!);
        int totalWorkout = int.parse(data.workOuts) + int.parse(workOuts!);
        value
            .put(
                dateTime.hour.toString(),
                (ProgressClass.constructor(
                    cal.toString(), totalWorkout.toString(), min.toString())))
            .then((value) {
          print("Data Added Successfully");
          //Toast.show("Data Added : ${data.calories}", context, duration: 3);
        });
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<List<ProgressClass>> readData({DateTime? dateTime}) async {
    List<ProgressClass> list = [];
    print('line no 55 ${DateTime.now().toString().substring(0, 10)}');
    print('line no 56 ${DateTime.now().hour.toString()}');
    await Hive.openBox("${dateTime.toString().substring(0, 10)}").then((value) {
      print('value == ${value.length}');
      for (int i = 0; i < 24; i++) {
        final data = value.get(i.toString());
        if (data != null) {
          print(data.calories);
          list.add(ProgressClass.constructor(
              data.calories, data.workOuts, data.seconds));
        } else {
          list.add(ProgressClass.constructor("0", "0", "0"));
        }
      }
    }).catchError((e) {
      print(e.toString());
    });
    return list;
  }

  clearData({String? date}) async {
    final box = await Hive.openBox(date!);
    box.clear();
  }
}
