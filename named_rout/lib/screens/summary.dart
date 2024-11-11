import 'package:flutter/material.dart';
import 'package:named_rout/models/assessment.dart';
import 'package:named_rout/models/group_member.dart';

import '../constants.dart';

class SummaryScreen extends StatelessWidget {
  final GroupMember _evaluator;
  final List<Assessment> _data;

  const SummaryScreen(this._evaluator, this._data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Column(
          children: <Widget>[
            const Text(
              'Peer and Self Assessement by',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              _evaluator.fullName,
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        itemCount: _data.length,
        itemBuilder: (context, index) => _ListTile(
          index: index,
          assessments: _data,
        ),
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
        ),
      ),
    );
  }
}

class _ListTile extends StatefulWidget {
  final int index;
  final List<Assessment> assessments;
  const _ListTile({required this.index, required this.assessments});

  @override
  __ListTileState createState() => __ListTileState();
}

class __ListTileState extends State<_ListTile> {
  void _navigate() async {
    final result = await Navigator.pushNamed(
      context,
      detailsRoute,
      arguments: Assessment.copy(widget.assessments[widget.index]),
    );

    if (result != null && result is Assessment) {
      setState(() => widget.assessments[widget.index] = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.assessments[widget.index].member.shortName),
      subtitle: Text(widget.assessments[widget.index].member.fullName),
      trailing: CircleAvatar(
        backgroundColor: widget.assessments[widget.index].percent < 50
            ? Colors.red
            : Colors.green,
        child: Text(
          widget.assessments[widget.index].percent.round().toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onTap: () => _navigate(),
    );
  }
}
