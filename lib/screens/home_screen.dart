import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_v1/screens/sign_in_screen.dart';
import 'package:flutter_v1/utils/color_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> fetchJoke() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String joke = data['value'];

        return joke;
      } else {
        print("API request failed with status code ${response.statusCode}");
        print("Response body: ${response.body}");
        return "Failed to fetch a joke";
      }
    } catch (error) {
      print("Error while fetching joke: $error");
      return "Failed to fetch a joke";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Chuck Norris Joke of the Day",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              FutureBuilder<String>(
                future: fetchJoke(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loading indicator
                  } else if (snapshot.hasError) {
                    return Text("Failed to fetch a joke");
                  } else {
                    return Text(
                      snapshot.data ?? "No joke available",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Logout"),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed out!");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
