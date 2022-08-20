import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InfoCard extends StatelessWidget {
  InfoCard({this.type, this.date, this.amount, this.cardColor});
  final type;
  final amount;
  final date;
  Color? cardColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(13))),
          height: 172,
          // width: 172,
          child: Column(
            children: [
              Container(
                height: 50,
                // width: 172,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13)),
                ),
                child: Center(
                    child: Text(
                  type,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SF Compact Display',
                      fontSize: 14,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w700),
                )),
              ),
              SizedBox(
                height: 7,
              ),
              SvgPicture.asset(
                'assets/images/wallet.svg',
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      'EGP',
                      style: TextStyle(
                          fontFamily: 'SF Compact Display',
                          color: Color(0xff9A9A9A)),
                    ),
                  ),
                  Text(
                    amount,
                    style: TextStyle(
                        fontSize: 42,
                        fontFamily: 'SF Compact Display',
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Text(
                'Last update $date',
                style: TextStyle(
                    fontFamily: 'SF Compact Display',
                    fontSize: 10,
                    color: Color(0xff9A9A9A)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
