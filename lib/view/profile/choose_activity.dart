import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kena/app/components/my_bottom_sheet.dart';
import 'package:kena/app/components/my_button.dart';
import 'package:kena/app/components/my_dropdown.dart';
import 'package:kena/app/components/my_scaffold.dart';
import 'package:kena/app/components/my_text_field.dart';
import 'package:kena/app/utils/extensions/context_extensions.dart';

class ChooseActivity extends StatefulWidget {
  const ChooseActivity({super.key});

  @override
  State<ChooseActivity> createState() => _ChooseActivityState();
}

class _ChooseActivityState extends State<ChooseActivity> {
  // ── Separate state for each activity ──────────────────────────────────────
  final Map<String, bool> _selections = {
    'Journaling': false,
    'Physical exercise': false,
    'Meditation': false,
    'Praying': false,
    'Affirmations': false,
    'Time with friends': false,
    'Time Hydrated': false,
    'Therapy': false,
    'Forgive myself': false,
    'Forgiveness': false,
    'Acts of kindness': false,
    'Nature retreat': false,
  };
  final List<String> frequencyOptions = ['Daily', 'Weekly', 'Monthly'];
  void _toggle(String key) {
    setState(() {
      _selections[key] = !(_selections[key] ?? false);
    });
  }

  String selectedFrequency = 'Daily';

  // Build a row of two SelectionBoxes
  Widget _buildRow(String left, String right) {
    return Row(
      children: [
        Expanded(
          child: SelectionBox(
            label: left,
            isSelected: _selections[left] ?? false,
            onTap: () => _toggle(left),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: SelectionBox(
            label: right,
            isSelected: _selections[right] ?? false,
            onTap: () => _toggle(right),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ────────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF63383B),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Go to Home",
                          style: context.typography.body.copyWith(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        decoration: BoxDecoration(
                          color: context.colors.primary,
                        ),
                        height: 1.5.h,
                        width: 85.w,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                "Choose activities",
                style: context.typography.title.copyWith(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Meaningful activity can help us navigate emotions. Select or add below including frequency",
                textAlign: TextAlign.left,
                style: context.typography.subtitle.copyWith(
                  fontSize: 14.sp,
                  color: context.colors.textSecondary.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 25.h),

              // ── Activity rows ─────────────────────────────────────────────
              _buildRow('Journaling', 'Physical exercise'),
              SizedBox(height: 10.h),
              _buildRow('Meditation', 'Praying'),
              SizedBox(height: 10.h),
              _buildRow('Affirmations', 'Time with friends'),
              SizedBox(height: 10.h),
              _buildRow('Time Hydrated', 'Therapy'),
              SizedBox(height: 10.h),
              _buildRow('Forgive myself', 'Forgiveness'),
              SizedBox(height: 10.h),
              _buildRow('Acts of kindness', 'Nature retreat'),
              SizedBox(height: 20.h),
              Text(
                "Act Of Kindness",
                style: context.typography.body.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              MyDropdown(
                height: 80.h,
                selectedItemColor: Color(0xFFfff3e3),
                backgroundColor: context.colors.background,
                label: "Daily",
                items: frequencyOptions,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedFrequency = newValue!;
                  });
                },
              ),
              // MyTextField(
              //   hint: "Daily",
              //   suffixIcon: Assets.icons.calendar.svg(
              //     width: 24.w,
              //     height: 24.h,
              //   ),
              //   fillColor: Colors.transparent,
              //   borderColor: context.colors.textSecondary.withOpacity(0.3),
              // ),
              // SizedBox(height: 10.h),
              MyButton(
                icon: Icon(Icons.add),
                label: "Add your own activity",
                onPressed: () {
                  setState(() {});
                  MyBottomSheet.show(
                    context,
                    child: SizedBox(
                      height: 440.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 10.w,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 5.h,
                                width: 54.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFF6b6e80),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Center(
                              child: Text(
                                "Add your own activity",
                                style: context.typography.body.copyWith(
                                  color: context.colors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Activity Name",
                              style: context.typography.body.copyWith(
                                color: context.colors.textPrimary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            MyTextField(
                              hint: "Enter activity name",
                              // suffixIcon: Assets.icons.calendar.svg(
                              //   width: 24.w,
                              //   height: 24.h,
                              // ),
                              fillColor: Colors.transparent,
                              borderColor: context.colors.textSecondary
                                  .withOpacity(0.3),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "How often will you do this?",
                              style: context.typography.body.copyWith(
                                color: context.colors.textPrimary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            MyDropdown(
                              height: 80.h,
                              selectedItemColor: Color(0xFFfff3e3),
                              backgroundColor: context.colors.background,
                              label: "Daily",
                              items: frequencyOptions,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedFrequency = newValue!;
                                });
                              },
                            ),

                            SizedBox(height: 20.h),
                            MyButton(
                              label: "Continue",
                              onPressed: () {},
                              textColor: context.colors.background,
                            ),
                            SizedBox(height: 10.h),
                            MyButton(
                              label: "Save",
                              onPressed: () {},
                              backgroundColor: Colors.transparent,
                              borderWidth: 1,
                              borderColor: context.colors.primary,
                              textColor: context.colors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                backgroundColor: Colors.transparent,
                borderWidth: 1,
                borderColor: context.colors.primary,
                textColor: context.colors.primary,
              ),
              SizedBox(height: 10.h),
              MyButton(
                label: "Save",
                onPressed: () {},
                textColor: context.colors.background,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectionBox extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionBox({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            height: 40.h, // Fixed height for all boxes
            decoration: BoxDecoration(
              color: isSelected
                  ? context.colors.primary
                  : const Color(0xFFfffaf0),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              // ← Removed the broken Expanded here
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: context.typography.body.copyWith(
                      fontSize: Platform.isIOS ? 12.sp : 12.5.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : context.colors.textSecondary.withOpacity(0.6),
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 1.1,
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (_) => onTap(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.white
                          : context.colors.primary.withOpacity(0.5),
                      width: 1.5,
                    ),
                    activeColor: Colors.white,
                    checkColor: context.colors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
