import 'dart:math';

class Uuid {
  static const MaxNumericDigits = 9;
  static final _random = Random();

  static int v4() {
    assert(1 <= MaxNumericDigits && MaxNumericDigits <= 9);
    int min = MaxNumericDigits == 1 ? 0 : pow(10, MaxNumericDigits - 1);
    int max = pow(10, MaxNumericDigits);

    return min + _random.nextInt(max - min);
  }
}
