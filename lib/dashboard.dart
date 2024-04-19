import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:venue_drive/CommonFiles/common.dart';
import 'package:venue_drive/login.dart';
import 'package:venue_drive/reservation.dart';
import 'package:venue_drive/select_club.dart';
import 'package:venue_drive/table_selections.dart';



class SalesDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  // Define a list to hold event names
  List<Map<String, dynamic>> _eventNames = [];

  String? _selectedEvent;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
// Define variables to hold event data
int _reservationsCount = 0;
String _reservations = '0/0';
String _minsReservations = '\$0.00';
String _totalSpentReservations = '\$0.00';
String _prepaidReservations = '\$0.00';

int _admissionsCount = 0;
String _admissions = '0/0';
String _totalSpentAdmissions = '\$0.00';
String _prepaidAdmissions = '\$0.00';

@override
void initState() {
  super.initState();
  // Call the API when the widget is initialized
  fetchEventData();
  fetchAllEvents();
}

Future<void> fetchAllEvents() async {
    try {
     var venueId = 25;
      var url = "$baseUrl/get_all_events?venue_id=$venueId"; 
      var response = await https.get(Uri.parse(url));

      if (response.statusCode == 200) {
  var data = jsonDecode(response.body);
  List<dynamic> events = data['data'];
  List<Map<String, dynamic>> eventNames = [];
  for (var event in events) {
    String eventName = event['name'];
    int eventId = event['id'];
    eventNames.add({'name': eventName, 'id': eventId});
  }
  setState(() {
    _eventNames = eventNames;
  });
  print('Event names: $_eventNames');
}
 else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch event names')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print('Error: $e');
    }
  }



