import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/app/helpers/service_response.dart';
import 'package:shopnownow/modules/wallet/model/wallet_model.dart';
import 'package:shopnownow/utils/logger.dart';

class WalletRepository{
  static Future<NotifierState<WalletResponse>> getWalletBal() async {
    return (await ApiService<WalletResponse>().getCall(
        "/user/wallet/balance",
        hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return WalletResponse.fromJson(data);
        }))
        .toNotifierState();
  }

  static Future<NotifierState<String>> convertPoints() async {
    return (await ApiService<String>().postCall(
        "/user/wallet/convert_points",
        ServiceRequest(serviceRequest: {}),
        hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return data["message"];
        }))
        .toNotifierState();
  }

  static Future<NotifierState<String>> fundWallet({
  required String amount, required String reference
}) async {
    return (await ApiService<String>().postCall(
        "/user/wallet/fund_wallet",
        ServiceRequest(serviceRequest: {
          "amount" : amount,
          "payment_reference" : reference
        }),
        hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return data["message"];
        }))
        .toNotifierState();
  }

  static Future<NotifierState<TransactionResponse>> getTransactions() async {
    return (await ApiService<TransactionResponse>().getCall(
        "/user/wallet/transactions",
        hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return TransactionResponse.fromJson(data);
        }))
        .toNotifierState();
  }

  static Future<NotifierState<TransactionResponse>> getLimitedTransactions() async {
    return (await ApiService<TransactionResponse>().getCall(
        "/user/wallet/limited-transactions",
        hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return TransactionResponse.fromJson(data);
        }))
        .toNotifierState();
  }
}