import 'package:hive/hive.dart';

import '../Modals/AllWorkoutsClass.dart';
// import '../Modals/ExtraClass.dart';

part 'CustomWorkoutsClass.g.dart';

late Box<WorkOut> workoutBox;

@HiveType(typeId: 178)
class WorkOut {
  @HiveField(0)
  String totalTime;
  @HiveField(1)
  String totalCal;
  @HiveField(2)
  String intervelTime;
  @HiveField(3)
  String retpeatWorkOut;
  @HiveField(4)
  String name;
  @HiveField(5)
  List<Create> list;
  @HiveField(6)
  List extraList;

  WorkOut(
      {required this.list,
      required this.extraList,
      required this.intervelTime,
      required this.retpeatWorkOut,
      required this.totalCal,
      required this.totalTime,
      required this.name});
}
