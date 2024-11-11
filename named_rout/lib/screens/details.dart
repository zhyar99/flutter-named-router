import 'package:flutter/material.dart';
import 'package:named_rout/models/assessment.dart';
import 'package:named_rout/models/form.dart';

class DetailsScreen extends StatelessWidget {
  final Assessment _data;

  const DetailsScreen(this._data, {super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(_data.member.shortName),
          centerTitle: true,
        ),
        body: ListView.separated(
          itemCount: criteria.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(criteria[index].title),
            subtitle: Text(criteria[index].description),
            trailing: _DropdownButton(index: index, points: _data.points),
          ),
          separatorBuilder: (context, index) => const Divider(
            color: Colors.grey,
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton.extended(
              label: const Text('Save'),
              icon: const Icon(Icons.check_circle),
              heroTag: null,
              onPressed: () => Navigator.pop(context, _data),
            ),
            FloatingActionButton.extended(
              label: const Text('Cancel'),
              icon: const Icon(Icons.cancel),
              heroTag: null,
              onPressed: () => Navigator.pop(context, null),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownButton extends StatefulWidget {
  final int index;
  final List<int> points;

  const _DropdownButton({required this.index, required this.points});
  
  @override
  __DropdownButtonState createState() => __DropdownButtonState();
}

class __DropdownButtonState extends State<_DropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: widget.points[widget.index],
      items: scales
          .map(
            (scale) => DropdownMenuItem(
              value: scale.value,
              child: Text(scale.title),
            ),
          )
          .toList(),
      onChanged: (newValue) {
        if (newValue != null) { // Check for non-null value
          setState(() => widget.points[widget.index] = newValue);
        }
      },
    );
  }
}
