class AboutUsClass {
  String? success;
  String? message;
  About? about;

  AboutUsClass({this.success, this.message, this.about});

  AboutUsClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    about = json['about'] != null ? new About.fromJson(json['about']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.about != null) {
      data['about'] = this.about!.toJson();
    }
    return data;
  }
}

class About {
  int? id;
  String? aboutUs;
  String? createdAt;
  String? updatedAt;

  About({required this.id, required this.aboutUs, required this.createdAt, required this.updatedAt});

  About.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aboutUs = json['about_us'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['about_us'] = this.aboutUs;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}