import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pie_menyu_core/executor/executable.dart';
import 'package:pie_menyu_core/executor/executor_service.dart';

class MockExecutable implements Executable {
  final VoidCallback _callback;
  final int? _delay;
  MockExecutable(this._callback, {delay}): _delay = delay;
  @override
  Future<void> execute() async {
    await Future.delayed(Duration(milliseconds: _delay ?? Random().nextInt(100) + 250));
    _callback();
  }
}

void main() {
  test('ExecutorService executes tasks sequentially', () async {
    List<int> actualResult = [];
    final task1 = MockExecutable(() => actualResult.add(1));
    final task2 = MockExecutable(() => actualResult.add(2));
    final task3 = MockExecutable(() => actualResult.add(3));
    final task4 = MockExecutable(() => actualResult.add(4));
    final task5 = MockExecutable(() => actualResult.add(5));

    final executor = ExecutorService();
    executor.execute(task1);
    executor.execute(task2);
    executor.execute(task3);
    executor.execute(task4);
    executor.execute(task5);

    await executor.start();

    expect(listEquals(actualResult, [1,2,3,4,5]), true);
  });

  test('ExecutorService updates isExecuting flag correctly', () async {
    final executor = ExecutorService();

    expect(executor.isExecuting, false);

    executor.execute(MockExecutable(() => {}));
    executor.execute(MockExecutable(() => {}));
    executor.execute(MockExecutable(() => {}));
    executor.execute(MockExecutable(() => {}));
    executor.execute(MockExecutable(() => {}));
    await executor.start();

    expect(executor.isExecuting, false);
  });

  test('ExecutorService cancelAll() cancels all remaining tasks', () async {
    final executor = ExecutorService();

    expect(executor.isExecuting, false);

    int count = 0;
    executor.execute(MockExecutable(() {count++;}, delay: 1000));
    executor.execute(MockExecutable(() {count++;}, delay: 2000));
    executor.execute(MockExecutable(() {count++;}, delay: 3000));
    executor.execute(MockExecutable(() {count++;}, delay: 3000));
    executor.execute(MockExecutable(() {count++;}, delay: 2000));
    executor.start();

    await Future.delayed(const Duration(seconds: 5), () {
      executor.cancelAll();
    });
    await Future.delayed(const Duration(seconds: 8), () {
    });
    expect(executor.isExecuting, false);
    expect(count, 3);
  });
}