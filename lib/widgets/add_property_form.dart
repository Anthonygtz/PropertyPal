import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:propertypal/utils/appvalidator.dart';

import '../services/db.dart';

class AddPropertyForm extends StatefulWidget {
  const AddPropertyForm({super.key});

  @override
  State<AddPropertyForm> createState() => _AddPropertyFormState();
}

class _AddPropertyFormState extends State<AddPropertyForm> {
  final _propertyName = TextEditingController();
  final _propertyAddress = TextEditingController();
  final _tenantName = TextEditingController();
  final _tenantPhone = TextEditingController();
  final _tenantEmail = TextEditingController();
  final _tenantRent = TextEditingController();


  var db = Db();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var isLoader = false;
  var appValidator = AppValidator();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()){
      setState(() {
        isLoader = true;
      });


      // final user = FirebaseAuth.instance.currentUser;
      // final userDoc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      // int propertyName = userDoc['propertyName'];
      // int propertyAddress = userDoc['propertyAddress'];
      // int propertyType = userDoc['propertyType'];
      // int tenantName = userDoc['tenantName'];
      // int rent = userDoc['rent'];

      var data = {

        'propertyName': _propertyName.text,
        'propertyAddress': _propertyAddress.text,
        'tenantName': _tenantName.text,
        'tenantPhone': _tenantPhone.text,
        'tenantEmail': _tenantEmail.text,
        'tenantRent': _tenantRent.text
      };
      //
      // await authService.login(data, context);
      await db.addProperty(data);


      setState(() {
        isLoader = false;
      });
    }
  }



  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime currentDate = DateTime.now();
    final DateTime lastDate = currentDate.add(Duration(days: 30)); // Adjust this to your desired timeline

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _getFormattedTimeline() {
    if (_startDate != null && _endDate != null) {
      final startDateString = DateFormat.yMMMd().format(_startDate!);
      final endDateString = DateFormat.yMMMd().format(_endDate!);
      return '$startDateString - $endDateString';
    } else {
      return 'Select Timeline';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _propertyName,
                  validator: appValidator.isEmptyCheck,
                  decoration: InputDecoration(
                      labelText: 'Property Name'
                  ),
                ),
                TextFormField(
                  controller: _propertyAddress,
                  validator: appValidator.isEmptyCheck,
                  decoration: InputDecoration(
                      labelText: 'Property Address'
                  ),
                ),
                TextFormField(
                  controller: _tenantName,
                  validator: appValidator.isEmptyCheck,
                  decoration: InputDecoration(
                      labelText: 'Tenant\'s name'
                  ),
                ),
                TextFormField(
                  controller: _tenantPhone,
                  validator: appValidator.isEmptyCheck,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Tenant\'s Phone number'
                  ),
                ),
                TextFormField(
                  controller: _tenantEmail,
                  validator: appValidator.isEmptyCheck,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Tenant\'s Email'
                  ),
                ),
                TextFormField(
                  controller: _tenantRent,
                  validator: appValidator.isEmptyCheck,
                  decoration: InputDecoration(
                      labelText: 'Tenant\'s Rent'
                  ),
                ),
                // TextFormField(
                //   validator: appValidator.isEmptyCheck,
                //   onTap: () {
                //     _selectDate(context, true);
                //   },
                //   readOnly: true,
                //   decoration: InputDecoration(
                //     labelText: 'Timeline',
                //   ),
                //   controller: TextEditingController(text: _getFormattedTimeline()),
                // ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: (){
                      if (isLoader == false){
                        _submitForm();
                      }
                    },
                    child:
                    isLoader ? Center(child: CircularProgressIndicator()):
                    Text("Add Property")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
