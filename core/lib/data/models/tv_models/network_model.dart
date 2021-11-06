import '../../../domain/entities/tv_entities/network.dart';
import 'package:equatable/equatable.dart';

class NetworkModel extends Equatable {
  const NetworkModel({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  final String name;
  final int id;
  final String? logoPath;
  final String originCountry;

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        name: json["name"],
        id: json["id"],
        logoPath: json["logo_path"] ?? json["logo_path"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "logo_path": logoPath ?? logoPath,
        "origin_country": originCountry,
      };

  Network toEntity() {
    return Network(
      name: name,
      id: id,
      logoPath: logoPath,
      originCountry: originCountry,
    );
  }

  @override
  List<Object?> get props => [
        name,
        id,
        logoPath,
        originCountry,
      ];
}
