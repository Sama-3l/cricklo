// import 'package:hive/hive.dart';

// extension _HiveIdGenerator on HiveObject {
//   static String generateId() =>
//       DateTime.now().microsecondsSinceEpoch.toString();
// }

extension ListExt<T> on List<T> {
  List<T> takeLast(int count) {
    if (length <= count) return this;
    return sublist(length - count);
  }
}
