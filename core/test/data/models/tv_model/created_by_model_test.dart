import 'package:core/data/models/tv_models/createdby_model.dart';
import 'package:core/domain/entities/tv_entities/created_by.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tCreatedByModel = CreatedByModel(
    id: 1,
    creditId: 'creditId',
    name: 'name',
    gender: 0,
    profilePath: 'profilePath',
  );

  const tCreatedBy = CreatedBy(
    id: 1,
    creditId: 'creditId',
    name: 'name',
    gender: 0,
    profilePath: 'profilePath',
  );
  test('should be a subclass of Entity', () async {
    final result = tCreatedByModel.toEntity();
    expect(result, tCreatedBy);
  });
}
