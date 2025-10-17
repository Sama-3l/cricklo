import 'package:cricklo/features/scorer/domain/entities/broadcast_wrapper_entity.dart';

class BroadcastWrapperModel {
  final String type;
  final int seqNo;
  final int timestamp;
  final bool undo;
  final Map<String, dynamic>? payload;

  BroadcastWrapperModel({
    required this.type,
    required this.seqNo,
    required this.timestamp,
    this.payload,
    this.undo = false,
  });

  factory BroadcastWrapperModel.fromJson(Map<String, dynamic> map) {
    return BroadcastWrapperModel(
      type: map['type'] as String,
      seqNo: map['seqNo'] as int,
      timestamp: map['timestamp'] as int,
      payload: map['payload'],
      undo: map['undo'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'seqNo': seqNo,
      'timestamp': timestamp,
      'payload': payload,
      'undo': undo,
    };
  }

  BroadcastWrapperEntity toEntity() {
    return BroadcastWrapperEntity(
      type: type,
      seqNo: seqNo,
      timestamp: timestamp,
      payload: payload,
      undo: undo,
    );
  }
}
