const TOTAL = 0;

void main() {
  test3();
}

void test1() {
  print("---function test1 ----");
  var ham = (var a, var b) => a + b;
  var result = ham(1, 2);
  print("gia tri cua ham la : $result");
}

void test2() {
  print("---function test2 ----");
  var mIterable = Iterable.generate(10);
  for (var xxx in mIterable) {
    print("gia tri bien trong mIterable la : $xxx");
  }
}

void test3() {
  Future t = showInfo();
  t.then((data) => notifyFinish(data))
  .catchError((e) => print("co loi xay ra : " + e.toString()));
  secondFunction();
}

notifyFinish(num data) {
  print("notifyFinish function $data");
}

Future<num> showInfo() async {
  var data = await getInfo();
  print('This is your data -' + DateTime.now().toString());
  print(data);
  return data;
}

getInfo() {
  return 1/0;
}

secondFunction() {
  print('secondFunction - ' + DateTime.now().toString());
}
