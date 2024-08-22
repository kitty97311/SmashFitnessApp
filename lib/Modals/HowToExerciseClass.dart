class HowToExerciseClass {
  String? success;
  Exercise? exercise;

  HowToExerciseClass(this.success, this.exercise);

  HowToExerciseClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    exercise = json['exercise'] != null
        ? new Exercise.fromJson(json['exercise'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.exercise != null) {
      data['exercise'] = this.exercise!.toJson();
    }
    return data;
  }
}

class Exercise {
  String? url;
  List<Step>? step;

  Exercise(this.url, this.step);

  Exercise.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    if (json['step'] != null) {
      step = [];
      json['step'].forEach((v) {
        step!.add(new Step.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    if (this.step != null) {
      data['step'] = this.step!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Step {
  dynamic id;
  String? step;

  Step(this.id, this.step);

  Step.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    step = json['step'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['step'] = this.step;
    return data;
  }
}
