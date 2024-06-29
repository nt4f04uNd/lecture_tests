import 'package:flutter_test/flutter_test.dart';

/// Использование в коде:
///
/// expect(
///     actualResponse as Json,
///     containsMap({
///     'pageName': expectedPrevPageValue,
///     'reqId': expectedRecId.id,
///     }),
/// );
Matcher containsMap(Map<String, dynamic>? value) => _ContainsMap(value);

class _ContainsMap extends Matcher {
  final Map<String, dynamic>? _value;

  const _ContainsMap(this._value);

  @override
  Description describe(Description description) {
    return description
        .add('contains map should contain all entries from ')
        .addDescriptionOf(_value);
  }

  @override
  Description describeMismatch(
    dynamic item,
    Description mismatchDescription,
    Map<dynamic, dynamic> matchState,
    bool verbose,
  ) {
    final diff = matchState['diff'] as _MapDifference;
    if (diff.onlyInMap1.isNotEmpty) {
      mismatchDescription
          .add('contains entries from actual ')
          .addDescriptionOf(diff.onlyInMap1)
          .add('\n');
    }

    if (diff.onlyInMap2.isNotEmpty) {
      mismatchDescription
          .add('but does not contains entries ')
          .addDescriptionOf(diff.onlyInMap2)
          .add('\n');
      ;
    }

    if (diff.differentValues.isNotEmpty) {
      mismatchDescription
          .add('but has different values in these entries ')
          .addDescriptionOf(diff.differentValues)
          .add('\n');
    }

    return mismatchDescription;
  }

  @override
  bool matches(Object? item, Map matchState) {
    if (_value == null || item == null) {
      return false;
    }

    final isMatched = _value.entries.every(
      (entry) => (item as Map<String, dynamic>)[entry.key] == entry.value,
    );

    if (!isMatched) {
      matchState['diff'] =
          _getMapDifference(item as Map<String, dynamic>, _value);
    }

    return isMatched;
  }
}

_MapDifference _getMapDifference(
  Map<String, dynamic> actual,
  Map<String, dynamic> compared,
) {
  Map<String, dynamic> onlyInActual = {};
  Map<String, dynamic> onlyInCompared = {};
  Map<String, dynamic> differentValues = {};

  // Keys in map1 but not in map2
  for (String key in actual.keys) {
    if (!compared.containsKey(key)) {
      onlyInActual[key] = actual[key];
    } else if (actual[key] != compared[key]) {
      differentValues[key] = {'actual': actual[key], 'compared': compared[key]};
    }
  }

  // Keys in map2 but not in map1
  for (String key in compared.keys) {
    if (!actual.containsKey(key)) {
      onlyInCompared[key] = compared[key];
    }
  }

  return _MapDifference(
    onlyInMap1: onlyInActual,
    onlyInMap2: onlyInCompared,
    differentValues: differentValues,
  );
}

class _MapDifference {
  Map<String, dynamic> onlyInMap1;
  Map<String, dynamic> onlyInMap2;
  Map<String, dynamic> differentValues;

  _MapDifference({
    required this.onlyInMap1,
    required this.onlyInMap2,
    required this.differentValues,
  });
}
