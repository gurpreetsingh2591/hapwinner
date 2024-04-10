class LunchMenuResponse {
  int? status;
  String? message;
  Result? result;
  String? todaysmeal;

  LunchMenuResponse({required this.status, required this.message, required this.result, required this.todaysmeal});

  LunchMenuResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = (json['result'] != null ? Result.fromJson(json['result']) : null)!;
    todaysmeal = json['todaysmeal'];
  }
}

class Result {
  Map<String, List<MenuItem>>? week1;
  Map<String, List<MenuItem>>? week2;
  Map<String, List<MenuItem>>? week3;
  Map<String, List<MenuItem>>? week4;

  Result({required this.week1, required this.week2, required this.week3, required this.week4});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['Week1'] != null) {
      week1 = <String, List<MenuItem>>{};
      json['Week1'].forEach((key, value) {
        List<MenuItem> items = [];
        for (var item in value) {
          items.add(MenuItem.fromJson(item));
        }
        week1![key] = items;
      });
    }
    if (json['Week2'] != null) {
      week2 = <String, List<MenuItem>>{};
      json['Week2'].forEach((key, value) {
        List<MenuItem> items =  [];
        for (var item in value) {
          items.add(MenuItem.fromJson(item));
        }
        week2![key] = items;
      });
    }
    if (json['Week3'] != null) {
      week3 = <String, List<MenuItem>>{};
      json['Week3'].forEach((key, value) {
        List<MenuItem> items =  [];
        for (var item in value) {
          items.add(MenuItem.fromJson(item));
        }
        week3![key] = items;
      });
    }
    if (json['Week4'] != null) {
      week4 = <String, List<MenuItem>>{};
      json['Week4'].forEach((key, value) {
        List<MenuItem> items = [];
        for (var item in value) {
          items.add(MenuItem.fromJson(item));
        }
        week4![key] = items;
      });
    }
  }
}

class MenuItem {
  String? dayame;
  String? lunchmenu;

  MenuItem({required this.dayame, required this.lunchmenu});

  MenuItem.fromJson(Map<String, dynamic> json) {
    dayame = json['dayame'];
    lunchmenu = json['lunchmenu'];
  }
}
