import 'package:equatable/equatable.dart';

class Network extends Equatable {
  final String name;
  final int id;
  final String? logoPath;
  final String originCountry;

  Network({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  @override
  List<Object?> get props => [
        name,
        id,
        logoPath,
        originCountry,
      ];
}
