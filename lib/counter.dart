import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  int counter;
  Counter({Key? key, this.counter = 0}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int get counter {
    return widget.counter;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$counter"),
        Row(
          children: [
            IconButton(
                onPressed: counter > 0
                    ? () {
                        setState(() {
                          widget.counter--;
                        });
                      }
                    : null,
                icon: const Icon(Icons.remove)),
            IconButton(
                onPressed: () {
                  setState(() {
                    widget.counter++;
                  });
                },
                icon: const Icon(Icons.add))
          ],
        )
      ],
    );
  }
}
