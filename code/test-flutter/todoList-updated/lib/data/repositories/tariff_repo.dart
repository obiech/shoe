import 'package:to_do_list_pro_project/data/data_source/tariff_data.dart';
import 'package:to_do_list_pro_project/data/models/tariff_model.dart';

class TariffRepo {
  TariffData tariffData;

  TariffRepo(this.tariffData);

  List<TariffModel> getTariffList() {
    return tariffData.tariffList;
  }
}
