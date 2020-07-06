import 'package:flutter/material.dart';
import 'package:flutter_qualtrics/qualtrics.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final qualtrics = Qualtrics(
    brandId: "vrt",
    zoneId: "ZN_41kI9YOXiYIJU9f",
    interceptId: "SI_2943OzPE9m8KKjj",
  );

  @override
  void initState() {
    super.initState();
  }

  Future<void> evaluateTargetingLogic() async {
    bool result = await qualtrics.evaluateTargetingLogic();
    print("EvaluateTargetingLogic result : $result");
  }

  Future<void> display() async {
    bool result = await qualtrics.display();
    print("Display result : $result");
  }

  Future<void> displayTarget(String target) async {
    await qualtrics.displayTarget(target);
  }

  Future<void> hide() async {
    await qualtrics.hide();
  }

  Future<void> registerViewVisit(String viewName) async {
    await qualtrics.registerViewVisit(viewName);
  }

  Future<void> resetTimer() async {
    await qualtrics.resetTimer();
  }

  Future<void> resetViewCounter() async {
    await qualtrics.resetViewCounter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Qualtrics SDK Flutter plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              RaisedButton(
                child: Text("Evaluate targeting logic"),
                onPressed: () => evaluateTargetingLogic(),
              ),
              SizedBox(height: 8),
              RaisedButton(
                child: Text("Display"),
                onPressed: () => display(),
              ),
              SizedBox(height: 8),
              RaisedButton(
                child: Text("Display target"),
                onPressed: () => displayTarget("https://flutter.dev/"),
              ),
              SizedBox(height: 8),
              RaisedButton(
                child: Text("Hide"),
                onPressed: () => hide(),
              ),
              SizedBox(height: 8),
              RaisedButton(
                child: Text("Register view visit"),
                onPressed: () => registerViewVisit("hello world"),
              ),
              SizedBox(height: 8),
              RaisedButton(
                child: Text("Reset timer"),
                onPressed: () => resetTimer(),
              ),
              SizedBox(height: 8),
              RaisedButton(
                child: Text("Reset view counter"),
                onPressed: () => resetViewCounter(),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
