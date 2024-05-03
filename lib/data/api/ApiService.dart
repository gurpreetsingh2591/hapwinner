import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../utils/constant.dart';
import 'api_constants.dart';

class ApiService {


  /// Login*/
  Future<dynamic> getUserLogin(
      String email, String password, String token) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiLogin);

      var request = http.MultipartRequest('POST', url);
      if (kDebugMode) {
        print(email + password);
      }

      request.fields.addAll({
        ApiConstants.EMAIL: email,
        ApiConstants.PASSWORD: password,
       // ApiConstants.fcmToken: token
      });

      if (kDebugMode) {
        print(request.fields);
      }
      //http.StreamedResponse response = await request.send();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Forgot Password*/
  Future<dynamic> getStudentLunchMenu(String studentId) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.API_GET_LUNCH_MENU);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.STUDENT_ID: studentId,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Forgot Password*/
  Future<dynamic> getStudentSnackMenu(String studentId) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.API_GET_SNACK_MENU);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.STUDENT_ID: studentId,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Forgot Password*/
  Future<dynamic> getSchoolMessages(String studentId) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.API_GET_MESSAGESFROMSCHOOL);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.STUDENT_ID: studentId,
      });

      if (kDebugMode) {
        print(request.fields);
        print(url);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Forgot Password*/
  Future<dynamic> getTeacherMessages(String studentId) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.API_GET_MESSAGESFROMTEACHER);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.STUDENT_ID: studentId,
      });

      if (kDebugMode) {
        print(request.fields);
        print(url);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Forgot Password*/
  Future<dynamic> postSendMessagesToOffice(
      String studentId, String sub, String msg) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.API_GET_MESSAGE_TO_OFFICE_DATA);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.STUDENT_ID: studentId,
        ApiConstants.SUB: sub,
        ApiConstants.MSG: msg,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Forgot Password*/
  Future<dynamic> getSentMessagesToOfficeList(String studentId) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.API_GET_MESSAGE_SENT_TO_OFFICE_LIST);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.STUDENT_ID: studentId,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Forgot Password*/
  Future<dynamic> postSendMessagesToTeacher(
      String studentId, String sub, String msg) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.API_GET_MESSAGE_TO_TEACHER_DATA);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.STUDENT_ID: studentId,
        ApiConstants.SUB: sub,
        ApiConstants.MSG: msg,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Forgot Password*/
  Future<dynamic> getSentMessagesToTeacherList(String studentId) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.API_GET_MESSAGE_SENT_TO_TEACHER_LIST);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.STUDENT_ID: studentId,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Teacher Time Slots*/
  Future<dynamic> getTeacherTimeSlotListWithDate(
      String studentId, String date) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.API_GET_TEACHER_TIME_SLOTS);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.STUDENT_ID: studentId,
        ApiConstants.DATE: date,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print("time slots${response.body}");
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Book Teacher Time Slots*/
  Future<dynamic> getTeacherBookTimeSlot(
      String studentId, String date, String time) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.API_GET_TEACHER_BOOK_MEETING);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.STUDENT_ID: studentId,
        ApiConstants.MEETING_DATE: date,
        ApiConstants.VCH_MEETING_TIME: time,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print("book meeting${response.body}");
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get Booked Teacher Time Slots List*/
  Future<dynamic> getTeacherBookedSlotList(
    String studentId,
  ) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.API_GET_TEACHER_MEETING_LIST);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.STUDENT_ID: studentId,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print("booking list${response.body}");
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get Delete Booked Teacher Time Slots List*/
  Future<dynamic> getTeacherDeleteBookedSlot(
    String meetId,
  ) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.API_GET_DELETE_MEETING_WITH_TEACHER);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.MEET_ID: meetId,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print("booking delete--${response.body}");
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get Delete Booked office Time Slots List*/
  Future<dynamic> getOfficeDeleteBookedSlot(
    String meetId,
  ) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.API_GET_DELETE_MEETING);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.MEET_ID: meetId,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print("office booking delete${response.body}");
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Office Time Slots*/
  Future<dynamic> getOfficeTimeSlotListWithDate(
      String studentId, String date) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.API_GET_OFFICE_TIME_SLOTS);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.STUDENT_ID: studentId,
        ApiConstants.DATE: date,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Office Time Slots*/
  Future<dynamic> getOfficeBookTimeSlot(
      String parentId, String date, String time) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.API_GET_OFFICE_BOOK_MEETING);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.P_ID: parentId,
        ApiConstants.MEETING_DATE: date,
        ApiConstants.VCH_MEETING_TIME: time,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get Booked Office Time Slots*/
  Future<dynamic> getOfficeBookedTimeSlotsList(
      String studentId, String parentId) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.API_GET_OFFICE_MEETING_LIST);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.STUDENT_ID: studentId,
        ApiConstants.P_ID: parentId,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get subject list*/
  Future<dynamic> getSubjectListList(String studentId, String classId) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.API_GET_SUBJECT_LIST);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.studentId: studentId,
        ApiConstants.classId: classId,
      });

      if (kDebugMode) {
        print(request.fields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get Lesson Record list*/
  Future<dynamic> getLessonRecordList(
      String studentId, String subjectId) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.API_GET_LESSON_RECORD +
          ApiConstants.studentId +
          studentId +
          ApiConstants.subjectId +
          subjectId);
      var request = http.Request('GET', url);
      request.body = '''''';
      //var request = http.StreamedRequest('GET', url);

      if (kDebugMode) {
        print(url);
      }
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print("url$url");
        print(request);
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get Reminder  list*/
  Future<dynamic> getReminderList() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.API_GET_PARENT_REMINDER);
      var request = http.Request('GET', url);
      request.body = '''''';
      //var request = http.StreamedRequest('GET', url);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print("url$url");
        print(request);
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Set Reminder*/
  Future<dynamic> setReminders(String studentId, String days) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.API_SET_PARENT_REMINDER +
          studentId +
          ApiConstants.dayS +
          days);
      var request = http.Request('GET', url);
      request.body = '''''';
      //var request = http.StreamedRequest('GET', url);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print("url$url");
        print(request);
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Set Already Reminder*/
  Future<dynamic> alreadySetReminders(String studentId, String days) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.API_SET_ALREADY_PARENT_REMINDER +
          studentId);
      var request = http.Request('GET', url);
      request.body = '''''';
      //var request = http.StreamedRequest('GET', url);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print("url$url");
        print(request);
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get Event Dates*/
  Future<dynamic> getTestimonialsVideos(String token) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiTestimonials);
      var request = http.Request('GET', url);
      request.body = '''''';
      //var request = http.StreamedRequest('GET', url);


      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'application/json';
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print("url$url");
        print(request);
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get Student Photos */
  Future<dynamic> getStudentPhotosDates(String studentId,int index) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.API_SET_STUDENT_PHOTOS}$studentId&index=$index");
      var request = http.Request('GET', url);
      request.body = '''''';
      //var request = http.StreamedRequest('GET', url);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print("url$url");
        print(request);
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get delete user */
  Future<dynamic> getDeleteUserData(String parentId) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.API_GET_DELETE_USER}$parentId");
      var request = http.Request('GET', url);
      request.body = '''''';
      //var request = http.StreamedRequest('GET', url);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print("url$url");
        print(request);
        print(response.statusCode);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get profile  Data*/
  Future<dynamic> getUserProfileData(String parentId) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.API_GET_PARENT_PROFILE);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.PARENT_ID: parentId,
      });

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(request.fields);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get update profile  Data*/
  Future<dynamic> getUserUpdateProfileData(
      String parentId, Map<String, String> updateData) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.API_GET_UPDATE_PARENT_PROFILE);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.PARENT_ID: parentId,
      });
      updateData.forEach((key, value) {
        request.fields[key] = value;
      });

      //final response = await http.post(url, body: updateData);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(request.fields);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ///get change password
  Future<dynamic> getUserChangePasswordData(String parentId, String oldPassword,
      String newPassword, String confirmPassword) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.API_GET_CHANGE_PASSWORD);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.PARENT_ID: parentId,
        ApiConstants.vchOldPassword: oldPassword,
        ApiConstants.vchNewPassword: newPassword,
        ApiConstants.vchNewRetypePassword: confirmPassword,
      });

      //final response = await http.post(url, body: updateData);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(request.fields);
        print(response.body);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
