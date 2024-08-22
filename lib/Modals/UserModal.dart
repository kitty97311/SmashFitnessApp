class UserModal {
  Data? data;

  UserModal(this.data);

  UserModal.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? success;
  Register? register;

  Data(this.success, this.register);

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    register = json['register'] != null
        ? new Register.fromJson(json['register'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.register != null) {
      data['register'] = this.register!.toJson();
    }
    return data;
  }
}

class Register {
  String? id;
  String? name;
  String? phone;
  String? gender;
  String? workoutIntensity;
  String? age;
  String? height;
  String? exerciseDays;
  String? createAt;

  Register(
      this.id,
        this.name,
        this.phone,
        this.gender,
        this.workoutIntensity,
        this.age,
        this.height,
        this.exerciseDays,
        this.createAt);

  Register.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    gender = json['gender'];
    workoutIntensity = json['workout_intensity'];
    age = json['age'];
    height = json['height'];
    exerciseDays = json['exercise_days'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['workout_intensity'] = this.workoutIntensity;
    data['age'] = this.age;
    data['height'] = this.height;
    data['exercise_days'] = this.exerciseDays;
    data['create_at'] = this.createAt;
    return data;
  }
}
