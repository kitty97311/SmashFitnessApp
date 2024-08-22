// class HomeScreenClass {
//   String success;
//   List<Exercise> exercise;
//
//   HomeScreenClass({this.success, this.exercise});
//
//   HomeScreenClass.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['exercise'] != null) {
//       exercise = new List<Exercise>();
//       json['exercise'].forEach((v) {
//         exercise.add(new Exercise.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.exercise != null) {
//       data['exercise'] = this.exercise.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Exercise {
//   String id;
//   String name;
//   String image;
//   String totalExercise;
//   int time;
//   int calories;
//   String level;
//   String description;
//
//   Exercise(
//       {this.id,
//         this.name,
//         this.image,
//         this.totalExercise,
//         this.time,
//         this.calories,
//         this.level,
//         this.description});
//
//   Exercise.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     totalExercise = json['total_exercise'];
//     time = json['time'];
//     calories = json['calories'];
//     level = json['level'];
//     description = json['description'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['total_exercise'] = this.totalExercise;
//     data['time'] = this.time;
//     data['calories'] = this.calories;
//     data['level'] = this.level;
//     data['description'] = this.description;
//     return data;
//   }
// }
//
//
// ///-----0
// // class HomeScreenClass {
// //   String success;
// //   String message;
// //   Exercise exercise;
// //
// //   HomeScreenClass({this.success, this.message, this.exercise});
// //
// //   HomeScreenClass.fromJson(Map<String, dynamic> json) {
// //     success = json['success'];
// //     message = json['message'];
// //     exercise = json['exercise'] != null
// //         ? new Exercise.fromJson(json['exercise'])
// //         : null;
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['success'] = this.success;
// //     data['message'] = this.message;
// //     if (this.exercise != null) {
// //       data['exercise'] = this.exercise.toJson();
// //     }
// //     return data;
// //   }
// // }
// //
// // class Exercise {
// //   List<Create> create;
// //   // List<Null> update;
// //   // List<Null> delete;
// //
// //   Exercise({this.create,
// //     // this.update, this.delete
// //   });
// //
// //   Exercise.fromJson(Map<String, dynamic> json) {
// //     if (json['create'] != null) {
// //       create = <Create>[];
// //       json['create'].forEach((v) {
// //         create.add(new Create.fromJson(v));
// //       });
// //     }
// //     // if (json['update'] != null) {
// //     //   update = <Null>[];
// //     //   json['update'].forEach((v) {
// //     //     update.add(new Null.fromJson(v));
// //     //   });
// //     // }
// //     // if (json['delete'] != null) {
// //     //   delete = <Null>[];
// //     //   json['delete'].forEach((v) {
// //     //     delete.add(new Null.fromJson(v));
// //     //   });
// //     // }
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     if (this.create != null) {
// //       data['create'] = this.create.map((v) => v.toJson()).toList();
// //     }
// //     // if (this.update != null) {
// //     //   data['update'] = this.update.map((v) => v.toJson()).toList();
// //     // }
// //     // if (this.delete != null) {
// //     //   data['delete'] = this.delete.map((v) => v.toJson()).toList();
// //     // }
// //     return data;
// //   }
// // }
// //
// // class Create {
// //   int id;
// //   String catIcon;
// //   String catName;
// //   String level;
// //   String description;
// //   String createdAt;
// //   String updatedAt;
// //   String isDeleted;
// //   Null deletedAt;
// //
// //   Create(
// //       {this.id,
// //         this.catIcon,
// //         this.catName,
// //         this.level,
// //         this.description,
// //         this.createdAt,
// //         this.updatedAt,
// //         this.isDeleted,
// //         this.deletedAt});
// //
// //   Create.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     catIcon = json['cat_icon'];
// //     catName = json['cat_name'];
// //     level = json['level'];
// //     description = json['description'];
// //     createdAt = json['created_at'];
// //     updatedAt = json['updated_at'];
// //     isDeleted = json['is_deleted'];
// //     deletedAt = json['deleted_at'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['cat_icon'] = this.catIcon;
// //     data['cat_name'] = this.catName;
// //     data['level'] = this.level;
// //     data['description'] = this.description;
// //     data['created_at'] = this.createdAt;
// //     data['updated_at'] = this.updatedAt;
// //     data['is_deleted'] = this.isDeleted;
// //     data['deleted_at'] = this.deletedAt;
// //     return data;
// //   }
// // }
///----
class HomeScreenClass {
  String? success;
  String? message;
  List<Exercise>? data;

  HomeScreenClass(this.success, this.message, this.data);

  HomeScreenClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Exercise>[];
      json['data'].forEach((v) {
        data!.add(new Exercise.fromJson(v));
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

class Exercise {
  int? id;
  String? name;
  String? image;
  int? totalExercise;
  int? time;
  int? calories;
  String? level;
  String? description;

  Exercise(
      this.id,
        this.name,
        this.image,
        this.totalExercise,
        this.time,
        this.calories,
        this.level,
        this.description);

  Exercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    totalExercise = json['total_exercise'];
    time = json['time'];
    calories = json['calories'];
    level = json['level'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['total_exercise'] = this.totalExercise;
    data['time'] = this.time;
    data['calories'] = this.calories;
    data['level'] = this.level;
    data['description'] = this.description;
    return data;
  }
}