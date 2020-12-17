import 'package:flutter/material.dart';
import 'package:Bitcoin/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'network.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String btc,eth,ltc;
  String selectedCurrency = "USD";

  DropdownButton<String> androidDropdown(){
    List<DropdownMenuItem<String>>dropDownItems = [];
    for(String currency in currenciesList){
      var newItem = new DropdownMenuItem(child: Center(child: Text(currency, style: TextStyle(color: Colors.white),)),value: currency,);
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownItems,
        onChanged: (value) async{
          setState(() {
            selectedCurrency = value;
            getUSD();
          });
          print(value);
        });
  }

  Future<void> getUSD() async{
    Networking btc = Networking("https://apiv2.bitcoinaverage.com/indices/global/ticker/${cryptoList[0]}$selectedCurrency");
    Networking eth = Networking("https://apiv2.bitcoinaverage.com/indices/global/ticker/${cryptoList[1]}$selectedCurrency");
    Networking ltc = Networking("https://apiv2.bitcoinaverage.com/indices/global/ticker/${cryptoList[2]}$selectedCurrency");
    var _btc = await btc.getData();
    var _eth = await eth.getData();
    var _ltc = await ltc.getData();
    print(_btc);
    setState(() {
      this.btc = _btc.toString();
      this.eth = _eth.toString();
      this.ltc = _ltc.toString();
    });
  }

  CupertinoPicker iosPicker(){
    List<Text> pickerItems = [];
    for(String items in currenciesList){
      pickerItems.add(new Text(items, style: new TextStyle(color: Colors.white),));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getUSD();
        });
    },
      children: pickerItems,);
  }
  List<Text> getPickerItems(){
    List<Text> pickerItems = [];
    for(String items in currenciesList){
      pickerItems.add(Text(items, style: new TextStyle(color: Colors.white),));
    }
    return pickerItems;
  }


  @override
  void initState(){
    super.initState();
    getUSD();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $btc $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $eth $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $ltc $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: Platform.isIOS ? iosPicker():Platform.isAndroid?androidDropdown():null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}