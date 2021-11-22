import 'package:core/data/models/tv_models/spoken_language_model.dart';
import 'package:core/domain/entities/tv_entities/spoken_language.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSpokenLangModel = SpokenLanguageModel(
    englishName: 'englishName',
    iso6391: 'iso6391',
    name: 'name',
  );

  const tSpokenLang = SpokenLanguage(
    englishName: 'englishName',
    iso6391: 'iso6391',
    name: 'name',
  );

  test('should be a subclass of Entity', () async {
    final result = tSpokenLangModel.toEntity();
    expect(result, tSpokenLang);
  });

  test('should be check props', () {
    expect(tSpokenLangModel, tSpokenLangModel);
  });
}
