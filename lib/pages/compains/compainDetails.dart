import 'dart:async';
import 'dart:collection';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_state/flutter_phone_state.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pharmas/Model/compainListModel.dart';
import 'package:pharmas/Response/registerResponse.dart';
import 'package:pharmas/lang/localss.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class compainDetails extends StatefulWidget {
  final compainAllList compainItem;

  compainDetails(this.compainItem);

  @override
  _compainDetails createState() => new _compainDetails();
}

class _compainDetails extends State<compainDetails> {
  String isSlected = '0';
  var fromdate = GlobalKey<FormState>();
  String dateD;
  ProgressDialog pr;
  SpecificLocalizationDelegate _specificLocalizationDelegate;
  String langSave;
  Future navigationPage() async {
    var preferences = await SharedPreferences.getInstance();

    langSave = preferences.getString('lang');
    print("lang saved == $langSave");
    //langSave=lang1;
    if (langSave == 'ar') {
      _specificLocalizationDelegate =
          SpecificLocalizationDelegate(new Locale("ar"));

      AppLocalizations.load(new Locale("ar"));


    } else {
      _specificLocalizationDelegate =
          SpecificLocalizationDelegate(new Locale("en"));
      AppLocalizations.load(new Locale("en"));


    }
  }
  intl.DateFormat dateFormat ;

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat  =intl.DateFormat(("dd-MM-yyyy"));
    navigationPage();
    print(widget.compainItem);
    // getValueString();
    pr = new ProgressDialog(context);
    pr.update(
      progress: 50.0,
      message: AppLocalizations().lbWait,
      progressWidget: Container(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.praimarydark))),
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    //  navigationPage();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  leading: GestureDetector(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    //centerTitle: true,

                    background: widget.compainItem.Icon == null
                        ? Center(
                            child: Column(children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(20),
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/compains.png',
                                    ),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ]))
                        : Center(
                            child: Column(children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(20),
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      'http://mypharma-order.com/files/images/manufacturers/large/' +
                                          widget.compainItem.Icon,
                                    ),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ])),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        widget.compainItem.compainName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.praimarydark),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
                        child: Text(
                          '(' + widget.compainItem.City +  ')',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.praimarydark),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 1,
                    color: Colors.greyapp,
                  ),
                  widget.compainItem.Address == "null"
                      ? Visibility(
                          visible: false,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.location_city,color:Colors.praimarydark),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        widget.compainItem.City,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: Text(
                                          widget.compainItem.Address,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Visibility(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.location_city,color:Colors.praimarydark),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        widget.compainItem.City,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: Text(
                                          widget.compainItem.Address,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          visible: true,
                        ),
                  widget.compainItem.Address == "null"
                      ? Visibility(
                          child: Divider(
                            height: 1,
                            color: Colors.greyapp,
                          ),
                          visible: false,
                        )
                      : Visibility(
                          child: Divider(
                            height: 1,
                            color: Colors.greyapp,
                          ),
                          visible: true,
                        ),
                  widget.compainItem.phones == "null"
                      ? Visibility(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  children: <Widget>[
                                    Image.asset('assets/images/phone.png'),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 15, 0, 15),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            widget.compainItem.phones,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.greyapp,
                              ),
                            ],
                          ),
                          visible: false,
                        )
                      : GestureDetector(child: Visibility(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            children: <Widget>[
                              Image.asset('assets/images/phone.png'),
                              Padding(
                                padding:
                                EdgeInsets.fromLTRB(0, 15, 0, 15),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      widget.compainItem.phones,textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.greyapp,
                        ),
                      ],
                    ),
                    visible: true,
                  ),onTap: (){
                    _initiateCall(widget.compainItem.phones);
                  },),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                AppLocalizations().lbWD,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.praimarydark),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text(
                                  '8:30 - 4:00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          height: MediaQuery.of(context).size.height,
        )
      ],
    ));
  }
  _initiateCall(String _phoneNumber) {
    if (_phoneNumber?.isNotEmpty == true) {
      setState(() {
        FlutterPhoneState.startPhoneCall(_phoneNumber);
      });
    }
  }
}
