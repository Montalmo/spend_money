import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const SpendMoneyApp());
}

class SpendMoneyApp extends StatelessWidget {
  const SpendMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expeses',
      theme: ThemeData(
        fontFamily: 'Gilroy',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.normal,
            fontSize: 17.0,
          ),
        ),
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.amber,
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Car',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where(
      (element) {
        return element.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _addNewTransection(String txTitle, double txAmount, DateTime dateTime) {
    final Transaction newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: dateTime,
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(addTx: _addNewTransection),
        );
      },
    );
  }

  void _deleteTransction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Flutter App'),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    .21,
                child: Chart(recentTransactions: _recentTransactions)),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  .79,
              child: TransactionList(
                transactions: _userTransaction,
                deleteTransaction: _deleteTransction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
