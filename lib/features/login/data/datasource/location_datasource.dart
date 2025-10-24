// data/datasources/location_remote_datasource.dart
import 'dart:convert';
import 'package:cricklo/services/api_endpoint_constants.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class LocationRemoteDataSource {
  Future<Map<String, dynamic>> searchLocations(String query);
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final String apiKey;
  String? _sessionToken;
  final Uuid _uuid = Uuid();

  LocationRemoteDataSourceImpl({required this.apiKey});

  @override
  Future<Map<String, dynamic>> searchLocations(String query) async {
    _sessionToken ??= _uuid.v4(); // start session token
    final url = Uri.parse(
      "${ApiEndpointConstants.locationAPIBaseUrl}?input=$query&key=${dotenv.env['GOOGLE_PLACES_API_KEY']}&sessiontoken=$_sessionToken",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch locations');
    }
  }

  void resetSession() {
    _sessionToken = null;
  }
}
