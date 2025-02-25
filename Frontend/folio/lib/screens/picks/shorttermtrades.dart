import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:folio/screens/stock/stock_basic_info_screen.dart';

class ShortTermTrades extends StatefulWidget {
  const ShortTermTrades({Key? key}) : super(key: key);

  @override
  State<ShortTermTrades> createState() => _ShortTermTradesState();
}

class _ShortTermTradesState extends State<ShortTermTrades> {
  final LocalStorage myStorage = LocalStorage('fintech');
  String _stockCode = "";

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
      ));
    }
  }

  stocktabs(context, company, logo, lastprice, symbol) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _stockCode = symbol;
        });
        _sendDetails();
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
                  child: SvgPicture.network(logo),
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
                        company,
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
                        "Price: ₹ $lastprice",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Trueno",
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ]),
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Short Term Picks',
          style: TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              fontFamily: "Trueno"),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.white,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 0,
                  left: 15,
                  right: 15,
                  bottom: 10,
                ),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  stocktabs(
                      context,
                      "Bajaj Finserv Ltd.",
                      "https://s3-symbol-logo.tradingview.com/bajaj-finserv--big.svg",
                      "16749.00",
                      "BAJAJFINSV"),
                  const SizedBox(height: 20),
                  stocktabs(
                      context,
                      "Maruti Suzuki India Ltd.",
                      "https://s3-symbol-logo.tradingview.com/maruti-suzuki-india--big.svg",
                      "7557.95",
                      "MARUTI"),
                  const SizedBox(height: 20),
                  stocktabs(
                      context,
                      "UltraTech Cement Ltd.",
                      "https://s3-symbol-logo.tradingview.com/ultratech-cement--big.svg",
                      "6837.00",
                      "ULTRACEMCO"),
                  const SizedBox(height: 20),
                  stocktabs(
                      context,
                      "Tech Mahindra Ltd.",
                      "https://s3-symbol-logo.tradingview.com/mahindra-tech--big.svg",
                      "1448.75",
                      "TECHM"),
                  const SizedBox(height: 20),
                  stocktabs(
                      context,
                      "Infosys Ltd.",
                      "https://s3-symbol-logo.tradingview.com/infosys--big.svg",
                      "1814.6",
                      "INFY"),
                  const SizedBox(height: 20),
                  stocktabs(
                      context,
                      "Tata Consultancy Services Ltd.",
                      "https://s3-symbol-logo.tradingview.com/tata--big.svg",
                      "3685.65",
                      "TCS"),
                  const SizedBox(height: 20),
                  stocktabs(
                      context,
                      "Britannia Industries Ltd.",
                      "https://s3-symbol-logo.tradingview.com/britannia--big.svg",
                      "3482.64",
                      "BRITANNIA"),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
