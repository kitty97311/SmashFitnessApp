class WorkoutClass {
  String? success;
  String? message;
  List<Workout>? data;

  WorkoutClass(this.success, this.message, this.data);

  WorkoutClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Workout>[];
      json['data'].forEach((v) {
        data!.add(new Workout.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Workout {
  int? id;
  int? sub_smash_id;
  int? sub_smashplus_id;
  String? img;
  String? name;
  String? level;
  int? time;

  Workout(
      this.id, this.sub_smash_id, this.img, this.name, this.level, this.time);

  Workout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sub_smash_id = json['sub_smash_id'];
    sub_smashplus_id = json['sub_smashplus_id'];
    img = json['img'];
    name = json['name'];
    level = json['level'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_smash_id'] = this.sub_smash_id;
    data['sub_smashplus_id'] = this.sub_smashplus_id;
    data['img'] = this.img;
    data['name'] = this.name;
    data['level'] = this.level;
    data['time'] = this.time;
    return data;
  }
}
