import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "GoFit",
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            Center(
              child: MaterialButton(
                elevation: 30,
                color: Color(0xFF023E8A),
                shape: CircleBorder(),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(100),
                  child: Text(
                    'START',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
            Text("GoFit"),
          ],
        ),
      ),
    );
  }
}
