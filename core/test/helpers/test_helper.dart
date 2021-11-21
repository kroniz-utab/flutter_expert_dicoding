import 'package:core/core.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TVRepository,
  TVRemoteDataSource,
  TVLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<IOClient>(as: #MockIOClient),
])
void main() {}
