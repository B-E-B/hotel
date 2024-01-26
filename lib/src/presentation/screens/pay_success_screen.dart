import 'package:flutter/material.dart';
import 'package:hotel/src/common/theme/app_colors.dart';
import 'package:hotel/src/presentation/screens/hotel_screen.dart';
import 'package:hotel/src/presentation/widgets/custom_app_bar.dart';
import 'package:hotel/src/presentation/widgets/custom_bottom_bar.dart';

class PaySuccessScreen extends StatelessWidget {
  static const routeName = '/pay_success';

  const PaySuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Заказ оплачен'),
        bottomNavigationBar: CustomBottomBar(
          buttonLabel: 'Супер!',
          onTap: () => Navigator.popUntil(context, ModalRoute.withName(HotelScreen.routeName)),
        ),
        backgroundColor: AppColors.white,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              _partyPopper(),
              const SizedBox(height: 32),
              _orderAccepted(context),
              const SizedBox(height: 20),
              _orderStatusDetailed(context),
            ],
          ),
        ));
  }

  SizedBox _orderStatusDetailed(BuildContext context) {
    return SizedBox(
      width: 330,
      child: Text(
        'Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.greyText),
        textAlign: TextAlign.center,
      ),
    );
  }

  Text _orderAccepted(BuildContext context) {
    return Text(
      'Ваш заказ принят в работу',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Container _partyPopper() {
    return Container(
        width: 94,
        height: 94,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.extraLightGrey,
        ),
        child: Image.asset(
          'assets/images/party_popper.png',
          height: 44,
          width: 44,
        ));
  }
}
