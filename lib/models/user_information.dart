import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserInformation {
  String? refreshToken;
  String? token;
  int? tokenExpires;
  User? user;

  UserInformation(
      {this.refreshToken, this.token, this.tokenExpires, this.user});

  UserInformation.fromJson(Map<String, dynamic> json) {
    refreshToken = json['refreshToken'];
    token = json['token'];
    tokenExpires = json['tokenExpires'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refreshToken'] = refreshToken;
    data['token'] = token;
    data['tokenExpires'] = tokenExpires;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? userTypeID;
  String? userId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? dOB;
  String? gender;
  String? contactNo;
  String? email;
  Null myclapEmailId;
  String? password;
  String? adharNo;
  String? address1;
  String? address2;
  int? villageid;
  String? maritalStatus;
  bool? approved;
  String? status;
  String? regDate;
  String? lastUpdated;
  String? updatedBy;
  int? bdeId;
  int? kendraID;
  Null isAcceptTnC;
  String? bnkAccNo;
  String? bnkName;
  String? bnkIfscCode;
  String? bnkAddress;
  String? bnkAccHolderName;
  String? profileImg;
  String? sEntity;

  User(
      {this.id,
        this.userTypeID,
        this.userId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.dOB,
        this.gender,
        this.contactNo,
        this.email,
        this.myclapEmailId,
        this.password,
        this.adharNo,
        this.address1,
        this.address2,
        this.villageid,
        this.maritalStatus,
        this.approved,
        this.status,
        this.regDate,
        this.lastUpdated,
        this.updatedBy,
        this.bdeId,
        this.kendraID,
        this.isAcceptTnC,
        this.bnkAccNo,
        this.bnkName,
        this.bnkIfscCode,
        this.bnkAddress,
        this.bnkAccHolderName,
        this.profileImg,
        this.sEntity});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userTypeID = json['userTypeID'];
    userId = json['userId'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    dOB = json['DOB'];
    gender = json['gender'];
    contactNo = json['contactNo'];
    email = json['email'];
    myclapEmailId = json['myclapEmailId'];
    password = json['password'];
    adharNo = json['adharNo'];
    address1 = json['address1'];
    address2 = json['address2'];
    villageid = json['villageid'];
    maritalStatus = json['maritalStatus'];
    approved = json['approved'];
    status = json['status'];
    regDate = json['regDate'];
    lastUpdated = json['lastUpdated'];
    updatedBy = json['updatedBy'];
    bdeId = json['BdeId'];
    kendraID = json['kendraID'];
    isAcceptTnC = json['IsAcceptTnC'];
    bnkAccNo = json['Bnk_Acc_No'];
    bnkName = json['Bnk_Name'];
    bnkIfscCode = json['Bnk_ifsc_Code'];
    bnkAddress = json['Bnk_Address'];
    bnkAccHolderName = json['Bnk_acc_Holder_Name'];
    profileImg = json['profileImg'];
    sEntity = json['__entity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userTypeID'] = userTypeID;
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    data['DOB'] = dOB;
    data['gender'] = gender;
    data['contactNo'] = contactNo;
    data['email'] = email;
    data['myclapEmailId'] = myclapEmailId;
    data['password'] = password;
    data['adharNo'] = adharNo;
    data['address1'] = address1;
    data['address2'] = address2;
    data['villageid'] = villageid;
    data['maritalStatus'] = maritalStatus;
    data['approved'] = approved;
    data['status'] = status;
    data['regDate'] = regDate;
    data['lastUpdated'] = lastUpdated;
    data['updatedBy'] = updatedBy;
    data['BdeId'] = bdeId;
    data['kendraID'] = kendraID;
    data['IsAcceptTnC'] = isAcceptTnC;
    data['Bnk_Acc_No'] = bnkAccNo;
    data['Bnk_Name'] = bnkName;
    data['Bnk_ifsc_Code'] = bnkIfscCode;
    data['Bnk_Address'] = bnkAddress;
    data['Bnk_acc_Holder_Name'] = bnkAccHolderName;
    data['profileImg'] = profileImg;
    data['__entity'] = sEntity;
    return data;
  }
}

Future<void> saveUserInformation(UserInformation userInfo) async {
  final prefs = await SharedPreferences.getInstance();
  String userInfoJson = jsonEncode(userInfo.toJson());
  await prefs.setString('userInformation', userInfoJson);
}

Future<UserInformation?> getUserInformation () async {
  final prefs = await SharedPreferences.getInstance();
  String? userInfoJson = prefs.getString('userInformation');
  if (userInfoJson != null) {
    Map<String, dynamic> userMap = jsonDecode(userInfoJson);
    return UserInformation.fromJson(userMap);
  }
  return null;
}
