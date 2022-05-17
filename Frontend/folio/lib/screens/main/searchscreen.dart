import 'package:flutter/material.dart';
import 'package:folio/screens/stock/stock_basic_info_screen.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';

class SearchStock extends StatefulWidget {
  const SearchStock({Key? key}) : super(key: key);

  @override
  State<SearchStock> createState() => _SearchStockState();
}

class _SearchStockState extends State<SearchStock> {
  String _stockCode = "";
  final LocalStorage myStorage = LocalStorage('fintech');

  @override
  void initState() {
    super.initState();
  }

  _sendDetails() async {
    await myStorage.ready;

    const baseURL = 'http://127.0.0.1:8000/api';
    final url = Uri.parse('$baseURL/search/');

    Response response = await post(url, body: {
      'stock': _stockCode.toString(),
      "email": await myStorage.getItem('Email'),
      'purpose': "Search",
    });

    final responseJson = jsonDecode(response.body);
    final responseMessage = responseJson['message'];

    if (responseMessage == "Found") {
      await myStorage.setItem("StockCode", _stockCode);
      await myStorage.setItem("Company", responseJson['company']);
      await myStorage.setItem("Logo", responseJson['logo']);
      await myStorage.setItem("DayPred", responseJson['day']);
      await myStorage.setItem("WeekPred", responseJson['week']);
      await myStorage.setItem("MonthPred", responseJson['month']);
      await myStorage.setItem("LastClose", responseJson['last']);
      Navigator.push(
        context,
        PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.bottomToTop,
          child: const NewStockScreen(),
        ),
      );
    } else if (responseMessage == "Stock Does Not Exist") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Stock Not Found."),
        backgroundColor: Color(0xFFE43434),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  'Find A Stock',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Trueno",
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.only(
                  top: 25,
                  left: 25,
                  right: 25,
                  bottom: 5,
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "Trueno",
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Stock Short Code',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "Trueno",
                    ),
                    helperStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _stockCode = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 35),
              Container(
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 20,
                  right: 20,
                  bottom: 5,
                ),
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    _sendDetails();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 10,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Trueno",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}
