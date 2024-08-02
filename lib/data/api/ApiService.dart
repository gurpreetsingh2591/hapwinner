import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../utils/constant.dart';
import '../../utils/shared_prefs.dart';
import 'api_constants.dart';

class ApiService {
  /// Login*/
  Future<dynamic> getUserLogin(String email, String password,
      String token) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiLogin);

      var request = http.MultipartRequest('POST', url);
      if (kDebugMode) {
        print(email + password);
      }

      request.fields.addAll({
        ApiConstants.email: email,
        ApiConstants.password: password,
        // ApiConstants.fcmToken: token
      });

      if (kDebugMode) {
        print(request.fields);
      }
      //http.StreamedResponse response = await request.send();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      // if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
      // }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  ///login with otp
  Future<dynamic> getUserLoginWithOtp(String email) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiLoginOtp);

      var request = http.MultipartRequest('POST', url);
      if (kDebugMode) {
        print(email);
      }

      request.fields.addAll({
        ApiConstants.email: email,
      });

      // if (kDebugMode) {
      print(request.fields);
      // }
      //http.StreamedResponse response = await request.send();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      // if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
      // }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  ///login with otp verify
  Future<dynamic> getUserLoginOtpVerify(String userID, String otp,
      String userType) async {
    try {
      var url =
      Uri.parse(ApiConstants.baseUrl + ApiConstants.apiLoginOtpVerify);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.user: userID,
        ApiConstants.otp: otp,
        ApiConstants.userType: userType,
      });

      // if (kDebugMode) {
      print(request.fields);
      // }
      //http.StreamedResponse response = await request.send();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      // if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
      // }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  ///resend otp
  Future<dynamic> getResendOtp(String userID,) async {
    try {
      var url =
      Uri.parse(ApiConstants.baseUrl + ApiConstants.apiResendOtp);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        ApiConstants.user: userID,
      });

      // if (kDebugMode) {
      print(request.fields);
      // }
      //http.StreamedResponse response = await request.send();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      // if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
      // }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        var result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  /// SIGNUP with email*/
  Future<dynamic> getUserSignUp(String email) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiSignUp);

      var request = http.MultipartRequest('POST', url);
      if (kDebugMode) {
        print(email);
      }

      request.fields.addAll({
        ApiConstants.email: email,
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

  /// Contact Us */
  Future<dynamic> getContactUs(String name, String email, String subject,
      String message, String token) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiContact);

      var request = http.MultipartRequest('POST', url);
      if (kDebugMode) {
        print(email);
      }
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'application/json';

      request.fields.addAll({
        ApiConstants.name: name,
        ApiConstants.email: email,
        ApiConstants.subject: subject,
        ApiConstants.message: message,
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


  /// Get Testimonials video*/
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

  ///Home Data
  Future<dynamic> getHomeScreenData(String token) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiHomepage);
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

  ///Contest Detail Data
  Future<dynamic> getContestDetailData(String token) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.apiCurrentContest);
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

    ///privacy Detail Data
    Future<dynamic> getPrivacyData(String token) async {
      try {
        var url = Uri.parse(
            ApiConstants.baseUrl + ApiConstants.apiTermsConditions);
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

    /// Get ticket list*/
    Future<dynamic> getTicketList(String token) async {
      try {
        var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiTicketList);
        var request = http.Request('GET', url);
        request.body = '''''';
        //var request = http.StreamedRequest('GET', url);
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Content-Type'] = 'application/json';
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

    /// Get My Win ticket list*/
    Future<dynamic> getMyWinTicketList(String token) async {
      try {
        var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiMyWinTicket);
        var request = http.Request('GET', url);
        request.body = '''''';
        //var request = http.StreamedRequest('GET', url);
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Content-Type'] = 'application/json';
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

    /// Get My ticket list*/
    Future<dynamic> getMyTicketList(String token) async {
      try {
        var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiMyTicket);
        var request = http.Request('GET', url);
        request.body = '''''';
        //var request = http.StreamedRequest('GET', url);
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Content-Type'] = 'application/json';
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

    /// Get My Past ticket list*/
    Future<dynamic> getMyPastTicketList(String token) async {
      try {
        var url = Uri.parse(
            ApiConstants.baseUrl + ApiConstants.apiMyPastTicket);
        var request = http.Request('GET', url);
        request.body = '''''';
        //var request = http.StreamedRequest('GET', url);
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Content-Type'] = 'application/json';
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

    /// Buy Tickets*/
    Future<dynamic> getBuyTicketsMessages(String userId,
        String lotteryId,
        String ticketNumber,
        String paymentStatus,
        String countryId,
        String amount,
        String transactionType,
        String transactionId,
        String token,) async {
      try {
        var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiBuyTicket);

        var request = http.MultipartRequest('POST', url);
        request.headers['Authorization'] =
        'Bearer $token';

        request.fields.addAll({
          ApiConstants.userId: userId,
          ApiConstants.lotteryId: lotteryId,
          ApiConstants.ticketNumber: ticketNumber,
          ApiConstants.paymentStatus: paymentStatus,
          ApiConstants.countryId: countryId,
          ApiConstants.amount: amount,
          ApiConstants.transactionType: transactionType,
          ApiConstants.transactionId: transactionId,
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

    /// Save profile data*/
    Future<dynamic> getSaveProfile(String name,
        String email,
        String dob,
        String phone,
        String address,
        String city,
        String state,
        String country,
        String pin,
        String token,) async {
      try {
        var url = Uri.parse(
            ApiConstants.baseUrl + ApiConstants.apiProfileUpdate);

        var request = http.MultipartRequest('POST', url);
        request.headers['Authorization'] =
        'Bearer $token';

        request.fields.addAll({
          ApiConstants.name: name,
          ApiConstants.email: email,
          ApiConstants.dob: dob,
          ApiConstants.phoneNumber: phone,
          ApiConstants.address: address,
          ApiConstants.city: city,
          ApiConstants.state: state,
          ApiConstants.country: country,
          ApiConstants.pinCode: pin,
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


    /// Get delete user */
    Future<dynamic> getDeleteUserData(String parentId) async {
      try {
        var url = Uri.parse(
            "${ApiConstants.baseUrl}${ApiConstants.apiLoginOtp}$parentId");
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
    Future<dynamic> getSocialLoginData(String email, String socialId,
        String name) async {
      try {
        var url =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.apiSignupSocial);

        var request = http.MultipartRequest('POST', url);

        request.fields.addAll({
          ApiConstants.mailId: email,
          ApiConstants.socialId: socialId,
          ApiConstants.name: name,
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

    /// Get forgot password  Data*/
    Future<dynamic> getForgotPasswordData(String email) async {
      try {
        var url = Uri.parse(
            ApiConstants.baseUrl + ApiConstants.apiForgetPassword);

        var request = http.MultipartRequest('POST', url);

        request.fields.addAll({
          ApiConstants.email: email,

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

    /// Get change password  Data*/
    Future<dynamic> getChangePasswordData(String password,String passwordConfirmation,String token) async {
      try {
        var url = Uri.parse(
            ApiConstants.baseUrl + ApiConstants.apiChangePassword);

        var request = http.MultipartRequest('POST', url);
        request.headers['Authorization'] =
        'Bearer $token';
        request.fields.addAll({
          ApiConstants.password: password,
          ApiConstants.passwordConfirmation: passwordConfirmation,

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

    /// Get delete account  Data*/
    Future<dynamic> getDeleteAccountData(String id,String token) async {
      try {
        var url = Uri.parse(
            ApiConstants.baseUrl + ApiConstants.apiDeleteAccount);

        var request = http.MultipartRequest('POST', url);
        request.headers['Authorization'] = 'Bearer $token';
        request.fields.addAll({
          ApiConstants.id: id
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
  }
