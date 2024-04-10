/*
class ProfileData {
  String vchaddress;
  String vchcity;
  String vchpostalcode;
  String vchhomephone;
  String vchmomname;
  String vchmomsurname;
  String vchmomhomephone;
  String vchmomworkphone;
  String vchmomcellphone;
  String vchmomhomestreet;
  String vchmomhomecity;
  String vchmomhomepc;
  String vchmomemployer;
  String vchmomoccupassion;
  String vchmomworkstreet;
  String vchmomworkcity;
  String vchmomworkpc;
  String vchmomemail;
  String vchdadname;
  String vchdadsurname;
  String vchdadhomephone;
  String vchdadworkphone;
  String vchdadcellphone;
  String vchdadhomestreet;
  String vchdadhomecity;
  String vchdadhomepc;
  String vchdademployer;
  String vchdadoccupassion;
  String vchdadworkstreet;
  String vchdadworkcity;
  String vchdadworkpc;
  String vchdademail;
  String vchdoctorname;
  String vchdoctoraddress;
  String vchdoctorcity;
  String vchdoctorpostalcode;
  String vchdoctorphone;
  String vchaltercontactname1;
  String vchaltercontactrelationship1;
  String vchaltercontacthomephone1;

  String vchaltercontactname2;
  String vchaltercontactworkphone2;
  String vchaltercontacthomephone2;
  String vchaltercontactcellphone2;
  String vchaltercontactrelationship2;
  String vchaltercontactcellphone1;
  String vchaltercontactworkphone1;

  ProfileData({
    required this.vchaddress,
    required this.vchcity,
    required this.vchpostalcode,
    required this.vchhomephone,
    required this.vchmomname,
    required this.vchmomsurname,
    required this.vchmomhomephone,
    required this.vchmomworkphone,
    required this.vchmomcellphone,
    required this.vchmomhomestreet,
    required this.vchmomhomecity,
    required this.vchmomhomepc,
    required this.vchmomemployer,
    required this.vchmomoccupassion,
    required this.vchmomworkstreet,
    required this.vchmomworkcity,
    required this.vchmomworkpc,
    required this.vchmomemail,
    required this.vchdadname,
    required this.vchdadsurname,
    required this.vchdadhomephone,
    required this.vchdadworkphone,
    required this.vchdadcellphone,
    required this.vchdadhomestreet,
    required this.vchdadhomecity,
    required this.vchdadhomepc,
    required this.vchdademployer,
    required this.vchdadoccupassion,
    required this.vchdadworkstreet,
    required this.vchdadworkcity,
    required this.vchdadworkpc,
    required this.vchdademail,
    required this.vchdoctorname,
    required this.vchdoctoraddress,
    required this.vchdoctorcity,
    required this.vchdoctorpostalcode,
    required this.vchdoctorphone,
    required this.vchaltercontactname1,
    required this.vchaltercontactrelationship1,
    required this.vchaltercontacthomephone1,
    required this.vchaltercontactname2,
    required this.vchaltercontactworkphone2,
    required this.vchaltercontacthomephone2,
    required this.vchaltercontactcellphone2,
    required this.vchaltercontactrelationship2,
    required this.vchaltercontactcellphone1,
    required this.vchaltercontactworkphone1,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      vchaddress: json['vchaddress'],
      vchcity: json['vchcity'],
      vchpostalcode: json['vchpostalcode'],
      vchhomephone: json['vchhomephone'],
      vchmomname: json['vchmomname'],
      vchmomsurname: json['vchmomsurname'],
      vchmomhomephone: json['vchmomhomephone'],
      vchmomworkphone: json['vchmomworkphone'],
      vchmomcellphone: json['vchmomcellphone'],
      vchmomhomestreet: json['vchmomhomestreet'],
      vchmomhomecity: json['vchmomhomecity'],
      vchmomhomepc: json['vchmomhomepc'],
      vchmomemployer: json['vchmomemployer'],
      vchmomoccupassion: json['vchmomoccupassion'],
      vchmomworkstreet: json['vchmomworkstreet'],
      vchmomworkcity: json['vchmomworkcity'],
      vchmomworkpc: json['vchmomworkpc'],
      vchmomemail: json['vchmomemail'],
      vchdadname: json['vchdadname'],
      vchdadsurname: json['vchdadsurname'],
      vchdadhomephone: json['vchdadhomephone'],
      vchdadworkphone: json['vchdadworkphone'],
      vchdadcellphone: json['vchdadcellphone'],
      vchdadhomestreet: json['vchdadhomestreet'],
      vchdadhomecity: json['vchdadhomecity'],
      vchdadhomepc: json['vchdadhomepc'],
      vchdademployer: json['vchdademployer'],
      vchdadoccupassion: json['vchdadoccupassion'],
      vchdadworkstreet: json['vchdadworkstreet'],
      vchdadworkcity: json['vchdadworkcity'],
      vchdadworkpc: json['vchdadworkpc'],
      vchdademail: json['vchdademail'],
      vchdoctorname: json['vchdoctorname'],
      vchdoctoraddress: json['vchdoctoraddress'],
      vchdoctorcity: json['vchdoctorcity'],
      vchdoctorpostalcode: json['vchdoctorpostalcode'],
      vchdoctorphone: json['vchdoctorphone'],
      vchaltercontactname1: json['vchaltercontactname1'],
      vchaltercontactrelationship1: json['vchaltercontactrelationship1'],
      vchaltercontacthomephone1: json['vchaltercontacthomephone1'],
      vchaltercontactname2: json['vchaltercontactname2'],
      vchaltercontactworkphone2: json['vchaltercontactworkphone2'],
      vchaltercontacthomephone2: json['vchaltercontacthomephone2'],
      vchaltercontactcellphone2: json['vchaltercontactcellphone2'],
      vchaltercontactrelationship2: json['vchaltercontactrelationship2'],
      vchaltercontactcellphone1: json['vchaltercontactcellphone1'],
      vchaltercontactworkphone1: json['vchaltercontactworkphone1'],
    );
  }
}

class ProfileDataResponse {
  int status;
  String message;
  ProfileData result;

  ProfileDataResponse(
      {required this.status, required this.message, required this.result});

  factory ProfileDataResponse.fromJson(Map<dynamic, dynamic> json) {
    var result = json['result'];
    ProfileData data = result.map((messageJson) {
      return ProfileData.fromJson(messageJson);
    });

    return ProfileDataResponse(
      status: json['status'],
      message: json['message'],
      result: data,
    );
  }
}
*/


