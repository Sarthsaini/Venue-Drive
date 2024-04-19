import 'package:flutter/material.dart';

class Event {
  final String assetImage; 
  final String title;
  final String description;
  // final Color backgroundColor;

  const Event({
    required this.assetImage,
    required this.title,
    required this.description,
    // required this.backgroundColor,
  });
}

// ignore: camel_case_types
class server_selections extends StatefulWidget {
   server_selections({Key? key}) : super(key: key);
 

  @override
  State<server_selections> createState() => _ServerScreenState();
}

class _ServerScreenState extends State<server_selections> {
  bool checkboxValue1 = true;
  bool checkboxValue2 = true;
  bool checkboxValue3 = true;
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Stack(
          children: [
            Opacity(
              opacity: 1,
              child: Image.asset(
                'assets/bgs.jpg',
                width: MediaQuery.of(context).size.width,
                height: 250.0,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
    decoration: const BoxDecoration(
    color: Color(0xFF1C1D23),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15.0),
      topRight: Radius.circular(15.0),
    ),
  ),
    child: 
      Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
         Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Navigate back to previous screen
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: const Text(
              'Back',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.normal
              ),
            ),
          ),
        ),
      ),
    ),
    Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: const Text(
            'Servers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.normal
            ),
          ),
        ),
      ),
    ),
  ],
),
       const SizedBox(width: 10.0),
            Container(
              color: const Color(0xFF1F2327),
              padding: const EdgeInsets.all(15.0), // Add left padding of 15 pixels
              child: const Text(
                'All Servers',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white, // Assuming white text color on the dark background
                ),
              ),
            ),

            const SizedBox(height: 10),
          CheckboxListTile(
            contentPadding: const EdgeInsets.all(20.0),
            dense: true,
            selected: true,
            side: const BorderSide(color: Colors.white),
            value: checkboxValue1,
            onChanged: (bool? value) {
              setState(() {
                checkboxValue1 = value!;
              });
            },
            title: const Text('Annies',
             style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.normal
              ),
            ),
           
          ),
          const Divider(
            height: 1,
            color: Colors.grey, // Optionally, you can set the color of the divider
          ),
          CheckboxListTile(
            contentPadding: const EdgeInsets.all(20.0),
            dense: true,
            selected: true,
            side: const BorderSide(color: Colors.white),
            value: checkboxValue2,
            onChanged: (bool? value) {
              setState(() {
                checkboxValue2 = value!;
              });
            },
            title: const Text('Heskin',
             style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.normal
              ),
            ),
           
          ),
          const Divider(
            height: 1,
            color: Colors.grey, // Optionally, you can set the color of the divider
          ),
          CheckboxListTile(
            shape: const CircleBorder(),
            contentPadding: const EdgeInsets.all(20.0),
            dense: true,
            selected: true,
            side: const BorderSide(color: Colors.white),
            value: checkboxValue3,
            onChanged: (bool? value) {
              setState(() {
                checkboxValue3 = value!;
              });
            },
            title: const Text('Fifi',
             style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.normal
              ),
            ),
           
          ),
          const Divider(
            height: 1,
            color: Colors.grey, // Optionally, you can set the color of the divider
          ),

      
        // const SizedBox(height: 40),
        //  ElevatedButton(
        //           child: const Text('Book Table'),
        //           onPressed: () {
        //             Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => SelectClubScreen()),
        //           );
        //           },
        //           style: ElevatedButton.styleFrom(
        //             backgroundColor: Colors.purple,
        //             padding:
        //                 const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(15.0),
        //             ),
        //             minimumSize: const Size(375, 40),
        //             textStyle: const TextStyle(
        //               fontSize: 15,
        //               fontWeight: FontWeight.normal,
        //             ),
        //           ),
        //         ),
      ],
    ),
      ),
    );
  }
}



