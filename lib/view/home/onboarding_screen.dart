import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kena/app/components/my_button.dart';
import 'package:kena/app/components/my_scaffold.dart';
import 'package:kena/app/routes/routes_name.dart';
import 'package:kena/app/utils/extensions/context_extensions.dart';
import 'package:kena/generated/assets/assets.gen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

String dayName = DateFormat('EEEE').format(DateTime.now());
String restOfDate = DateFormat(', d MMM yyyy').format(DateTime.now());

class NavItem {
  final String label;
  final AssetGenImage icon; // Use SvgGenImage if your icons are SVGs
  const NavItem({required this.label, required this.icon});
}

// The list of items
final List<NavItem> navItems = [
  NavItem(label: "Home", icon: Assets.images.home),
  NavItem(label: "Community", icon: Assets.images.community),
  NavItem(label: "Insights", icon: Assets.images.insights),
  NavItem(label: "Profile", icon: Assets.images.profile),
];

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: context.colors.background,
        items: navItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: item.icon.image(height: 24.h, width: 24.w),
                label: item.label,
              ),
            )
            .toList(),
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: context.colors.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle navigation here
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 140.h,
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: context.colors.background,
                      radius: 22.r,
                      child: CircleAvatar(
                        backgroundColor: context.colors.background,
                        radius: 22.r,
                        backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1559568147-fef5fddb6905?q=80&w=1901&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Morning, alex",
                            style: context.typography.headline.copyWith(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            "Your emotional journey continues.",
                            style: context.typography.label.copyWith(
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Assets.icons.notifications.svg(
                      height: 40.h,
                      width: 40.h,
                      // colorFilter: const ColorFilter.mode(
                      //   Colors.white,
                      //   BlendMode.srcIn,
                      // ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          color: context.colors.primary,
                          size: 16,
                        ),
                        RichText(
                          text: TextSpan(
                            style: context.typography.label.copyWith(
                              fontSize: 14.sp,
                            ),
                            children: [
                              TextSpan(
                                text: dayName,
                                style: context.typography.body.copyWith(
                                  color: context.colors.textPrimary,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: restOfDate,
                                style: context.typography.body.copyWith(
                                  color: Colors.grey,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: context.colors.primary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(15.w),
                    height: 295.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFFd0d0d0), width: 1),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Core Emotions",
                              style: context.typography.headline.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: context.colors.textPrimary,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Aspirational Emotions",
                              style: context.typography.headline.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: context.colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 20.h,
                              ),
                              height: 155.h,
                              width: 154.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xFFc0d2c4)),
                              ),
                              child: Column(
                                children: [
                                  Assets.icons.oulineSadEmoji.svg(
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                  Spacer(),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "You haven't selected your core emotions yet",
                                    style: context.typography.subtitle.copyWith(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 20.h,
                              ),
                              height: 155.h,
                              width: 154.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xFFc0d2c4)),
                              ),
                              child: Column(
                                children: [
                                  Assets.icons.oulineSadEmoji.svg(
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                  Spacer(),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "You haven’t selected your aspirational emotions yet",
                                    style: context.typography.subtitle.copyWith(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        MyButton(
                          textColor: context.colors.background,
                          fontSize: 15.sp,
                          label: "Select emotions",
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushNamed(RoutesName.selectEmotions);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                      "Daily Reflection",
                      style: context.typography.body.copyWith(
                        color: context.colors.textPrimary,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.w),
                    height: 450.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFFd0d0d0), width: 1),
                    ),
                    child: Column(
                      children: [
                        Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          "Your forecast and daily log help build emotional awareness.",
                          style: context.typography.subtitle.copyWith(
                            fontSize: 13.sp,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Forecast",
                              style: context.typography.headline.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: context.colors.textPrimary,
                              ),
                            ),
                            SizedBox(width: 115.w),
                            Text(
                              "End of Day",
                              style: context.typography.headline.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: context.colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                // vertical: 50.h,
                              ),
                              height: 210.h,
                              width: 157.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xFFc0d2c4)),
                              ),
                              child: Center(
                                child: Text(
                                  textAlign: TextAlign.left,
                                  "Forecast & plan todays emotions for better choices.",
                                  style: context.typography.subtitle.copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                // vertical: 50.h,
                              ),
                              height: 210.h,
                              width: 157.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xFFc0d2c4)),
                              ),
                              child: Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Did it go as forecast?",
                                  style: context.typography.subtitle.copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        MyButton(
                          textColor: context.colors.background,
                          fontSize: 15.sp,
                          label: "Forecast today",
                          onPressed: () {},
                        ),
                        Spacer(),
                        MyButton(
                          backgroundColor: Colors.transparent,
                          textColor: context.colors.primary,
                          fontSize: 14.sp,
                          borderWidth: 1,
                          borderColor: context.colors.primary,
                          label: "End of Day Reflection",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    height: 166.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xFFd1d5dd), width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Assets.images.icon.image(),
                            SizedBox(width: 10.w),
                            Text(
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              "Support your emotional journey",
                              style: context.typography.subtitle.copyWith(
                                fontSize: 16.sp,
                                color: context.colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Choose activities that help you move from where you are to where you want to be.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: context.typography.subtitle.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        MyButton(
                          textColor: context.colors.background,
                          label: "Choose Activities",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xFFd1d5dd), width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Assets.images.people.image(),
                            SizedBox(width: 10.w),
                            Text(
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              "Community Highlights",
                              style: context.typography.subtitle.copyWith(
                                fontSize: 16.sp,
                                color: context.colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "You don't have to do this alone.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: context.typography.subtitle.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        MyButton(
                          textColor: context.colors.background,
                          label: "Build a Commuity",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
