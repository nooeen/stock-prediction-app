import 'package:flutter/material.dart';
import 'package:folio/screens/picks/dividendstars.dart';
import 'package:folio/screens/picks/longtermtrades.dart';
import 'package:folio/screens/picks/mediumtermtrades.dart';
import 'package:folio/screens/picks/shorttermtrades.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';

class PicksScreen extends StatefulWidget {
  const PicksScreen({Key? key}) : super(key: key);

  @override
  State<PicksScreen> createState() => _PicksScreenState();
}

class _PicksScreenState extends State<PicksScreen> {
  final LocalStorage myStorage = LocalStorage('fintech');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.white,
          child: Column(children: [
            Container(
              color: Colors.white,
              child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                    top: 25,
                    left: 25,
                    right: 15,
                    bottom: 5,
                  ),
                  child: const Text(
                    'Top Picks',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Trueno",
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 23,
                    left: 15,
                    right: 15,
                    bottom: 10,
                  ),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    pickstabs(
                        context,
                        "Short Term Picks",
                        "assets/images/stopwatch_red.png",
                        "1 Day to 3 Weeks",
                        "Risky Trades With a High Upside\nPotential",
                        const ShortTermTrades()),
                    const SizedBox(height: 20),
                    pickstabs(
                        context,
                        "Medium Term Picks",
                        "assets/images/stopwatch_yellow.png",
                        "1 Months to 3 Months",
                        "Money Making Opportunities\nWith Low Risk",
                        const MediumTermTrades()),
                    const SizedBox(height: 20),
                    pickstabs(
                        context,
                        "Long Term Picks",
                        "assets/images/stopwatch_green.png",
                        "3 Months to 1 Year",
                        "Safe Trades With a Very Low\nRisk",
                        const LongTermTrades()),
                    const SizedBox(height: 20),
                    pickstabs(
                        context,
                        "Dividend Stars",
                        "assets/images/MoneyBag.png",
                        "3 Months to 1 Year",
                        "Safe Companies With a High\nDividend Yield",
                        const DividendStars()),
                  ]),
                ),
              ]),
            )
          ]),
        ),
      ),
    );
  }
}

pickstabs(context, name, logo, duration, description, child) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.rightToLeft,
          child: child,
        ),
      );
    },
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 15,
      ),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                alignment: Alignment.center,
                child: Image.asset("$logo"),
                width: 80,
              ),
            ),
            Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "Trueno",
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Duration: $duration",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Trueno",
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "$description",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: "Trueno",
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.none,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                ]),
          ]),
    ),
  );
}
