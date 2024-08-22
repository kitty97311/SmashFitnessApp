class HomeClass {
  String? success;
  String? message;
  List<HomeSection>? data;

  HomeClass(this.success, this.message, this.data);

  HomeClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HomeSection>[];
      json['data'].forEach((v) {
        data!.add(new HomeSection.fromJson(v));
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

class HomeSection {
  int? id;
  String? category;
  List? list;

  HomeSection(this.id, this.category, this.list);

  HomeSection.fromJson(Map<String, dynamic> json) {
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
