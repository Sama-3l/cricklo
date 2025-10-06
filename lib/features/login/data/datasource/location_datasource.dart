// data/datasources/location_remote_datasource.dart
import 'dart:convert';
import 'package:cricklo/features/login/domain/models/remote/location_model.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class LocationRemoteDataSource {
  Future<List<LocationModel>> searchLocations(String query);
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final String apiKey;
  String? _sessionToken;
  final Uuid _uuid = Uuid();

  LocationRemoteDataSourceImpl({required this.apiKey});

  @override
  Future<List<LocationModel>> searchLocations(String query) async {
    _sessionToken ??= _uuid.v4(); // start session token
    final url = Uri.parse(
      "https://api.locationiq.com/v1/autocomplete.php"
      "?key=${dotenv.env['LOCATION_IQ_API_KEY']}"
      "&q=$query"
      "&countrycodes=in"
      "&limit=5",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => LocationModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch locations');
    }
  }

  void resetSession() {
    _sessionToken = null;
  }
}
