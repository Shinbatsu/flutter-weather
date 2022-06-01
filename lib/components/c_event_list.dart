import 'package:flutter/material.dart';
import 'c_event_item.dart';
import 'package:weather/size_config.dart';

class EventListComponent extends StatelessWidget {
  final List<EventItemComponent> items;
  const EventListComponent({
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [...items],
    );
  }
}
