import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Lockhart Week 5'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pageFirstLoad = true;
  bool isLoadingItemsFromDatabase = false;
  bool showFloatingButton = false;

  List<Customer> customers = [
    Customer("John", "Doe", 1, "Spender"),
    Customer("Jane", "Doe", 2, "Saver"),
    Customer("John", "Smith", 3, "Occasional"),
    Customer("Jane", "Smith", 4, "Frequent"),
    Customer("John", "Doe", 5, "Frequent"),
    Customer("Jane", "Doe", 6, "Spender"),
    Customer("John", "Smith", 7, "Frequent"),
    Customer("Jane", "Smith", 8, "Spender"),
    Customer("John", "Doe", 9, "Occasional"),
    Customer("Jane", "Doe", 10, "Saver")
  ];

  void _resetPage() {
    setState(() {
      pageFirstLoad = true;
      isLoadingItemsFromDatabase = false;
      showFloatingButton = false;
    });
  }

  void _handleButtonPress() {
    setState(() {
      pageFirstLoad = false;
      isLoadingItemsFromDatabase = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoadingItemsFromDatabase = false;
        showFloatingButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: pageFirstLoad
            ? ElevatedButton(
                onPressed: _handleButtonPress,
                child: Text("Load Items from Database"),
              )
            : isLoadingItemsFromDatabase
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        CircularProgressIndicator(),
                        Text("Loading Items from Database"),
                      ])
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: customers.map((customer) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Customer ID: ${customer.customerID}"),
                                Text(
                                    "Customer Name: ${customer.firstName} ${customer.lastName}"),
                                Text("Customer Type: ${customer.type}"),
                                Divider(),
                              ]),
                        );
                      }).toList(),
                    ),
                  ),
      ),
      floatingActionButton: showFloatingButton
          ? FloatingActionButton(
              onPressed: _resetPage,
              tooltip: 'Reset Page',
              child: const Icon(Icons.refresh),
            )
          : null,
    );
  }
}

class Customer {
  String firstName;
  String lastName;
  int customerID;
  String type;

  Customer(this.firstName, this.lastName, this.customerID, this.type);
}