// Method to fetch event data from the API
Future<void> fetchEventData() async {
  try {
    var venueId = 39;
    var url = '$baseUrl/particular-event-info?venue_id=$venueId';
    var response = await https.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Check if response body is not null or empty
      if (response.body != null && response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        
        setState(() {
          _reservationsCount = data['total_booking'] ?? 0;
          _reservations = '$_reservationsCount/$_reservationsCount';
          _minsReservations = '\$${data['event_price'] ?? 0}';
          _totalSpentReservations = '\$${data['total_spend'] ?? 0}';
          _prepaidReservations = '\$${data['total_amount_by_card'] ?? 0}';
          _admissionsCount = data['total_booking_by_card'] ?? 0;
          _admissions = '$_admissionsCount/$_admissionsCount';
          _totalSpentAdmissions = '\$${data['total_spend'] ?? 0}';
          _prepaidAdmissions = '\$${data['total_amount_by_card'] ?? 0}';
        });
        print('response: $response');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Response body is empty')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
    print('Error: $e');
  }
}




void showAdmissionDetails(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
      builder: (BuildContext context) {
       int? selectedTable;
  return SizedBox( 
        height: MediaQuery.of(context).size.height * 0.9,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        child: Container(
          color: const Color(0xFF1C1D23),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
      
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50,
            width: 30,),
            Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
            
          ],
        ),
        const Divider(
            height: 1,
            color: Colors.grey, 
          ),
       
        Container(
  color: const Color(0xFF1C1D23),
  child: Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
         
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                "assets/images/event.png",
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Jo Malone London's Mother's Day Presents",
                    style: TextStyle(fontSize: 18.0,color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  Text("Radius Gallery. Santa Cruz, CA",style: TextStyle(fontSize: 12.0,color: Colors.grey,)),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),

        const SizedBox(height:5),
            Container(
              color: const Color(0xFF1F2327), 
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 10.0),
             
                child: 
                 
                  const Text(
                    'Admission Type',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white, 
                    ),
                  ),
                
              ),
          

            const SizedBox(height: 10),
        
        Row(
          children: [
            const SizedBox(width: 30),
            const Icon(Icons.table_bar, size:20, color: Colors.white),
            const SizedBox(width: 10),
            const Text(
              'GUEST LIST',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
            ),
            const Spacer(),
           DropdownButton<int>(
            value: selectedTable,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
            underline: Container(),
            items: [],
            onChanged: (int? value) {
              setState(() {
                selectedTable = value;
              });
            },
          ),
            const SizedBox(width: 30,),
          ],
        ),
        const SizedBox(height: 10,),
       Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0), 
        child: const Divider(
          height: 1,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 10,),


      
        Row(
          children: [
            const SizedBox(width: 30),
            const Icon(Icons.access_time, size:20, color: Colors.white),
            const SizedBox(width: 10),
           const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TICKET',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
              ),
              Text(
                'Send Tickets And Check In With Scanner',
                style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.normal, color: Colors.grey),
              ),
            ],
          ),
            const Spacer(),
             DropdownButton<int>(
              value: selectedTable,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
              underline: Container(),
              items: [],
              onChanged: (int? value) {
              },
            ),
            const SizedBox(width: 30,),
            
                        
            
          ],
        ),
        const SizedBox(height: 10,),
        Container(
              color: const Color(0xFF1F2327),
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 10.0),
             
                child: 
                 
                  const Text(
                    'Admission',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white, 
                    ),
                  ),
                
              ),
          

            const SizedBox(height: 10),
        
        Row(
          children: [
            const SizedBox(width: 30),
            const Icon(Icons.money, size:20, color: Colors.white),
            const SizedBox(width: 10),
            const Text(
              'COVER',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
            ),
            const Spacer(),
            const Row(
            children: [
              Text(
                '\$ 0.00',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
              ),
            
            ],
          ),
           DropdownButton<int>(
            value: selectedTable,
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const table_selections()),
                );
              },
              child: const Icon(Icons.arrow_right, color: Colors.white),
            ),
            underline: Container(),
            items: [],
            onChanged: (int? value) {
              setState(() {
                selectedTable = value;
              });
            },
          ),
            const SizedBox(width: 30,),
          ],
        ),
        const SizedBox(height: 10,),
        
        Container(
              color: const Color(0xFF1F2327),
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 10.0),
             
                child: 
                 
                  const Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white, 
                    ),
                  ),
                
              ),
              const SizedBox(height: 20),
              const Row(
  children: [
    SizedBox(width: 30),
    Icon(Icons.mail, color: Colors.white),
    SizedBox(width: 10),
    Text(
      'SEND CONFIRMATION MAIL',
      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
    ),
  ]
              ),
              const SizedBox(height: 20),
              Row(
                children: [
    Expanded(
      child: Container(
        height:120,
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const TextField(
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'Notes',
            filled: true,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
           ),
        ),
      ),
    ),
  ],
),
        const SizedBox(height: 15),
         ElevatedButton(
                  child: const Text('Book Table'),
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
                    minimumSize: const Size(300, 40),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
      ],
    ),
        ),
        ),
  );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1a181a),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA439FF),
        elevation: 0,
        titleSpacing: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CAKE Nightclub',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            Text(
              'Wed, Nov 8th',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer(); 
          },
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      // backgroundColor: Colors.black,
      body: Column(
      children: [
        Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.only(left: 15.0,right: 15.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: "Event Name", // Change label text
            labelStyle: TextStyle(color: Colors.white), // Text color for the label
            border: InputBorder.none, // Remove input field border
          ),
          dropdownColor: Colors.grey[800],
          style: const TextStyle(color: Colors.white), // Text color for the dropdown text
          value: _selectedEvent,
          onChanged: (newValue) {
            setState(() {
              _selectedEvent = newValue!;
            });
          },
          items: _eventNames.map((event) {
  return DropdownMenuItem<String>(
    value: event['id'].toString(),
    child: Text(event['name']),
  );
}).toList(),
        ),
      ),
    ),
        Expanded(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: 
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL SALES',
                        style: TextStyle(
                          color: Color(0xFF828087),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Reservations ($_reservations)',
                            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mins',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            _minsReservations,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Spent',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            _totalSpentReservations,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Prepaid',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      _prepaidReservations,
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Admissions ($_admissions)',
                      style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Spent',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                     _totalSpentAdmissions,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Prepaid',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      _prepaidAdmissions,
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    ),
    ),
    // ignore: prefer_const_constructors
    SizedBox(height: 100,),
    Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          const Text(
            'No Notes',
            style: TextStyle(
              color: Color(0xFF828087),
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA439FF),
            ),
            child: const Text('Add Note',
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    ),
  ],
),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFA439FF),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Color(0xFFA439FF)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Shae Strachan',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'shae@webdiner.com',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Chat'),
              onTap: () {
                // Navigate to chat screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Team'),
              onTap: () {
                // Navigate to team screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
            ),
            ListTile(
              leading: const Icon(Icons.support),
              title: const Text('Support'),
              onTap: () {
                // Navigate to support screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Version 5.12.0 (8055)'),
              onTap: () {
                // Navigate to info screen
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 56,
        color: const Color(0xFF151215),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const reservationScreen()),
              );
              },
              child: Image.asset(
                'assets/images/reservation.png',
                fit: BoxFit.fitWidth,
                height: 42,
                width: 62,
                alignment: Alignment.center,
              ),
            ),
            GestureDetector(
              onTap: () {
                showAdmissionDetails(context);
              },
              child: Image.asset(
                'assets/images/admissions.png',
                fit: BoxFit.fitWidth,
                height: 42,
                width: 55,
                alignment: Alignment.center,
              ),
            ),
            GestureDetector(
              onTap: () async {
              String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
                '#ff6666', 
                'Cancel',   
                true,       
                ScanMode.BARCODE, 
              );
              print('Scanned barcode: $barcodeScanResult');
            },
              child: Icon(
                CupertinoIcons.barcode_viewfinder,
                size: 42,
                color: _selectedIndex == 2 ? const Color(0xFFA439FF) : Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SalesDashboardPage()),
              );
              },
              child: Image.asset(
                'assets/images/dashboard.png',
                fit: BoxFit.fitWidth,
                height: 42,
                width: 52,
                alignment: Alignment.center,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectClubScreen()),
              );
              },
              child: Image.asset(
                'assets/images/inventory.png',
                fit: BoxFit.fitWidth,
                height: 42,
                width: 45,
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
   
    );
  }
}
