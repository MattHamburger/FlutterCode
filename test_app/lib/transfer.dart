import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import './account_list.dart';

//Dropdown widget begin
class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
    Widget build(BuildContext context) {
      return new InkWell(
        onTap: onPressed,
        child: new InputDecorator(
          decoration: new InputDecoration(
            labelText: labelText,
          ),
          baseStyle: valueStyle,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children:<Widget>[
              new Text(valueText,style:valueStyle),
              new Icon(Icons.arrow_drop_down,
              color:Theme.of(context).brightness == Brightness.light? Colors.grey.shade700:Colors.white70
              ),
            ],
          ),
        ),
      );
    }
}
    class _DateTimePicker extends StatelessWidget {
      const _DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectDate,
     }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
   final ValueChanged<DateTime> selectDate;
  
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDT = await showDatePicker(
      context:context,
      initialDate: selectedDate,
      firstDate: new DateTime(2018,10),
      lastDate: new DateTime(2019)
    );
    if(pickedDT != null && pickedDT != selectedDate){
      selectDate(pickedDT);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return new Row (
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          flex:4,
          child: new _InputDropdown(
            labelText: labelText,
            valueText: selectedDate.month.toString() + "/" + selectedDate.day.toString() + "/" + selectedDate.year.toString(),
             valueStyle: valueStyle,
            onPressed: () { _selectDate(context); },
          ),
        ),
        const SizedBox(width:12.0),
      ],
    );
  }
}
 
//Dropdown widget end

class TransferPage extends StatefulWidget {
   static const String routeName = '/cupertino/alert';

  @override
  _TransferPageState createState()  => new _TransferPageState();
  
}
class _TransferPageState extends State<TransferPage> {
  
  DateTime _transferDate = new DateTime.now();

//Account List
 final  List<Accounts> _actList = <Accounts>[
    new Accounts(
      accountNumber: '00000234567771234',
      accountName: 'Checking Account',
      accountType: 'CHK',
      accountBalance:1423.00
    ),
     new Accounts(
      accountNumber: '0000023456789',
      accountName: 'Checking Account',
      accountType: 'CHK',
      accountBalance:52423.00
    ),
     new Accounts(
      accountNumber: '99990000000234',
      accountName: 'Checking Account',
      accountType: 'CHK',
      accountBalance:99999.99
    ),
     new Accounts(
      accountNumber: '234567777775555',
      accountName: 'Saving Account',
      accountType: 'SAV',
      accountBalance:72423.00
    ),
     new Accounts(
      accountNumber: '400040040004000',
      accountName: 'Saving Account',
      accountType: 'SAV',
      accountBalance:82423.00
    ),
     new Accounts(
      accountNumber: '888888888881999',
      accountName: 'Money Market',
      accountType: 'MMA',
      accountBalance:230009.99
    ),
     new Accounts(
      accountNumber: '1234123412341234',
      accountName: 'DDA Account',
      accountType: 'DDA',
      accountBalance:991423.00
    ),
     new Accounts(
      accountNumber: '40000200005000',
      accountName: 'DDA Account',
      accountType: 'DDA',
      accountBalance:52423.00
    ),
   
  ];
void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
      //TODO
      }
    });
  }
  void _transfer_clicked(){
    
    _validateAmount("");

   setState(() {
        print('Transfer Button CLICKED');
       showDemoDialog<String>(
                context: context,
                child: new CupertinoAlertDialog(
                  title: const Text('Transfer Money?'),
                  actions: <Widget>[
                    new CupertinoDialogAction(
                      child: const Text('Continue'),
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context, 'Continue');
                      CupertinoActivityIndicator();
                        //TODO
                      },
                    ),
                    new CupertinoDialogAction(
                      child: const Text('Cancel'),
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                    ),
                  ],
                ),
              );

      });
 }
 void _cancel_clicked(){
   setState(() {
        print('CANCEL Button CLICKED');
        Navigator.pop(context);

      });
 }

String _validateAmount(String value) {
    if (value.isEmpty)
      return 'Amount is required';
    final RegExp nameExp = new RegExp(r'^[0-9 ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only Numeric characters.';
    return null;
  }

  Accounts _actObj;
 Accounts _actToObj;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       appBar: new AppBar(
          title: const Text('Transfer Money'),

        ),
        body:new DropdownButtonHideUnderline(
          child: new SafeArea(
            top:false,
            bottom:false,
            child: new ListView(
              padding: const EdgeInsets.all(15.0),
              children:<Widget>[
                //
       new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'From Account',
                  hintText: 'Select From Account',
                ),
                //isEmpty: _activity == null,
                child: new DropdownButton<Accounts>(
                  value: _actObj,
                  isDense: true,
                  onChanged: (Accounts newValue) {
                    setState(() {
                      _actObj = newValue;
                    });
                  },
                   items: _actList.map((Accounts actVal) {
                    return new DropdownMenuItem<Accounts>(
                      value: actVal,
                      child: new Text(actVal.accountName + "("+ actVal.accountNumber + ")"),
                    );
                  }).toList(),
                ),
              ),  
               new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'To Account',
                  hintText: 'Select To Account',
                ),
                //isEmpty: _activity == null,
                child: new DropdownButton<Accounts>(
                  value: _actToObj,
                  isDense: true,
                  onChanged: (Accounts newValue) {
                    setState(() {
                      _actToObj = newValue;
                    });
                  },
                   items: _actList.map((Accounts actVal) {
                    return new DropdownMenuItem<Accounts>(
                      value: actVal,
                      child: new Text(actVal.accountName + "("+ actVal.accountNumber + ")"),
                    );
                  }).toList(),
                ),
              ), 
              //       
          new TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                    prefixText: '\$',
                    suffixText: 'USD',
                    suffixStyle: TextStyle(color: Colors.green)
                  ),
                  maxLines: 1,
                  validator: _validateAmount,
          ),
            
               new _DateTimePicker(
                labelText: 'Transfer Date',
                selectedDate: _transferDate,
                selectDate: (DateTime date) {
                  setState(() {
                    _transferDate = date;
                  });
                },
               
              ),
              new TextField(
                enabled: true,
                decoration: const InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(),
                ),
                //style: Theme.of(context).textTheme.display4,
              ),
               new ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new RaisedButton(
                child: const Text('TRANSFER'),
                 onPressed: _transfer_clicked,
                
              ),
              const RaisedButton(
                child: Text('CANCEL'),
                 onPressed: null,
              ),
            ],
          ),
              ],
            ),
          ),
        ),
    );
  }

}

