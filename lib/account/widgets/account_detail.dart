import 'package:flutter/material.dart';

class AccountDetail extends StatelessWidget {
  const AccountDetail(
      {super.key, required this.detail, required this.detailValue});
  final String detail;
  final String detailValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(detail.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.grey)),
        Text(detailValue, style: Theme.of(context).textTheme.headline6)
      ],
    );
  }
}
