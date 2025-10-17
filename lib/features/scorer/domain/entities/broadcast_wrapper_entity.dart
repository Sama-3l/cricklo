class BroadcastWrapperEntity {
  final String type;
  final int seqNo;
  final int timestamp;
  final bool undo;
  final Map<String, dynamic>? payload;

  BroadcastWrapperEntity({
    required this.type,
    required this.seqNo,
    required this.timestamp,
    this.payload,
    this.undo = false,
  });
}
