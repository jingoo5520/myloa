import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/resources/constants/theme.dart';
import 'package:flutter_template/views/widgets/common/tabbar_item.dart';

class CustomTabBar extends StatefulWidget {
  final TabController tabController;
  final List<String> tabNames;
  final int mode;

  const CustomTabBar(
      {required this.tabController,
      required this.tabNames,
      required this.mode,
      super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: backgroundColor,
          border: Border(bottom: BorderSide(color: Color(0xff313131)))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: IgnorePointer(
          ignoring: widget.mode == 0 ? false : true,
          child: TabBar(
            unselectedLabelStyle: const TextStyle(color: Colors.black),
            onTap: (value) {
              setState(() {});
            },
            indicator: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.w)),
                color: Colors.white),
            controller: widget.tabController,
            indicatorPadding:
                EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
            tabs: List.generate(
                widget.tabNames.length,
                (index) => TabBarItem(
                      index: index,
                      tabName: widget.tabNames[index],
                      tabController: widget.tabController,
                    )),
          ),
        ),
      ),
    );
  }
}
