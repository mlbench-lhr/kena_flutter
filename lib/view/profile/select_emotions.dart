import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kena/app/components/my_button.dart';
import 'package:kena/app/components/my_dialog.dart';
import 'package:kena/app/components/my_scaffold.dart';
import 'package:kena/app/components/my_text_field.dart';
import 'package:kena/app/routes/routes_name.dart';
import 'package:kena/app/utils/extensions/context_extensions.dart';
import 'package:kena/model/emotions/emotion_category.dart';

// ─── Model ────────────────────────────────────────────────────────────────────
class SelectedEmotion {
  final String categoryTitle;
  final Color categoryColor;
  final Widget categoryEmoji;
  final String subEmotionTitle;
  final Widget subEmotionEmoji; // ✅ sub-emotion emoji for circle center
  final int intensity;

  const SelectedEmotion({
    required this.categoryTitle,
    required this.categoryColor,
    required this.categoryEmoji,
    required this.subEmotionTitle,
    required this.subEmotionEmoji,
    required this.intensity,
  });
}

// ─── Main Screen ──────────────────────────────────────────────────────────────
class SelectEmotions extends StatefulWidget {
  const SelectEmotions({super.key});

  @override
  State<SelectEmotions> createState() => _SelectEmotionsState();
}

class _SelectEmotionsState extends State<SelectEmotions> {
  String? _expandedCategory;

  /// Tracks selected sub-emotion per category: { categoryTitle: subEmotionTitle }
  final Map<String, String> _selectedSubEmotions = {};

  /// Final confirmed selections with intensity
  final List<SelectedEmotion> _selectedEmotions = [];

  final List<EmotionCategory> categories = emotionCategories;

  void _onCategoryTap(String title) {
    setState(() {
      _expandedCategory = _expandedCategory == title ? null : title;
    });
  }

  void _onSubEmotionTap(EmotionCategory category, SubEmotion sub) {
    setState(() {
      // Toggle: tap same one to deselect
      if (_selectedSubEmotions[category.title] == sub.title) {
        _selectedSubEmotions.remove(category.title);
      } else {
        _selectedSubEmotions[category.title] = sub.title;
      }
    });
  }

  bool _isSubEmotionSelected(String categoryTitle, String subTitle) {
    return _selectedSubEmotions[categoryTitle] == subTitle;
  }

