import 'package:core/data/models/tv_models/guest_star_model.dart';
import 'package:core/domain/entities/tv_entities/guest_star.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGuestStarModel = GuestStarModel(
    character: 'character',
    creditId: 'creditId',
    order: 1,
    adult: false,
    gender: 1,
    id: 1,
    knownForDepartment: 'knownForDepartment',
    name: 'name',
    originalName: 'originalName',
    popularity: 12,
    profilePath: 'profilePath',
  );

  const tGuestStar = GuestStar(
    character: 'character',
    creditId: 'creditId',
    order: 1,
    adult: false,
    gender: 1,
    id: 1,
    knownForDepartment: 'knownForDepartment',
    name: 'name',
    originalName: 'originalName',
    popularity: 12,
    profilePath: 'profilePath',
  );

  test('should be a subclass of Entity', () async {
    final result = tGuestStarModel.toEntity();
    expect(result, tGuestStar);
  });
}
