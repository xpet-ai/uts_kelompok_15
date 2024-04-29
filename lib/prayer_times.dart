import 'dart:html';

import 'package:flutter/material.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;

class PrayerTimes2 extends StatefulWidget {
  const PrayerTimes2({super.key});

  @override
  State<PrayerTimes2> createState() => _PrayerTimesState();
}

class _PrayerTimesState extends State<PrayerTimes2> {
  String pracetamol = '';
  String HCL = '';
  String Ambroxol_Hydrochloride = '';
  String Salbutamol_sulfate = '';
  String Caltron = '';

  @override
  void initState(){

    super.initState();
    getPrayerTimes();
  }
  void getPrayerTimes() async {
    LocationPermission permission;
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
    double latitude = position.latitude;
    double longitude = position.longitude;
    print(latitude);
    print(longitude);
  
  
  tz.initializeTimeZones();
  String tzs =  tzmap.latLngToTimezoneString(latitude, longitude);
  print(tzs);
  final location = tz.getLocation(tzs);

  // Definitions
  DateTime date = tz.TZDateTime.from(DateTime.now(), location);
  Coordinates coordinates = Coordinates(latitude, longitude);

  // Parameters
  CalculationParameters params = CalculationMethod.NorthAmerica();
  params.madhab = Madhab.Hanafi;
  PrayerTimes prayerTimes = PrayerTimes(coordinates, date, params);

  setState(() {
    HCL = tz.TZDateTime.from(prayerTimes.fajr!, location)
      .toString();
    pracetamol = DateFormat('HH:mm')
      .format(tz.TZDateTime.from(prayerTimes.dhuhr!,location))
      .toString();
    Ambroxol_Hydrochloride = DateFormat('HH:mm')
      .format(tz.TZDateTime.from(prayerTimes.asr!, location))
      .toString();
    Caltron = DateFormat('HH:mm')
      .format(tz.TZDateTime.from(prayerTimes.maghrib!, location))
      .toString();
    Salbutamol_sulfate = DateFormat('HH:mm')
      .format(tz.TZDateTime.from(prayerTimes.isha!, location))
      .toString();
  });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Jadwal minum Obat'), 
      centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(20),
        child:  Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'pracetamol', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ), 
              Text(
                pracetamol,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Text(
                'sesudah makan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                )
              ],
            ),
            Container(
              margin:  const EdgeInsets.only(top: 5),
              height: 5,
              color: Colors.black,
            ),
            SizedBox(
              height: 15,
              ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                'HCL', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ), 
              Text(
                '',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Text(
                'sesudah makanan dan tepat waktu ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                )
              ],
            ),
            Container(
              margin:  const EdgeInsets.only(top: 5),
              height: 5,
              color: Colors.black,
            ),
            SizedBox(
              height: 15,
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Ambroxol_Hydrochloride', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ), 
              Text(
                Ambroxol_Hydrochloride,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Text(
                'sesudah makan dan harus tepat waktu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              margin:  const EdgeInsets.only(top: 5),
              height: 5,
              color: Colors.black,
            ),
            SizedBox(
              height: 15,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Salbutamol_sulfate', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ), 
              Text(
                Salbutamol_sulfate,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Text(
                'sesudah makan dan harus tepat waktu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              margin:  const EdgeInsets.only(top: 5),
              height: 5,
              color: Colors.black,
            ),
            SizedBox(
              height: 15,
              ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Caltron', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ), 
              Text(
                Caltron,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Text(
                'sesudah makan dan harus tepat waktu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              margin:  const EdgeInsets.only(top: 5),
              height: 5,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}