import 'package:flutter/material.dart';

class YearPickerDialog extends StatefulWidget {
  final DateTime? yearController;
  const YearPickerDialog({Key? key, required this.yearController})
      : super(key: key);

  @override
  State<YearPickerDialog> createState() => _YearPickerDialogState();
}

class _YearPickerDialogState extends State<YearPickerDialog> {
  late DateTime valueDate;

  @override
  void initState() {
    setState(() {
      valueDate = widget.yearController ?? DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pilih Tahun",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Colors.black54,
              ),
            )
          ],
        ),
        content: YearPickerDialogContent(
          yearController: valueDate,
        ));
  }
}

class YearPickerDialogContent extends StatefulWidget {
  final DateTime? yearController;
  const YearPickerDialogContent({Key? key, required this.yearController})
      : super(key: key);

  @override
  State<YearPickerDialogContent> createState() =>
      _YearPickerDialogContentState();
}

class _YearPickerDialogContentState extends State<YearPickerDialogContent> {
  late DateTime valueDate;

  @override
  void initState() {
    setState(() {
      valueDate = widget.yearController ?? DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // Need to use container to add size constraint.
          width: 300,
          height: 300,
          child: Theme(
            data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                    onPrimary: Colors.white,
                    primary: Theme.of(context).primaryColor)),
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 50, 1),
              lastDate: DateTime(DateTime.now().year, 1),
              initialDate: DateTime.now(),
              selectedDate: valueDate,
              onChanged: (DateTime dateTime) {
                setState(() {
                  valueDate = dateTime;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context, valueDate);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor),
            alignment: Alignment.center,
            child: const Text(
              'Pilih Tahun',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
