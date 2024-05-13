import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/life/widget/breedValue.dart';

class TipList extends StatefulWidget {
  final int breed;
  final List tipList;
  const TipList({
    Key? key,
    required this.tipList,
    required this.breed
  }) : super(
          key: key,
        );

  @override
  _TipListState createState() => _TipListState();
}

class _TipListState extends State<TipList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.tipList.length,
      itemBuilder: (BuildContext context, int index) {
        if (widget.tipList != null && index < widget.tipList.length) {
          final record = widget.tipList[index]!;
          return BreedValue(
            value: record,
          );
        } else {
          return SizedBox(); // 혹은 다른 처리를 수행할 수 있음
        }
      },
    );
  }
}