class ProfileDataResponse {
  int status;
  String message;
  ProfileData result;

  ProfileDataResponse({required this.status, required this.message, required this.result});

  factory ProfileDataResponse.fromJson(Map<String, dynamic> json) {
    return ProfileDataResponse(
      status: json['status'],
      message: json['message'],
      result: ProfileData.fromJson(json['result']),
    );
  }
}

class ProfileData {
  String vchaddress;
  String vchcity;
  String vchpostalcode;
  String vchhomephone;
  String vchmomname;
  String vchmomsurname;
  String vchmomhomephone;
  String vchmomworkphone;
  String vchmomcellphone;
  String vchmomhomestreet;
  String vchmomhomecity;
  String vchmomhomepc;
  String vchmomemployer;
  String vchmomoccupassion;
  String vchmomworkstreet;
  String vchmomworkcity;
  String vchmomworkpc;
  String vchmomemail;
  String vchdadname;
  String vchdadsurname;
  String vchdadhomephone;
  String vchdadworkphone;
  String vchdadcellphone;
  String vchdadhomestreet;
  String vchdadhomecity;
  String vchdadhomepc;
  String vchdademployer;
  String vchdadoccupassion;
  String vchdadworkstreet;
  String vchdadworkcity;
  String vchdadworkpc;
  String vchdademail;
  String vchdoctorname;
  String vchdoctoraddress;
  String vchdoctorcity;
  String vchdoctorpostalcode;
  String vchdoctorphone;
  String vchaltercontactname1;
  String vchaltercontactrelationship1;
  String vchaltercontacthomephone1;
  String vchaltercontactworkphone1;
  String vchaltercontactcellphone1;
  String vchaltercontactname2;
  String vchaltercontactrelationship2;
  String vchaltercontactworkphone2;
  String vchaltercontacthomephone2;
  String vchaltercontactcellphone2;

