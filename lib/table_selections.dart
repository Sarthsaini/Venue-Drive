import 'package:flutter/material.dart';
import 'package:venue_drive/select_club.dart';


// ignore: camel_case_types
class table_selections extends StatefulWidget {
   const table_selections({Key? key}) : super(key: key);
 

  @override
  State<table_selections> createState() => _TableScreenState();
}

class _TableScreenState extends State<table_selections> {
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Reservation screen widgets (details, table selection, etc.)
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
            'Jo Malone Live',
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
                'All Table',
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
            title: const Text('Table No.12',
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
            title: const Text('Table No.12',
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
            title: const Text('Table No.12',
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

      
        const SizedBox(height: 40),
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
         ElevatedButton(
                  child: const Text('Assign From Map'),
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectClubScreen()),
                  );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    minimumSize: const Size(375, 40),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
        ]
        )
      ],
    ),
      ),
    );
  }
}



