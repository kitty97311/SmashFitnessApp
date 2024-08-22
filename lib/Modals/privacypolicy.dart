class PrivacyPolicy {
  String? success;
  String? message;
  About? about;

  PrivacyPolicy({required this.success, required this.message, required this.about});

  PrivacyPolicy.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    about = json['about'] != null ? new About.fromJson(json['about']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.about != null) {
      data['about'] = this.about?.toJson();
    }
    return data;
  }
}

class About {
  int? id;
  String? tremsCondi;
  String? createdAt;
  String? updatedAt;

  About({this.id, this.tremsCondi, this.createdAt, this.updatedAt});

  About.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tremsCondi = json['trems_condi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trems_condi'] = this.tremsCondi;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}