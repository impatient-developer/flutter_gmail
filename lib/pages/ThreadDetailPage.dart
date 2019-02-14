
import 'package:flutter/material.dart';
import 'package:flutter_gmail/ThreadSummary.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class ThreadDetailPage extends StatelessWidget {
  final ThreadSummary thread;

  const ThreadDetailPage({Key key, @required this.thread}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemBuilder: _buildOneMessage,
          separatorBuilder: (context, index) => Divider(color: Colors.grey),
          itemCount: thread.senders.length,
        ),
      ),
    );
  }

  Column _buildOneMessage(BuildContext context, int index) {
    String sender = thread.senders[index];
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              child: Text(sender[0]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(sender),
            ),
          ],
        ),
        Text(lorem(paragraphs: 3, words: 100)),
      ],
    );
  }
}
