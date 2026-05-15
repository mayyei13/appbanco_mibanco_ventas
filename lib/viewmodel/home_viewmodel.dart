import 'package:flutter/material.dart';

import '../model/account_model.dart';


class HomeViewModel extends ChangeNotifier {

  AccountModel account = AccountModel(

    clientName: 'Maylit Mendoza',

    savingsBalance: 8500.75,

    creditDebt: 2300.50,

  );

}