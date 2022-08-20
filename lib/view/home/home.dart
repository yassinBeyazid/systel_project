import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:systel_project/view/home/components/info_card.dart';
import 'package:systel_project/view/home/components/slave_card.dart';

class Home extends StatefulWidget {
  Home({this.username});
  final username;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map> users = [];
  List<Map> userData = [];

  getUsersData() async {
    Database database = await openDatabase('demo.db');
    users = await database.rawQuery('SELECT * FROM Users');
    setState(() {});
    print('list of users = ${users.toString()}');
  }

  String wallet = '0.0';
  String lastActivityAmount = '0.0';
  String lastActivity = '25/5';
  getCurrentUser() async {
    Database database = await openDatabase('demo.db');
    userData = await database
        .query('Users', where: '"name" = ?', whereArgs: [widget.username]);
    print('current user = ${userData.toString()}');
    if (userData.isNotEmpty) {
      setState(() {
        wallet = userData[0]['total'].toString();
        lastActivityAmount = userData[0]['Last_activity_amount'].toString();
        lastActivity = userData[0]['Last_activity'].toString();
      });
    }
  }

  List<Color> _colors = [
    Color(0xffFBB03B),
    Color(0xffD85F5F),
    Color(0xffB13BFB),
  ];
  int colorIndex = -1;
  prepareSlaveCard(String name, String amount, String date) {
    if (colorIndex == 2) {
      colorIndex = 1;
    } else {
      colorIndex++;
    }
    return SlaveCard(
      username: name,
      amount: amount,
      date: date,
      slaveColor: _colors[colorIndex],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsersData();
    getCurrentUser();
  }

  gestures() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.notifications_on_outlined,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(Icons.menu, color: Colors.white)
        ],
      ),
    );
  }

  userInformation() {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/profileImage.png'),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Evening',
                style: TextStyle(
                    fontFamily: 'SF Compact Display',
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                widget.username.toString(),
                style: TextStyle(
                    fontFamily: 'SF Compact Display',
                    fontSize: 24,
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  testBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 37),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            color: Color(0xff5471F1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(
                'Test',
                style: TextStyle(
                    fontFamily: 'SF Compact Display',
                    fontSize: 24,
                    color: Colors.white),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image(image: AssetImage('assets/images/backgroundHome.png')),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                gestures(),
                SizedBox(
                  height: 30,
                ),
                userInformation(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoCard(
                        type: 'YOUR WALLET',
                        amount: wallet,
                        date: lastActivity,
                        cardColor: Color(0xff4E4E4E),
                      ),
                      InfoCard(
                        type: 'LAST ACTIVITY',
                        amount: lastActivityAmount,
                        date: lastActivity,
                        cardColor: Color(0xffA2A2A2),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                testBtn(),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 37),
                  child: Text(
                    'Users',
                    style: TextStyle(
                        fontFamily: 'SF Compact Display',
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 37),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var user in users)
                            prepareSlaveCard(
                                user['name'].toString(),
                                user['total'].toString(),
                                user['last_activity'].toString())
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
