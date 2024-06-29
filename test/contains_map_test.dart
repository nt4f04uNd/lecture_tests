import 'package:flutter_test/flutter_test.dart';

import 'contains_map.dart';

void main() {
  test('contains map matcher', () {
    expect(
        {
          'key_1': 1,
          'key_2': 2,
          'key_3': 3,
        },
        containsMap({
          'key_1': 1,
          'key_2': 2,
        }));
  });

  test('failed test and describeMistmatch output demo', () {
    // expect(
    //   {
    //     'key_1': 1,
    //     'key_2': 2,
    //     'key_3': 3,
    //   },
    //   containsMap({
    //     'key_1': 1,
    //     'key_2': 3,
    //     'key_4': 4,
    //   }),
    // );
  });

  test('does not contain map', () {
    expect(
        {
          'key_1': 1,
          'key_2': 2,
          'key_3': 3,
        },
        isNot(
          containsMap({
            'key_1': 1,
            'key_3': 2,
          }),
        ));
  });
}