  @override
  Widget build(BuildContext context) {
    final row1 = categories.sublist(0, 3);
    final row2 = categories.sublist(3, 6);

    return MyScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
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
                "Select your current core emotions",
                style: context.typography.title.copyWith(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Text(
                textAlign: TextAlign.left,
                "Select 1-3 by searching or tapping an option below",
                style: context.typography.subtitle.copyWith(
                  fontSize: 14.sp,
                  color: context.colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),
              MyTextField(
                hint: "Search by emotion name / body sensation",
                borderColor: Color(0xFFd0d0d0),
                fillColor: Colors.transparent,
                hintColor: context.colors.textPrimary,
                prefixIcon: Icon(
                  Icons.search,
                  color: context.colors.textPrimary,
                ),
              ),
              SizedBox(height: 20.h),

              // ── Emotion grid rows ────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: row1
                    .map(
                      (cat) => EmotionsCard(
                        title: cat.title,
                        emoji: cat.emojiBuilder(24.w, 24.h),
                        color: cat.color,
                        isExpanded: _expandedCategory == cat.title,
                        onTap: () => _onCategoryTap(cat.title),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: row2
                    .map(
                      (cat) => EmotionsCard(
                        title: cat.title,
                        emoji: cat.emojiBuilder(24.w, 24.h),
                        color: cat.color,
                        isExpanded: _expandedCategory == cat.title,
                        onTap: () => _onCategoryTap(cat.title),
                      ),
                    )
                    .toList(),
              ),

              // ── Expanded panel ───────────────────────────────────────────────
              AnimatedSize(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _expandedCategory != null
                    ? _buildExpandedPanel(
                        context,
                        categories.firstWhere(
                          (c) => c.title == _expandedCategory,
                        ),
                      )
                    : SizedBox.shrink(),
              ),

              // ── Intensity circles ────────────────────────────────────────────
              AnimatedSize(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _selectedEmotions.isEmpty
                    ? SizedBox.shrink()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Text(
                            "Your selection",
                            style: context.typography.body.copyWith(
                              color: context.colors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 16.h,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Color(0xFFebebeb)),
                            ),
                            child: Column(
                              children: _selectedEmotions
                                  .map(
                                    (e) => Padding(
                                      padding: EdgeInsets.only(bottom: 12.h),
                                      child: Column(
                                        children: [
                                          IntensityCircle(
                                            intensity: e.intensity,
                                            centerWidget: e.subEmotionEmoji,
                                            label: e.subEmotionTitle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
              ),

              SizedBox(height: 20.h),

              // ── Info row ────────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: context.colors.textSecondary,
                    size: 20.w,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "What are core emotions?",
                    style: context.typography.subtitle.copyWith(
                      fontSize: 16.sp,
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Color(0xFFfefdf9),
                  border: Border.all(color: Color(0xFFc0bfbd)),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  textAlign: TextAlign.left,
                  "These are those feelings that hang around for a bit, like feeling super down or sad after losing something important or totally pumped and confident from a big win. They don't vanish quick—they linger, and we usually have to step-up to handle them",
                  style: context.typography.subtitle.copyWith(
                    fontSize: 12.sp,
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _selectedEmotions.isNotEmpty
                  ? SizedBox(height: 10.h)
                  : SizedBox.shrink(),
              _selectedEmotions.isNotEmpty
                  ? MyButton(
                      label: "Continue",
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamed(RoutesName.chooseActivity);
                      },
                      textColor: context.colors.background,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedPanel(BuildContext context, EmotionCategory category) {
    final selectedSub = _selectedSubEmotions[category.title];

    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.all(15.w),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Color(0xFFebebeb)),
      ),
      child: _selectedEmotions.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category header
                Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 60.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: category.color,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: category.emojiBuilder(22.w, 22.h),
                          ),
                        ),
                        Positioned(
                          bottom: -10.h,
                          right: -10.w,
                          child: Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.file_upload_outlined,
                              size: 21.w,
                              color: Color(0xFFa30558),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 30.w),
                    Text(
                      category.title,
                      style: context.typography.body.copyWith(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),

                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 2.h,
                        color: const Color(0xFFedcdde),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "Want to be more specific?",
                      style: context.typography.body.copyWith(
                        fontSize: 14.sp,
                        color: Color(0xFFA30458),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Container(
                        height: 2.h,
                        color: const Color(0xFFedcdde),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // ── Sub-emotions grid (selectable) ───────────────────────────────────
                ...List.generate((category.subEmotions.length / 3).ceil(), (
                  rowIndex,
                ) {
                  final start = rowIndex * 3;
                  final end = (start + 3).clamp(0, category.subEmotions.length);
                  final rowItems = category.subEmotions.sublist(start, end);

                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      children: [
                        for (int i = 0; i < rowItems.length; i++) ...[
                          if (i > 0) SizedBox(width: 10.w),
                          Expanded(
                            child: TypeofEmotions(
                              title: rowItems[i].title,
                              emoji: rowItems[i].emojiBuilder(16.w, 16.h),
                              isSelected: _isSubEmotionSelected(
                                category.title,
                                rowItems[i].title,
                              ),
                              onTap: () =>
                                  _onSubEmotionTap(category, rowItems[i]),
                            ),
                          ),
                        ],
                        if (rowItems.length < 3)
                          for (int i = rowItems.length; i < 3; i++) ...[
                            SizedBox(width: 10.w),
                            Expanded(child: SizedBox()),
                          ],
                      ],
                    ),
                  );
                }),

                SizedBox(height: 10.h),

                // Upload hint
                Container(
                  width: double.infinity,
                  height: 64.h,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFfefdf9),
                    border: Border.all(color: const Color(0xFFcfcecc)),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        color: Color(0xFFa30558),
                        size: 23.w,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          "Tap the upload icon to replace this emoji with your own image",
                          style: context.typography.subtitle.copyWith(
                            fontSize: 12.sp,
                            color: context.colors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),

                // ── Select Intensity button (only enabled when a sub-emotion is picked) ──
                MyButton(
                  label: "Select Intensity",
                  textColor: context.colors.background,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => MyDialogBox(
                        title: category.title,
                        subtitle: "How intense is it?",
                        // AFTER
                        leadingIcon: () {
                          // If a sub-emotion is selected, show its emoji; otherwise fall back to category emoji
                          if (selectedSub != null) {
                            final sub = category.subEmotions.firstWhere(
                              (s) => s.title == selectedSub,
                            );
                            return Container(
                              width: 60.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: category.color,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: sub.emojiBuilder(28.w, 28.h),
                              ),
                            );
                          }
                          return Column(
                            children: [
                              Container(
                                width: 60.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                  color: category.color,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Center(
                                  child: category.emojiBuilder(28.w, 28.h),
                                ),
                              ),
                            ],
                          );
                        }(),
                        onConfirm: (selectedNumber) {
                          // Resolve which sub-emotion to use:
                          // prefer the tapped one, fall back to index-based
                          final SubEmotion resolvedSub = selectedSub != null
                              ? category.subEmotions.firstWhere(
                                  (s) => s.title == selectedSub,
                                )
                              : category.subEmotions[selectedNumber - 1];

                          setState(() {
                            _selectedEmotions.removeWhere(
                              (e) => e.categoryTitle == category.title,
                            );

                            _selectedEmotions.add(
                              SelectedEmotion(
                                categoryTitle: category.title,
                                categoryColor: category.color,
                                categoryEmoji: category.emojiBuilder(
                                  28.w,
                                  28.h,
                                ),
                                subEmotionTitle: resolvedSub.title,
                                subEmotionEmoji: resolvedSub.emojiBuilder(
                                  28.w,
                                  28.h,
                                ),
                                intensity: selectedNumber,
                              ),
                            );
                          });

                          Navigator.of(context).pop();
                        },
                        onCancel: () => Navigator.of(context).pop(),
                      ),
                    );
                  },
                ),
              ],
            )
          : SizedBox.shrink(),
    );
  }
}

// ─── Widgets ──────────────────────────────────────────────────────────────────

class TypeofEmotions extends StatelessWidget {
  final String title;
  final Widget emoji;
  final bool isSelected; // ✅ new
  final VoidCallback onTap; // ✅ new

  const TypeofEmotions({
    super.key,
    required this.title,
    required this.emoji,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 180),
        padding: EdgeInsets.only(right: 6.w),
        width: 95.w,
        height: 39.w,
        decoration: BoxDecoration(
          // ✅ highlighted when selected
          color: isSelected ? Color(0xFFf3e0f7) : const Color(0xFFFFF5EC),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? context.colors.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 4.w),
            emoji,
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: context.typography.body.copyWith(
                  fontSize: Platform.isAndroid ? 12.sp : 11.5.sp,
                  // ✅ text color shifts when selected
                  color: isSelected
                      ? context.colors.primary
                      : const Color(0xFF6b5b8c),
                  fontVariations: const [FontVariation('wght', 500.0)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmotionsCard extends StatelessWidget {
  final String title;
  final Color color;
  final Widget emoji;
  final bool isExpanded;
  final VoidCallback onTap;

  const EmotionsCard({
    super.key,
    required this.title,
    required this.emoji,
    required this.color,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: 101.w,
            height: 89.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 17.h),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.r),
              border: isExpanded
                  ? Border.all(color: context.colors.primary, width: 2)
                  : Border.all(color: Colors.transparent, width: 2),
              boxShadow: isExpanded
                  ? [
                      BoxShadow(
                        color: context.colors.primary.withOpacity(0.15),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: Column(
              children: [
                emoji,
                Spacer(),
                Text(
                  title,
                  style: context.typography.body.copyWith(
                    color: context.colors.textPrimary,
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

class IntensityCircle extends StatelessWidget {
  final int intensity;
  final Widget centerWidget;
  final String label;

  const IntensityCircle({
    super.key,
    required this.intensity,
    required this.centerWidget,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = intensity.clamp(0, 5) / 5;
    final double size = 65.r;

    return Row(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 7.w,
                  backgroundColor: Color(0xFFf1e2c5),
                  valueColor: AlwaysStoppedAnimation(Color(0xFF32683b)),
                ),
              ),
              Container(
                width: 56.r,
                height: 56.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.background,
                ),
                child: Center(child: centerWidget),
              ),
            ],
          ),
        ),
        SizedBox(width: 15.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.typography.body.copyWith(
                color: context.colors.textPrimary,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              '$intensity/5',
              style: context.typography.body.copyWith(
                color: Color(0xFF399969),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


  // MyTextField(
  //                         hint: "Daily",
  //                         suffixIcon: Assets.icons.calendar.svg(
  //                           width: 24.w,
  //                           height: 24.h,
  //                         ),
  //                         fillColor: Colors.transparent,
  //                         borderColor: context.colors.textSecondary.withOpacity(
  //                           0.3,
  //                         ),
  //                       ),
