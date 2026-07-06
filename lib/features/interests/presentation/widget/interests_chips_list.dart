import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tozher/features/interests/domain/entity/interest.dart';

class InterestsChipsList extends StatefulWidget {
  final List<Interest> interests;
  final ValueChanged<Interest> onSelectionChanged;

  const InterestsChipsList({
    super.key,
    required this.interests,
    required this.onSelectionChanged,
  });

  @override
  State<InterestsChipsList> createState() => _InterestsChipsListState();
}

class _InterestsChipsListState extends State<InterestsChipsList> {
  Interest? selectedInterest;

  @override
  initState() {
    super.initState();
    selectedInterest = widget.interests.first;
  }

  void selectInterest(int index) {
    setState(() {
      selectedInterest = widget.interests[index];
    });
    widget.onSelectionChanged(widget.interests[index]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.interests.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final isSelected = selectedInterest == widget.interests[index];
        return ChoiceChip(
          
          selected: isSelected,
          onSelected: (_) => selectInterest(index),
          label: Text(
            "${widget.interests[index].icon} ${widget.interests[index].name}",
          ),
        );
      },
      separatorBuilder: (context, index) => Gap(8.w),
    );
  }
}
