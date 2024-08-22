import 'package:hive/hive.dart';

part 'ExtraClass.g.dart';

@HiveType(typeId: 300)
class Extra {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? image;
  @HiveField(3)
  int? sort;
  @HiveField(4)
  int? interval;
  @HiveField(5)
  bool? superset;
  @HiveField(6)
  List? set;

  Extra(this.id, this.name, this.image, this.sort, this.interval, this.superset,
      this.set);

  Extra.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    sort = json['sort'];
    interval = json['interval'];
    superset = json['superset'];
    set = json['set'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['sort'] = this.sort;
    data['interval'] = this.interval;
    data['superset'] = this.superset;
    data['set'] = this.set;
    return data;
  }
}
