import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/app/helpers/service_response.dart';
import 'package:shopnownow/modules/savedlist/model/savedlist_model.dart';
import 'package:shopnownow/utils/logger.dart';

class SavedListRepository{
  static Future<NotifierState<GetSavedList>> getSavedList() async {
    return (await ApiService<GetSavedList>().getCall(
        "/user/shopping_list/lists",
        hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return GetSavedList.fromJson(data);
        }))
        .toNotifierState();
  }

}