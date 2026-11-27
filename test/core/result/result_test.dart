import 'package:qandil/core/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Result', () {
    test('Success retains its value', () {
      const Result<int> result = Success<int>(42);

      expect(result, isA<Success<int>>());
      switch (result) {
        case Success<int>(:final value):
          expect(value, 42);
        case FailureResult<int>():
          fail('Expected Success, received FailureResult');
      }
    });

    test('FailureResult retains its typed failure', () {
      const failure = NetworkFailure('Network unavailable');
      const Result<int> result = FailureResult<int>(failure);

      expect(result, isA<FailureResult<int>>());
      switch (result) {
        case FailureResult<int>(:final failure):
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, 'Network unavailable');
        case Success<int>():
          fail('Expected FailureResult, received Success');
      }
    });
  });
}
