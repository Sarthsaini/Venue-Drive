// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https; 
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:venue_drive/CommonFiles/common.dart';
import 'package:venue_drive/dashboard.dart';
import 'package:venue_drive/select_club.dart';
import 'package:venue_drive/table_selections.dart';
import 'package:intl/intl.dart';


class Event {
  final String assetImage; 
  final String title;
  final String description;
  final Color backgroundColor;

  const Event({
    required this.assetImage,
    required this.title,
    required this.description,
    required this.backgroundColor,
  });
}

// ignore: camel_case_types
class reservationScreen extends StatefulWidget {
  const reservationScreen({Key? key}) : super(key: key);

  @override
  State<reservationScreen> createState() => _ClubDetailScreenState();
}


class _ClubDetailScreenState extends State<reservationScreen> {
  
  int _selectedIndex = 0;
  int selectedRadio = 1;
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _selectedBookingNote;
  String? _additionalNotes;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _selectedTable;
  String? _selectedSection;
  bool _sectionDropdownEnabled = false;
  String formatTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final time = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  return DateFormat.Hm().format(time);
}
String formatDate(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}


  final TextEditingController _dobTextController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  int _totalGuests = 0;
  

 
  DateTime? _selectedDate;
  DateTime? _selectedDOB;
  TimeOfDay? _selectedTime;
 
  Map<String, List<String>> _tableNamesBySection = {};
  
 
  void _onDOBSelected(DateTime selectedDate) {
 
  String formattedDate = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
  
   setState(() {
    _dobTextController.text = formattedDate;
  });
}


  Future<void> _selectDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null && picked != _selectedDOB) {
      setState(() {
        _selectedDOB = picked;
      });
     
      _onDOBSelected(_selectedDOB!);
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
 Future<void> fetchData() async {
  // try {
  //   var response = await https.get(Uri.parse('$baseUrl/data-table?venue_id=25'));
  //   if (response.statusCode == 200) {
      
  //     var data = jsonDecode(response.body);

    
  //     if (data.containsKey('data') && data['data'] is List) {
      
  //       for (var section in data['data']) {
        
  //         var sectionName = section['section_name'];
  //         var tables = section['tables'];

          
  //         List<String> tableNames = [];
  //         for (var table in tables) {
  //           tableNames.add(table['table_name']);
  //         }

         
  //         _tableNamesBySection[sectionName] = tableNames;
  //       }

       
  //       setState(() {});
  //     } else {
  //       print('Unexpected data format: $data');
  //     }
  //   } else {
  //     print('Failed to fetch data: ${response.statusCode}');
  //   }
  // } catch (e) {
  //   print('Error fetching data: $e');
  // }
}
@override
void initState() {
  super.initState();
  StripePayment.setOptions(
    StripeOptions(publishableKey: "YOUR_PUBLISHABLE_KEY_HERE"),
  );
  fetchData();
}





  

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
      body:SingleChildScrollView(
        child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [ Container(
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
       Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleSwitch(
                    minHeight: 50,
                    minWidth: 150.0,
                    cornerRadius: 20.0,
                    activeBgColors: [
                      [Colors.white],
                      [Colors.white]
                    ],
                    activeFgColor: const Color(0xFF4E1B97),
                    inactiveBgColor: const Color(0xFFC399FF),
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: _selectedIndex,
                    totalSwitches: 2,
                    labels: ['Reservation', 'Venue Map'],
                    radiusStyle: true,
                    onToggle: (index) {
                      setState(() {
                        _selectedIndex = index!;
                      });
                    },
                  ),
                ],
              ),
            ),
            IndexedStack(
              index: _selectedIndex,
              children: [
                _buildReservationForm(),
                Container(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/rectangle.png',
                          fit: BoxFit.fitWidth,
                          height: 426,
                          width: 333,
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        ]
      )
      
        
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
       // ignore: no_leading_underscores_for_local_identifiers
       int? _selectedTable;
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
            value: _selectedTable,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
            underline: Container(),
            items: const [],
            onChanged: (int? value) {
              setState(() {
                _selectedTable = value;
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
              value: _selectedTable,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
              underline: Container(),
              items: const [],
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
            value: _selectedTable,
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
            items: const [],
            onChanged: (int? value) {
              setState(() {
                _selectedTable = value;
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
 

Future<void> _handlePayment(BuildContext context) async {
  try {
    var generalSettingResponse = await https.get(Uri.parse('$baseUrl/generalsetting?venue_id=25'));
    if (generalSettingResponse.statusCode == 200) {
      var generalSettingData = jsonDecode(generalSettingResponse.body);
      var paymentType = generalSettingData['payment_type'];

      if (paymentType == 'Cash') {
        await _submitBooking(context);
      } else if (paymentType == 'Online by Stripe Payment Gateway') {
        await _handleOnlinePayment(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid payment type')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch general setting')),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $error')),
    );
  }
}

Future<void> _handleOnlinePayment(BuildContext context) async {
  // Handle online payment logic here
  try {
    PaymentMethod paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    );
    var paymentIntentResponse = await https.post(
      Uri.parse('$baseUrl/create-payment-intent'),
      body: jsonEncode({
        'amount': '', // Set the amount according to your requirements
        'secretKey': '',
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (paymentIntentResponse.statusCode == 200) {
      var paymentIntent = jsonDecode(paymentIntentResponse.body);
      var clientSecret = paymentIntent['client_secret'];

      var stripeResponse = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: clientSecret,
          paymentMethodId: paymentMethod.id,
        ),
      );

      if (stripeResponse.status == 'succeeded') {
        _submitBooking(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create payment intent')),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $error')),
    );
  }
}

Future<void> _submitBooking(BuildContext context) async {
  try {
    var venueId = 1;
    var eventId = 1;
    var url = "$baseUrl/booking";
    var response = await https.post(
      Uri.parse(url),
      body: jsonEncode({
        'venue_id': venueId,
        'event_id': eventId,
        'email': _email,
        'phone': _phoneNumber,
        'arrival_time': formatTimeOfDay(_selectedTime!),
        'first_name': _firstName,
        'last_name': _lastName,
        'dob': formatDate(_selectedDOB!),
        'no_of_seats': _totalGuests,
        'location': _selectedSection,
        'date': formatDate(_selectedDate!),
        'booking_note': _selectedBookingNote,
        'additionalNotes': _additionalNotes,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking successful')),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking failed')),
      );
    }
  } catch (e) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error submitting booking')),
    );
     print('Response: ${e}');
  }
}






 

    Widget _buildReservationForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Container(
         color:  Colors.transparent,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
           const SizedBox(height: 20.0),
      

Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          padding: const EdgeInsets.only(left: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: _selectedDate != null ? Colors.white : Colors.white), 
          ),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Date",
              labelStyle: TextStyle(color: _selectedDate != null ? Colors.white : Colors.white), 
              border: InputBorder.none,
            ),
            style: TextStyle(color: _selectedDate != null ? Colors.white : Colors.white),
            controller: _selectedDate != null ? TextEditingController(text: DateFormat('yyyy-MM-dd').format(_selectedDate!)) : null,
             onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      ).then((pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                       
                        setState(() {
                          _autovalidateMode = AutovalidateMode.always;
                        });
                      });
                    },
                    validator: (value) {
                      if (_selectedDate == null) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
   Expanded(
  child: Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Container(
      padding: const EdgeInsets.only(left: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white), 
      ),
      child:DropdownButtonFormField<String>(
  decoration: const InputDecoration(
    labelText: "Table Selection",
    labelStyle: TextStyle(color: Colors.white),
    border: InputBorder.none,
  ),
  dropdownColor: Colors.grey[800],
  style: const TextStyle(color: Colors.white),
  value: _selectedTable,
  onChanged: (newValue) {
    setState(() {
      _selectedTable = newValue;
      
      
      _selectedSection = _tableNamesBySection.entries
          .firstWhere((entry) => entry.value.contains(newValue))
          .key;
      
      _sectionDropdownEnabled = true;
    });
  },
  items: _tableNamesBySection.values.expand((tables) => tables).map<DropdownMenuItem<String>>((tableName) {
    return DropdownMenuItem<String>(
      value: tableName,
      child: Text(tableName),
    );
  }).toList(),
),
    ),
  ),
),
    

  ],
),