  ProfileData({
    required this.vchaddress,
    required this.vchcity,
    required this.vchpostalcode,
    required this.vchhomephone,
    required this.vchmomname,
    required this.vchmomsurname,
    required this.vchmomhomephone,
    required this.vchmomworkphone,
    required this.vchmomcellphone,
    required this.vchmomhomestreet,
    required this.vchmomhomecity,
    required this.vchmomhomepc,
    required this.vchmomemployer,
    required this.vchmomoccupassion,
    required this.vchmomworkstreet,
    required this.vchmomworkcity,
    required this.vchmomworkpc,
    required this.vchmomemail,
    required this.vchdadname,
    required this.vchdadsurname,
    required this.vchdadhomephone,
    required this.vchdadworkphone,
    required this.vchdadcellphone,
    required this.vchdadhomestreet,
    required this.vchdadhomecity,
    required this.vchdadhomepc,
    required this.vchdademployer,
    required this.vchdadoccupassion,
    required this.vchdadworkstreet,
    required this.vchdadworkcity,
    required this.vchdadworkpc,
    required this.vchdademail,
    required this.vchdoctorname,
    required this.vchdoctoraddress,
    required this.vchdoctorcity,
    required this.vchdoctorpostalcode,
    required this.vchdoctorphone,
    required this.vchaltercontactname1,
    required this.vchaltercontactrelationship1,
    required this.vchaltercontacthomephone1,
    required this.vchaltercontactworkphone1,
    required this.vchaltercontactcellphone1,
    required this.vchaltercontactname2,
    required this.vchaltercontactrelationship2,
    required this.vchaltercontactworkphone2,
    required this.vchaltercontacthomephone2,
    required this.vchaltercontactcellphone2,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      vchaddress: json['vchaddress'],
      vchcity: json['vchcity'],
      vchpostalcode: json['vchpostalcode'],
      vchhomephone: json['vchhomephone'],
      vchmomname: json['vchmomname'],
      vchmomsurname: json['vchmomsurname'],
      vchmomhomephone: json['vchmomhomephone'],
      vchmomworkphone: json['vchmomworkphone'],
      vchmomcellphone: json['vchmomcellphone'],
      vchmomhomestreet: json['vchmomhomestreet'],
      vchmomhomecity: json['vchmomhomecity'],
      vchmomhomepc: json['vchmomhomepc'],
      vchmomemployer: json['vchmomemployer'],
      vchmomoccupassion: json['vchmomoccupassion'],
      vchmomworkstreet: json['vchmomworkstreet'],
      vchmomworkcity: json['vchmomworkcity'],
      vchmomworkpc: json['vchmomworkpc'],
      vchmomemail: json['vchmomemail'],
      vchdadname: json['vchdadname'],
      vchdadsurname: json['vchdadsurname'],
      vchdadhomephone: json['vchdadhomephone'],
      vchdadworkphone: json['vchdadworkphone'],
      vchdadcellphone: json['vchdadcellphone'],
      vchdadhomestreet: json['vchdadhomestreet'],
      vchdadhomecity: json['vchdadhomecity'],
      vchdadhomepc: json['vchdadhomepc'],
      vchdademployer: json['vchdademployer'],
      vchdadoccupassion: json['vchdadoccupassion'],
      vchdadworkstreet: json['vchdadworkstreet'],
      vchdadworkcity: json['vchdadworkcity'],
      vchdadworkpc: json['vchdadworkpc'],
      vchdademail: json['vchdademail'],
      vchdoctorname: json['vchdoctorname'],
      vchdoctoraddress: json['vchdoctoraddress'],
      vchdoctorcity: json['vchdoctorcity'],
      vchdoctorpostalcode: json['vchdoctorpostalcode'],
      vchdoctorphone: json['vchdoctorphone'],
      vchaltercontactname1: json['vchaltercontactname1'],
      vchaltercontactrelationship1: json['vchaltercontactrelationship1'],
      vchaltercontacthomephone1: json['vchaltercontacthomephone1'],
      vchaltercontactworkphone1: json['vchaltercontactworkphone1'],
      vchaltercontactcellphone1: json['vchaltercontactcellphone1'],
      vchaltercontactname2: json['vchaltercontactname2'],
      vchaltercontactrelationship2: json['vchaltercontactrelationship2'],
      vchaltercontactworkphone2: json['vchaltercontactworkphone2'],
      vchaltercontacthomephone2: json['vchaltercontacthomephone2'],
      vchaltercontactcellphone2: json['vchaltercontactcellphone2'],
    );
  }
}
