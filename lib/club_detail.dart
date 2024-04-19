import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as https;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:venue_drive/CommonFiles/common.dart';
import 'package:venue_drive/dashboard.dart';
import 'package:venue_drive/reservation.dart';
import 'package:venue_drive/select_club.dart';
import 'package:venue_drive/table_selections.dart';

class Event {
  final String imageUrl;
  final String name;
  final String organizer;

  Event({
    required this.imageUrl,
    required this.name,
    required this.organizer,
  });
}

class ClubDetailScreen extends StatefulWidget {
  const ClubDetailScreen({Key? key}) : super(key: key);

  @override
  State<ClubDetailScreen> createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends State<ClubDetailScreen> {
  List<Event> events = [];
 
  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    setState(() {
      ShowLoader(context);
    });

    try {
      var venueId = 25;
      var url = "$baseUrl/get_all_events?venue_id=$venueId"; 
      var response = await https.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        List<Event> fetchedEvents = [];
        if (responseData.containsKey('data')) {
          List<dynamic> eventsData = responseData['data'];
          fetchedEvents = eventsData.map((data) {
            return Event(
              imageUrl: data['featured_image'] ?? '',
              name: data['name'] ?? '',
              organizer: data['event_organiser'] ?? '',
            );
          }).toList();
        }
        setState(() {
          events = fetchedEvents;
          HideLoader(context);
        });
      } else {
        print('Failed to fetch events: ${response.reasonPhrase}');
        setState(() {
         HideLoader(context);
        });
      }
    } catch (e) {
      print('Network error: $e');
      setState(() {
       HideLoader(context);
      });
    }
  }


  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

