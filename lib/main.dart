import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _formkey = GlobalKey<FormState>();

  final _dropDownItems = ["Rupees", "Dollar", "Pounds"];
  var _currentSelectedItem = "Rupees";
  dynamic _interest = "";
  double principle, rate, terms;
  var _principleController = TextEditingController();
  var _rateController = TextEditingController();
  var _termController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Colors.deepPurple[300],
          primarySwatch: Colors.deepPurple),
      title: "Interest Calculator",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Interest Calculator"),
        ),
        body: Form(
          key: _formkey,
          child: ListView(
            children: [
              Image.asset(
                'icons/bank.png',
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _principleController,
                  onChanged: (value) {
                    _formkey.currentState.validate();
                    principle = double.parse(value);
                  },
                  scrollPadding: EdgeInsets.all(20),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter principle amount";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Principle",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    hintText: "Principle Amount",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _rateController,
                  onChanged: (value) {
                    _formkey.currentState.validate();
                    rate = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter rate";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Rate",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    hintText: "Rate of Interest",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _termController,
                        onChanged: (value) {
                          _formkey.currentState.validate();
                          terms = double.parse(value);
                        },
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter terms amount";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Terms",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: "Terms in Years",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: DropdownButton(
                        items: _dropDownItems.map((String dropdownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropdownStringItem,
                            child: Text(dropdownStringItem),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            _currentSelectedItem = value;
                          });
                        },
                        value: _currentSelectedItem,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlineButton(
                      onPressed: () {
                        setState(() {
                          if (_formkey.currentState.validate()) {
                            _interest =
                                (principle * rate * terms / 100).toString() +
                                    " " +
                                    _currentSelectedItem;
                          }
                        });
                      },
                      child: Text(
                        "Calculate",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.purple[300],
                        ),
                      ),
                    ),
                    OutlineButton(
                      onPressed: () {
                        _principleController.clear();
                        _rateController.clear();
                        _termController.clear();
                      },
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.purple[300],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "Your Interest is : $_interest",
                  style: TextStyle(
                    color: Colors.deepPurple[500],
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
