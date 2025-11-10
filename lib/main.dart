import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_proj/models/provider/my_provider.dart';
import 'package:test_proj/models/provider/padometer_provider.dart';


void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home  Page'),),
      floatingActionButton:FloatingActionButton(
          child: Text('pedometer'),
          onPressed:(){
        Navigator.push(context,MaterialPageRoute(builder:(context)=>SensorScreen()));
      }),
      body:ChangeNotifierProvider(create:(context)=>MyProvider(),
      child: Consumer<MyProvider>(builder: (context,provider,child){
        return ListView.builder(
            itemCount: (provider.myModel?.data?.items??[]).length,
            itemBuilder:(context,index){
              final data=(provider.myModel?.data?.items??[])[index];
       if(provider.loading==true){
         return Center(child: CircularProgressIndicator(),);
       }
       else{
        return Column(
           children: [
             Text('Title ${data.title}'),
             Text('id ${data.id}'),
             Text('location ${data.location?.city}'),


           ],
         );
       }
        });}),
      )
    );
  }
}



////
class SensorScreen extends StatelessWidget {
  const SensorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StepProvider(),
      builder: (context, child) {
        final stepProvider = Provider.of<StepProvider>(context);

        return Scaffold(
          appBar: AppBar(title: const Text('Live Sensor Data')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Step Counter
                const Text(
                  'Steps Taken',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  '${stepProvider.stepCount}',
                  style: const TextStyle(fontSize: 48, color: Colors.blue),
                ),
                const SizedBox(height: 40),

                // Gyroscope
                const Text(
                  'Gyroscope',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'X: ${stepProvider.gyroX.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, color: Colors.green),
                ),
                Text(
                  'Y: ${stepProvider.gyroY.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, color: Colors.green),
                ),
                Text(
                  'Z: ${stepProvider.gyroZ.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, color: Colors.green),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
