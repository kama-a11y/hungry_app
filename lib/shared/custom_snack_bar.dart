import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/shared/custom_text.dart';

SnackBar CustomSnackBar(String errorMsg) {
  return SnackBar(
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
    clipBehavior: Clip.none,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.red.shade600,
    content: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          CupertinoIcons.info,
          color: Colors.white,
        ),
        const Gap(10),

        /// 👇 ده المهم
        Expanded(
          child: CustomText(
            text: errorMsg,
            size: 16,
            color: Colors.white,
            ),
        ),
      ],
    ),
  );
}
