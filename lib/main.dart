import 'package:dio_interceptors/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dio Interceptors"),
      ),
      body: Center(
        child: Column(
          children: [
            Obx(
              () => controller.sellCollections.isEmpty
                  ? const Text("No data")
                  : controller.collectionDataLoading.value
                      ? const CircularProgressIndicator()
                      : Text("${controller.sellCollections.first.title}"),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.getHomeCollectionList();
                },
                child: const Text("Call api 1")),
            ElevatedButton(onPressed: () {}, child: const Text("Call api 2"))
          ],
        ),
      ),
    );
  }
}
