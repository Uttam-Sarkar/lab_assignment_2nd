import 'dart:io';

import 'package:lab_assignment_2nd/userDataDetailsScreen.dart';
import 'package:lab_assignment_2nd/userInputScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_assignment_2nd/userData.dart';
class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(File(userList[index].imagePath)),
            ),
            title: Text(userList[index].userName),
            subtitle: Text(userList[index].userDialogue),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDataDetailScreen(
                    userName: userList[index].userName,
                    userDialogue: userList[index].userDialogue,
                    imagePath: userList[index].imagePath,
                  ),
                ),
              );
            },
          );
        },
      ),
        floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserInputScreen()),
              );

            },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        )
    );
  }
}
