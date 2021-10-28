import 'package:to_do_list_pro_project/data/models/tariff_model.dart';

class TariffData {
  final List<TariffModel> _tariffList = [
    TariffModel(period: 1, totalPrice: 2.99, monthPrice: 2.99),
    TariffModel(period: 6, totalPrice: 14.99, monthPrice: 2.5),
    TariffModel(period: 12, totalPrice: 19.99, monthPrice: 1.66),
  ];

  List<TariffModel> get tariffList => _tariffList;
}
