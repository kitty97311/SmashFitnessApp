class SmashClass {
  String? success;
  String? message;
  List<Smash>? data;

  SmashClass(this.success, this.message, this.data);

  SmashClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['smash']['create'] != null) {
      data = <Smash>[];
      json['smash']['create'].forEach((v) {
        data!.add(new Smash.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['smash'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Smash {
  int? id;
  String? name;

  Smash(this.id, this.name);

  Smash.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
