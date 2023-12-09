Future<void> MyDelayFun({required Duration duration}) async {
  await Future.delayed(duration);
}
