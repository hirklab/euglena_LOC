// LED constants

final int left = 10;
final int right = 5;
final int down = 9;
final int up = 6;
final int pump = 3;

enum Direction {
    LEFT(0, 10),
    RIGHT(1, 5),
    UP(2, 6),
    DOWN(3, 9);

    final int index, pin;

    Direction(int index, int pin) {
        this.index = index;
        this.pin = pin;
    }
}