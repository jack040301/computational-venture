import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:main_venture/auth_screen.dart';
import 'package:main_venture/screens/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';



//final userphoto = FirebaseAuth.instance.currentUser!.photoURL??"";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();


}

Future<void> logOut() async {
  try {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print("error in sign in $e");
  }
}



class _ProfileScreenState extends State<ProfileScreen> {

  // List<ListItem> _dropdownItems = [
  //   ListItem(1, "GeeksforGeeks"),
  //   ListItem(2, "Javatpoint"),
  //   ListItem(3, "tutorialandexample"),
  //   ListItem(4, "guru99")
  // ];
  //
  // List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  // ListItem _itemSelected;
  //
  // void initState() {
  //   super.initState();
  //   _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
  //   _itemSelected = _dropdownMenuItems[1].value;
  // }
  //
  // List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
  //   List<DropdownMenuItem<ListItem>> items = List();
  //   for (ListItem listItem in listItems) {
  //     items.add(
  //       DropdownMenuItem(
  //         child: Text(listItem.name),
  //         value: listItem,
  //       ),
  //     );
  //   }
  //   return items;
  // }

  createAlertDialog(BuildContext context){
    TextEditingController customController  = TextEditingController();

    return showDialog(context: context, builder: (context){
      return AlertDialog(

        title: Container(

          child: Column(
            children: [
              const Text('What kind of business do you prefer?'),
              // DropdownButtonHideUnderline(
              //   child: DropdownButton(
              //       // value: _itemSelected,
              //       // items: _dropdownMenuItems,
              //       // onChanged: (value) {
              //       //   setState(() {
              //       //     _itemSelected = value;
              //       //   });
              //       // }),
              // ),


              TextField(
                controller: customController,
              decoration: InputDecoration(
                  //labelText: 'What kind of business do you prefer?',
                  border: OutlineInputBorder(),
                  hintText: 'Choose your business'),
              ),
              const Text('Enter budget for the area (per square meter)'),
              TextField(
                controller: customController,
                decoration: InputDecoration(
                  //labelText: 'Enter budget for the area (per square meter)',
                  border: OutlineInputBorder(),
                  //hintText: 'Choose your business'),
                ),
              ),
              const Text('Enter value of area (square meter)'),
              TextField(
                controller: customController,
                decoration: InputDecoration(
                  //labelText: 'Enter value of area (square meter)',
                  border: OutlineInputBorder(),
                  //hintText: 'Choose your business'),
                ),
              ),
            ],

          ),
        ),

        // title: Text(""),
        // content: TextField(
        //   controller: customController,
        //     decoration: InputDecoration(
        //       border: OutlineInputBorder(),
        //       hintText: 'Enter a search term',),
        //
        // ),


        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('OK'),
            onPressed: (){
              Navigator.of(context).pop(customController.text.toString());
            },
          )
        ],


      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FirebaseAuth.instance.currentUser!.photoURL == null
                ? const Image(image: AssetImage('assets/images/pic.png'))
                : Image.network(FirebaseAuth.instance.currentUser!.photoURL??""),
            Text(
              FirebaseAuth.instance.currentUser!.displayName ?? "Default Name",
              style: const TextStyle(fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(
              height: 10,
            ),
            // Text(
            //   FirebaseAuth.instance.currentUser!.uid,
            //   style: const TextStyle(fontSize: 30,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black87),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),

            ElevatedButton(
                onPressed: logOut, child: Text("Logout Account")
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text("Map")
            ),
            ElevatedButton(
                onPressed: () {
                  createAlertDialog(context);
                },
                child: Text("Dialog")
            ),
          ],
        ),
      ),

    );
  }


}
