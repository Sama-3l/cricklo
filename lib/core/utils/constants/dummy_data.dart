import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';

final dummyCurrUser = UserEntity(
  phoneNumber: "6386291080",
  name: "Raghvedra Mishra",
  email: "raghvendramishra2002@gmail.com",
  location: LocationEntity(area: "Gomti Nagar", city: "Lucknow", state: "UP"),
  playerType: PlayerType.allRounder,
  batterType: BatterType.leftHand,
  bowlerType: BowlerType.leftArmPace,
);
