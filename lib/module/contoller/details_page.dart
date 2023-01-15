import 'package:fhe_template/module/contoller/user_pets.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.userPet});
  final Datum userPet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userPet.userName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 152,
                backgroundColor: userPet.isFriendly ? Colors.green : Colors.red,
                child: CircleAvatar(
                  radius: 150,
                  backgroundImage: NetworkImage(userPet.petImage),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                userPet.petName,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    userPet.isFriendly ? Icons.pets : Icons.do_not_touch,
                    color: userPet.isFriendly ? Colors.green : Colors.red,
                  ),
                  Text(
                    userPet.isFriendly
                        ? '${userPet.petName} is Friendly'
                        : '${userPet.petName} is not Friendly',
                    style: TextStyle(
                      fontSize: 24,
                      color: userPet.isFriendly ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
