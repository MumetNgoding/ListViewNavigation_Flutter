import 'dart:io';

import 'package:fhe_template/module/contoller/details_page.dart';
import 'package:fhe_template/module/contoller/user_pets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //hold response
  late UserPets userPets;
  // data is loaded flag
  bool isDataLoaded = false;
  // error message
  String errorMsg = '';

  //API Call

  Future<UserPets> getDataFromAPI() async {
    Uri url = Uri.parse(
        'https://mumetngoding.github.io/users_pets_api/users_pets.json');
    var response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      //OK
      UserPets userPets = userPetsFromJson(response.body);
      return userPets;
    } else {
      errorMsg = '${response.statusCode}: ${response.body}';
      return UserPets(data: []);
    }
  }

  assignData() async {
    userPets = await getDataFromAPI();
    setState(() {
      isDataLoaded = true;
    });
  }

  @override
  void initState() {
    // call method
    assignData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rest API Call'),
          centerTitle: true,
        ),
        body: isDataLoaded
            ? userPets.data.isNotEmpty
                ? ListView.builder(
                    itemCount: userPets.data.length,
                    itemBuilder: (context, index) => getMyRow(index),
                  )
                : const Center(child: Text('No Data'))
            : errorMsg.isNotEmpty
                ? Center(child: Text(errorMsg))
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
  }

  Widget getMyRow(int index) {
    return Card(
      child: ListTile(
        onTap: () {
          // Navigate to Next Details Page
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailsPage(userPet: userPets.data[index])),
          );
        },
        leading: CircleAvatar(
            radius: 20,
            backgroundColor:
                userPets.data[index].isFriendly ? Colors.green : Colors.red,
            backgroundImage: NetworkImage(userPets.data[index].petImage)),
        trailing: Icon(
          userPets.data[index].isFriendly ? Icons.pets : Icons.do_not_touch,
          color: userPets.data[index].isFriendly ? Colors.green : Colors.red,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userPets.data[index].userName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Dog: ${userPets.data[index].petName}'),
          ],
        ),
      ),
    );
  }
}
