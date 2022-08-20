import 'package:flutter/material.dart';

class SlaveCard extends StatelessWidget {
  SlaveCard({this.date, this.amount, this.username, this.slaveColor});
  final username;
  final amount;
  final date;
  Color? slaveColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        color: Colors.transparent,
        height: 300,
        width: 134,
        child: Stack(
          children: [
            Positioned(
              top: 30,
              child: Column(
                children: [
                  Container(
                      height: 91,
                      width: 134,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,

                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: slaveColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(13),
                            topRight: Radius.circular(13)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            username.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SF Compact Display',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Total Spending',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SF Compact Display',
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      )),
                  Container(
                      height: 91,
                      width: 134,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(13),
                            bottomLeft: Radius.circular(13)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RotatedBox(
                                quarterTurns: -1,
                                child: Text(
                                  'EGP',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SF Compact Display',
                                      color: Colors.black),
                                ),
                              ),
                              Text(
                                amount.toString(),
                                style: TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'SF Compact Display',
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Last spend ${date.toString()}',
                            style: TextStyle(
                                fontFamily: 'SF Compact Display',
                                fontSize: 10,
                                color: Colors.black),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Positioned(
                left: 35,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/images/profileImage.png'),
                )),
          ],
        ),
      ),
    );
  }
}
