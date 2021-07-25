import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double size = 100;
  double offsetY = 0.0;
  double offsetX = 0.0;
  @override
  void initState() {
    super.initState();
    this.controller = ScrollController();
    this.controller.addListener(() {
      final max = this.controller.position.maxScrollExtent;
      final offset = this.controller.offset;
      final height = MediaQuery.of(context).size.height - this.size;
      final width = MediaQuery.of(context).size.width - this.size;
      final ratio = offset / max;
      setState(() {
        this.offsetY = (ratio) * height;
        this.offsetX = (ratio) * width;
      });
    });
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  late ScrollController controller;
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              child: SingleChildScrollView(
                controller: this.controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...List.generate(100, (index) => Text("number: $index")),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: this.offsetX,
            top: this.offsetY,
            child: Container(
              width: this.size,
              height: this.size,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
