class SubSmashPlusClass {
  String? success;
  String? message;
  List<SubSmashPlus>? data;

  SubSmashPlusClass(this.success, this.message, this.data);

  SubSmashPlusClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['sub_smash']['create'] != null) {
      data = <SubSmashPlus>[];
      json['sub_smash']['create'].forEach((v) {
        data!.add(new SubSmashPlus.fromJson(v));
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

class SubSmashPlus {
  int? id;
  int? smash_id;
  String? img;
  String? name;
  String? caption;
  int? level_id;
  int? period;

  SubSmashPlus(this.id, this.smash_id, this.img, this.name, this.caption,
      this.level_id, this.period);

  SubSmashPlus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    smash_id = json['smashplus_id'];
    img = json['img'];
    name = json['name'];
    caption = json['caption'];
    level_id = json['level_id'];
    period = json['period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['smash_id'] = this.smash_id;
    data['img'] = this.img;
    data['name'] = this.name;
    data['caption'] = this.caption;
    data['level_id'] = this.level_id;
    data['period'] = this.period;
    return data;
  }
}
