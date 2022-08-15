import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';



class Calender extends StatefulWidget {
  
  @override
  State<Calender> createState() => _Calender();
}

class _Calender extends State<Calender> {
  
  final CalendarController _controller = CalendarController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
         title: Text('Calendar'),
         centerTitle: true,
          backgroundColor:Colors.black26,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(40),
              child: SfCalendar(
                view: CalendarView.day,
                allowedViews: [
                  CalendarView.day,
                  CalendarView.week,
                  CalendarView.workWeek,
                  CalendarView.month,
                  CalendarView.timelineDay,
                  CalendarView.timelineWeek,
                  CalendarView.timelineWorkWeek
                ],
                viewHeaderStyle: ViewHeaderStyle(backgroundColor: Colors.white12),
                backgroundColor: Colors.white70,
                controller: _controller,
                initialDisplayDate: DateTime.now(),
                
              
               
              ),
            ),
            
          ],
        ),
        
      );
  
  }


}