const SizedBox(height: 10),
            // First Name field
           Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
  child: Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: Container(
      padding: const EdgeInsets.only(left: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white), 
      ),
      child: DropdownButtonFormField<String>(
  decoration: const InputDecoration(
    labelText: "Preffered Section",
    labelStyle: TextStyle(color: Colors.white),
    border: InputBorder.none,
  ),
  dropdownColor: Colors.grey[800],
  style: const TextStyle(color: Colors.white),
  value: _selectedSection,
  onChanged: _sectionDropdownEnabled ? (newValue) {
    setState(() {
      _selectedSection = newValue;
    });
  } : null, 
  onTap: () {
    if (!_sectionDropdownEnabled) {
      FocusScope.of(context).requestFocus(new FocusNode()); 
    }
  },
  items: _sectionDropdownEnabled ? _tableNamesBySection.keys.map<DropdownMenuItem<String>>((String section) {
    return DropdownMenuItem<String>(
      value: section,
      child: Text(section),
    );
  }).toList() : [],
),
    ),
  ),
),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          padding: const EdgeInsets.only(left: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: _selectedTime != null ? Colors.white : Colors.white),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Time",
              labelStyle: TextStyle(color: _selectedTime != null ? Colors.white : Colors.white), 
              border: InputBorder.none, 
            ),
            style: TextStyle(color: _selectedTime != null ? Colors.white : Colors.white), 
            controller: _selectedTime != null ? TextEditingController(text: _selectedTime!.format(context)) : null,
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then((pickedTime) {
                if (pickedTime != null) {
                  setState(() {
                    _selectedTime = pickedTime;
                  });
                }
              });
            },
            validator: (value) {
              if (_selectedTime == null) {
                return 'Please select a time';
              }
              return null;
            },
          ),
        ),
      ),
    ),
    

  ],
),
            const SizedBox(height: 10.0),
           Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          padding: const EdgeInsets.only(left: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white), 
          ),
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: "First Name",
              labelStyle: TextStyle(color: Colors.white), 
              border: InputBorder.none, 
            ),
            style: const TextStyle(color: Colors.white), 
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _firstName = value;
              });
            },
          ),
        ),
      ),
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          padding: const EdgeInsets.only(left: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white), 
          ),
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: "Last Name",
              labelStyle: TextStyle(color: Colors.white), 
              border: InputBorder.none, 
            ),
            style: const TextStyle(color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _lastName = value;
              });
            },
          ),
        ),
      ),
    ),
  ],
),
const SizedBox(height:10),
Row(
  children: [
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
          ),
        ),
      ),
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Phone Number",
                labelStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
            ),
          ),
        ),
      ),
    ),
  ],
),

            const SizedBox(height: 8.0),
            // Contact Number field
          Padding(
  padding: const EdgeInsets.only(top: 10.0),
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(5.0),
    ),
    child:Padding(
  padding: const EdgeInsets.only(left: 10.0),
  child: TextFormField(
      controller: _dobTextController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Date of Birth",
        labelStyle: const TextStyle(color: Colors.white),
        border: InputBorder.none,
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          color: Colors.white,
          onPressed: () => _selectDOB(context),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (_dobTextController.text.isEmpty) {
          return 'Please select your date of birth';
        }
        return null;
      },
    ),
  ),
),
          ),
            
Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Booking Note",
                    labelStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                  dropdownColor: Colors.grey[800],
                  style: const TextStyle(color: Colors.white),
                  value: _selectedBookingNote,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedBookingNote = newValue!;
                      // Add logic here to show/hide the text area field based on the selected value
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a booking note';
                    }
                    return null;
                  },
                  items: <String>[
                    'Option 1',
                    'Option 2',
                    'Option 3',
                    'other',
                    // Add more options as needed
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _selectedBookingNote == 'other', // Show when 'other' is selected
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Additional Notes",
                      labelStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      // Add validation logic if needed
                      return null;
                    },
                    onChanged: (value) {
                        setState(() {
                          _additionalNotes = value;
                        });
                      }, 
                  ),
                ),
              ),
            ),
          ),


// Total Guest field
Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _totalGuests = (_totalGuests - 1).clamp(0, 999);
                  _controller.text = _totalGuests.toString();
                });
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: "Total Guest", // Updated labelText
                    labelStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _totalGuests = int.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _totalGuests = (_totalGuests + 1).clamp(0, 999);
                  _controller.text = _totalGuests.toString();
                });
              },
            ),
          ],
        ),
      ),
    ),

            const SizedBox(height: 16.0),
            ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      _handlePayment(context); // Call payment method before submitting the booking
    }
  },
  child: const Text("Book Ticket"),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF4E1B97),
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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

          ],
        ),
      ),
    );
  }
}
  



