import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'HabitClass.g.dart';

@HiveType(typeId: 101)
class HabitClass {
  @HiveField(0)
  String? startDate;
  @HiveField(1)
  String? days;
  @HiveField(2)
  String? completed;
  @HiveField(3)
  String? id;

  HabitClass();

  HabitClass.constructor(this.startDate, this.days, this.completed, this.id);

  addData(
      {String? startDate,
      String? days,
      String? completed,
      String? id,
      int? index,
      BuildContext? context}) async {
    await Hive.openBox("habit").then((value) {
      print(index);
      final data = value.get(index.toString());
      if (data == null) {
        print("Data added for first time");
        value
            .put(index.toString(),
                (HabitClass.constructor(startDate!, days!, completed!, id!)))
            .then((value) {
          print("Data Added Successfully");
        }).catchError((e) {
          print(e.toString());
        });
      } else {
        int done = int.parse(data.completed) + 1;
        value
            .put(
                index.toString(),
                (HabitClass.constructor(
                    data.startDate, data.days, done.toString(), data.id)))
            .then((value) {
          print("Data Updated Successfully");
        });
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<List<HabitClass>> readData() async {
    List<HabitClass> list = [];
    await Hive.openBox("habit").then((value) {
      for (int i = 0; i < value.length; i++) {
        final data = value.get(i.toString());
        if (data != null) {
          list.add(HabitClass.constructor(
              data.startDate, data.days, data.completed, data.id));
        } else {
          list.add(HabitClass.constructor("0", "0", "0", "0"));
        }
      }
    }).catchError((e) {
      print(e.toString());
    });
    return list;
  }

  clearData() async {
    final box = await Hive.openBox("habit");
    box.clear();
  }
}
