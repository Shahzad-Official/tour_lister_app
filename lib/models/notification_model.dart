class NotificationModel {
  String? tourId;
  String? userId;
  String? id;
  String? message;
  String? status;

  NotificationModel(
      {this.tourId, this.userId, this.id, this.message, this.status});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    tourId = json['tour_id'];
    userId = json['user_id'];
    id = json['id'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['tour_id'] = tourId;
    data['user_id'] = userId;
    data['id'] = id;
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
