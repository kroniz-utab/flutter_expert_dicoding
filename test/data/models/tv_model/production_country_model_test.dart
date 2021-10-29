import 'package:ditonton/data/models/tv_models/production_country_model.dart';
import 'package:ditonton/domain/entities/tv_entities/production_country.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tProdCountryModel = ProductionCountryModel(
    iso31661: 'iso31661',
    name: 'name',
  );

  final tProdCountry = ProductionCountry(
    iso31661: 'iso31661',
    name: 'name',
  );

  test('should be a subclass of Entity', () async {
    final result = tProdCountryModel.toEntity();
    expect(result, tProdCountry);
  });
}
