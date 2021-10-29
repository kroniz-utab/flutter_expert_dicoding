import 'package:ditonton/data/models/tv_models/crew_model.dart';
import 'package:ditonton/domain/entities/tv_entities/crew.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tCrewModel = CrewModel(
    job: 'job',
    department: 'department',
    creditId: 'creditId',
    adult: true,
    gender: 0,
    id: 1,
    knownForDepartment: 'knownForDepartment',
    name: 'name',
    originalName: 'originalName',
    popularity: 2.2,
    profilePath: 'profilePath',
  );

  final tCrew = Crew(
    job: 'job',
    department: 'department',
    creditId: 'creditId',
    adult: true,
    gender: 0,
    id: 1,
    knownForDepartment: 'knownForDepartment',
    name: 'name',
    originalName: 'originalName',
    popularity: 2.2,
    profilePath: 'profilePath',
  );

  test('should be a subclass of Entity', () async {
    final result = tCrewModel.toEntity();
    expect(result, tCrew);
  });
}