//   void showEventDetails(BuildContext context) {
//     showModalBottomSheet<void>(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(15.0),
//         topRight: Radius.circular(15.0),
//       ),
//     ),
//       builder: (BuildContext context) {
//        int? selectedTable;
//   return SizedBox( 
//         height: MediaQuery.of(context).size.height * 0.9, 
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(15.0),
//             topRight: Radius.circular(15.0),
//           ),
//         child: Container(
//           color: const Color(0xFF1C1D23),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
       
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(height: 50,
//             width: 30,),
//             Text(
//               'Cancel',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14.0,
//               ),
//             ),
           
//           ],
//         ),
//         const Divider(
//             height: 1,
//             color: Colors.grey,
//           ),
       
//         Container(
//   color: const Color(0xFF1C1D23),
//   child: Column(
//     children: [
//       Container(
//         margin: const EdgeInsets.symmetric(vertical: 8.0),
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
         
//         ),
//         child: Row(
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: Image.asset(
//                 "assets/images/event.png",
//                 height: 100.0,
//                 width: 100.0,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 10.0),
//             const Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Jo Malone London's Mother's Day Presents",
//                     style: TextStyle(fontSize: 18.0,color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10,),
//                   Text("Radius Gallery. Santa Cruz, CA",style: TextStyle(fontSize: 12.0,color: Colors.grey,)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   ),
// ),

//         const SizedBox(height:5),
//             Container(
//               color: const Color(0xFF1F2327),
//               padding: const EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 10.0),
             
//                 child: 
                 
//                   const Text(
//                     'Table',
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.normal,
//                       color: Colors.white,
//                     ),
//                   ),
                
//               ),
          

//             const SizedBox(height: 10),
        
//         Row(
//           children: [
//             const SizedBox(width: 30),
//             const Icon(Icons.table_bar, size:20, color: Colors.white),
//             const SizedBox(width: 10),
//             const Text(
//               'TABLE SELECTION ',
//               style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
//             ),
//             const Spacer(),
//            DropdownButton<int>(
//             value: selectedTable,
//             icon: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const table_selections()),
//                 );
//               },
//               child: const Icon(Icons.arrow_drop_down, color: Colors.white),
//             ),
//             underline: Container(),
//             items: [],
//             onChanged: (int? value) {
//               setState(() {
//                 selectedTable = value;
//               });
//             },
//           ),
//             const SizedBox(width: 30,),
//           ],
//         ),
//         const SizedBox(height: 10,),
//        Container(
//         margin: const EdgeInsets.symmetric(horizontal: 30.0), 
//         child: const Divider(
//           height: 1,
//           color: Colors.grey, 
//         ),
//       ),
//       const SizedBox(height: 10,),
//         Row(
//           children: [
//             const SizedBox(width: 30),
//             const Icon(Icons.access_time, size:20, color: Colors.white),
//             const SizedBox(width: 10),
//             const Text(
//               'ARRIVAL TIME',
//               style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
//             ),
//             const Spacer(),
//              DropdownButton<int>(
//               value: selectedTable,
//               icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
//               underline: Container(),
//               items: [],
//               onChanged: (int? value) {
//               },
//             ),
//             const SizedBox(width: 30,),
            
//           ],
//         ),
//         const SizedBox(height: 10,),
//         Container(
//         margin: const EdgeInsets.symmetric(horizontal: 30.0), 
//         child: const Divider(
//           height: 1,
//           color: Colors.grey, 
//         ),
//       ),
//       const SizedBox(height: 10,),
//         Row(
//           children: [
//             const SizedBox(width: 30),
//             const Icon(Icons.person, size:20, color: Colors.white),
//             const SizedBox(width: 10),
//             const Text(
//               'SERVER',
//               style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
//             ),
//             const Spacer(),
//             DropdownButton<int>(
//               value: selectedTable,
//               icon: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => server_selections()),
//                   );
//                 },
//                 child: const Icon(Icons.arrow_drop_down, color: Colors.white),
//               ),
//               underline: Container(),
//               items: [],
//               onChanged: (int? value) {
//               },
//             ),
//             const SizedBox(width: 30,),
//           ],
//         ),
//        const SizedBox(height: 20),
//         Container(
//               color: const Color(0xFF1F2327),
//               padding: const EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 10.0),
             
//                 child: 
                 
//                   const Text(
//                     'Details',
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.normal,
//                       color: Colors.white,
//                     ),
//                   ),
                
//               ),
//               const SizedBox(height: 20),
//               const Row(
//   children: [
//     SizedBox(width: 30),
//     Icon(Icons.mail, color: Colors.white),
//     SizedBox(width: 10),
//     Text(
//       'SEND CONFIRMATION MAIL',
//       style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
//     ),
//   ]
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//     Expanded(
//       child: Container(
//         height:120,
//         margin: const EdgeInsets.symmetric(horizontal: 30.0),
//         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//         decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: const TextField(
//           maxLines: null,
//           decoration: InputDecoration(
//             hintText: 'Notes',
//             filled: true,
//             border: InputBorder.none,
//             hintStyle: TextStyle(color: Colors.grey),
//            ),
//         ),
//       ),
//     ),
//   ],
// ),
//         const SizedBox(height: 15),
//          ElevatedButton(
//                   child: const Text('Book Table'),
//                   onPressed: () {
//                     Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SelectClubScreen()),
//                   );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.purple,
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                     minimumSize: const Size(375, 40),
//                     textStyle: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//       ],
//     ),
//         ),
//         ),
//   );
//       },
//     );
//   }

  void showModal(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Example Dialog'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
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
    return  Scaffold(
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
            
              AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false, 
                title: const Text('CAKE Nightclub'),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(225.0),
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0, bottom: 8.0), 
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Wed Nov 8th',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.calendar_month),
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('This is a snackbar')),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black, 
      body: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.black, 
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey), 
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                style: TextStyle(color: Colors.black), 
                decoration: InputDecoration(
                  border: InputBorder.none, 
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey), 
                ),
              ),
            ),
          ),
            )
          ),
          Container(
            color: Colors.black, 
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Events', 
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                    
                    },
                    child: const Row(
                      children: [
                        Text(
                          'See All', 
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0), 
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.black, 
                ),
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return EventCard(event: events[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
     bottomNavigationBar: Container(
        height: 56,
        color: const Color(0xFF4E1B97),
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
                 _ClubDetailScreenState().showAdmissionDetails(context);
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
                color: _selectedIndex == 2 ? Color(0xFFA439FF) : Colors.white,
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

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       Navigator.push(context, MaterialPageRoute(builder: (context) => const reservationScreen()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white, 
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:event.imageUrl.isEmpty
                        ? Image.network(
                            event.imageUrl,
                            height: 100.0,
                            width: 100.0,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/party.jpg', 
                            height: 100.0,
                            width: 100.0,
                            fit: BoxFit.cover,
                          ),
                  ),
            
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    event.name,
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Text(event.organizer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



