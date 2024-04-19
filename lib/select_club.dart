import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:venue_drive/CommonFiles/common.dart';
import 'package:venue_drive/club_detail.dart';
import 'dart:convert';

class SelectClubScreen extends StatefulWidget {
  @override
  _SelectClubScreenState createState() => _SelectClubScreenState();
}

class _SelectClubScreenState extends State<SelectClubScreen> {
  String selectedClub = '';
  List<Club> clubs = [];
  List<Club> filteredClubs = [];
  

  @override
  void initState() {
    super.initState();
    _fetchClubs();
  }

  Future<void> _fetchClubs() async {
    setState(() {
      ShowLoader(context);
    });
    try {
      var url = "$baseUrl/venue"; 
      var response = await https.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData.containsKey('data')) {
          List<dynamic> clubDataList = responseData['data'];
          setState(() {
            clubs = clubDataList.map((data) => Club.fromJson(data)).toList();
            filteredClubs = List.from(clubs); 
          HideLoader(context);
          });
        } else {
          print('Invalid response format: $responseData');
          setState(() {
           HideLoader(context);
          });
        }
      } else {
        print('Failed to fetch clubs: ${response.reasonPhrase}');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riot Hospitality Group', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF141618),
        
      ),
      body:  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      labelText: 'Search',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabled: true,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredClubs.length,
                    itemBuilder: (context, index) {
                      Club club = filteredClubs[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(club.name, style: TextStyle(color: Colors.white)),
                            subtitle: club.location != null ? Text(club.location!, style: TextStyle(color: Colors.white)) : null,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClubDetailScreen(),
                                ),
                              );
                            },
                            selected: selectedClub == club.name,
                            trailing: Icon(Icons.arrow_right, color: Colors.white),
                          ),
                          Divider(color: Colors.white),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
      backgroundColor: Color(0xFF1E1E1E),
    );
  }
}

class Club {
  final String name;
  final String? location;

  Club({required this.name, this.location});

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      name: json['name'] ?? '',
      location: json['address'] ?? '',
    );
  }
}
