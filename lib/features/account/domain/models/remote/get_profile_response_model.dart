// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/account/domain/entities/get_profile_response_entity.dart';
import 'package:cricklo/features/login/domain/models/remote/user_model.dart';

class GetProfileResponseModel {
  final bool success;
  final UserModel? userModel;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetProfileResponseModel({
    required this.success,
    this.userModel,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'user': userModel?.toJson(),
      'message': message,
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  GetProfileResponseEntity toEntity() {
    return GetProfileResponseEntity(
      success: success,
      userEntity: userModel?.toEntity(),
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  factory GetProfileResponseModel.fromJson(Map<String, dynamic> map) {
    return GetProfileResponseModel(
      success: map['success'] as bool,
      userModel: map['data'] != null ? UserModel.fromJson(map) : null,
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as String
          : null,
    );
  }
}
