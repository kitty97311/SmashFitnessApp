class SmashPlusClass {
  String? success;
  String? message;
  List<SmashPlusSection>? data;

  SmashPlusClass(this.success, this.message, this.data);

  SmashPlusClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SmashPlusSection>[];
      json['data'].forEach((v) {
        data!.add(new SmashPlusSection.fromJson(v));
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

class SmashPlusSection {
  int? id;
  String? category;
  List? list;

  SmashPlusSection(this.id, this.category, this.list);

  SmashPlusSection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    list = json['list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['list'] = this.list;
    return data;
  }
}
