import 'package:flutter/material.dart';

import 'Sync_calender.dart';

Map<String, Function> getSampleWidget() {
  return <String, Function>{
    'agenda_view_calendar': (Key key) => AgendaViewCalendar(),
  };
}