import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../profile.dart';
import '../widgets/basic_settings_list.dart';
import '../widgets/logout_list.dart';

class LogoutListSection extends StatelessWidget {
  final ProfileController controller;
  const LogoutListSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff191919),
      ),
      child: ListView.separated(
          //controller: controller.scrollController3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  controller.logout(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        LogoutList().logoutList[index].icon!,
                        color: const Color(0xffFF7676),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          LogoutList().logoutList[index].stringText!,
                          style: const TextStyle(color: Color(0xffFF7676)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: const Color(0xff252525),
              ),
          itemCount: LogoutList().logoutList.length),
    );
  }
}
