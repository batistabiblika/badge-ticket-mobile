import 'package:fbb_reg_ticket/model/badge.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:flutter/material.dart';

class BadgeInfoWidget extends StatelessWidget {
  final Badge badge;
  const BadgeInfoWidget({Key? key, required this.badge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge n%
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Badge n°',
              style: AppTextStyle.text(color: AppColors.PRIMARY),
            ),
            Text(
              '${badge.number}',
              style: AppTextStyle.head2(color: AppColors.PRIMARY),
            ),
          ]),
        ),

        // Name n%
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Nom',
              style: AppTextStyle.text(color: AppColors.PRIMARY),
            ),
            Text(
              badge.name ?? '${badge.firstname ?? ""} ${badge.lastname ?? ""}',
              style: AppTextStyle.head2(color: AppColors.PRIMARY),
            ),
          ]),
        ),

        // Name n%
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Eglise',
              style: AppTextStyle.text(color: AppColors.PRIMARY),
            ),
            Text(
              '${badge.churchName}',
              style: AppTextStyle.head2(color: AppColors.PRIMARY),
            ),
          ]),
        ),
        // Person image here
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: 160,
          height: 160,
          child: (badge.image != null && badge.image != "")
              ? AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder-square.png',
                      image: badge.image!,
                      fit: BoxFit.cover,
                      
                      imageErrorBuilder: (context, exception, stackTrace) {
                        return Text('Image not found');
                      },
                    ),
                  ),
                )
              : const SizedBox(
                  width: 20,
                ),
        ),
      ],
    );
  }
}
