class SubSmashClass {
  String? success;
  String? message;
  List<SubSmash>? data;

  SubSmashClass(this.success, this.message, this.data);

  SubSmashClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['sub_smash']['create'] != null) {
      data = <SubSmash>[];
      json['sub_smash']['create'].forEach((v) {
        data!.add(new SubSmash.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['sub_smash'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubSmash {
  int? id;
  int? smash_id;
  String? img;
  String? name;
  int? level_id;
  int? period;

  SubSmash(
      this.id, this.smash_id, this.img, this.name, this.level_id, this.period);

  SubSmash.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    smash_id = json['smash_id'];
    img = json['img'];
    name = json['name'];
    level_id = json['level_id'];
    period = json['period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['smash_id'] = this.smash_id;
    data['img'] = this.img;
    data['name'] = this.name;
    data['level_id'] = this.level_id;
    data['period'] = this.period;
    return data;
  }
}
