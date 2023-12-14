import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/modules/wallet/model/wallet_model.dart';
import 'package:shopnownow/modules/wallet/repository/wallet_repo.dart';

final getWalletProvider = StateNotifierProvider<
    GetWalletNotifier, NotifierState<WalletResponse>>((ref) {
  return GetWalletNotifier();
});

final getTransactionProvider = StateNotifierProvider<
    GetTransactionNotifier, NotifierState<TransactionResponse>>((ref) {
  return GetTransactionNotifier();
});

final getLimitedTransactionProvider = StateNotifierProvider<
    GetLimitedTransactionNotifier, NotifierState<TransactionResponse>>((ref) {
  return GetLimitedTransactionNotifier();
});

final convertPointsProvider = StateNotifierProvider<
    ConvertPointsNotifier, NotifierState<String>>((ref) {
  return ConvertPointsNotifier();
});

final fundWalletProvider = StateNotifierProvider<
    FundWalletNotifier, NotifierState<String>>((ref) {
  return FundWalletNotifier();
});

class GetWalletNotifier extends StateNotifier<NotifierState<WalletResponse>> {
  GetWalletNotifier() : super(NotifierState());

  void getWallet(
      {
        bool? loading = true,
        Function()? then,
        Function(String?)? error}) async {
   loading! ? state = notifyLoading() : null;
    state = await WalletRepository.getWalletBal();
    if (state.status == NotifierStatus.done) {
      SessionManager.setWallet(state.data!.walletBalance ?? "");
      SessionManager.setLoyaltyPoints(state.data!.loyaltyPoints ?? 0);
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class ConvertPointsNotifier extends StateNotifier<NotifierState<String>> {
  ConvertPointsNotifier() : super(NotifierState());

  void convertPoints(
      {
        Function(String)? then,
        Function(String?)? error}) async {
    state = notifyLoading();
    state = await WalletRepository.convertPoints();
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class GetTransactionNotifier extends StateNotifier<NotifierState<TransactionResponse>> {
  GetTransactionNotifier() : super(NotifierState());

  void getTransaction(
      {
        Function()? then,
        Function(String?)? error}) async {
    state = notifyLoading();
    state = await WalletRepository.getTransactions();
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class GetLimitedTransactionNotifier extends StateNotifier<NotifierState<TransactionResponse>> {
  GetLimitedTransactionNotifier() : super(NotifierState());

  void getLimitedTransaction(
      {
        Function()? then,
        Function(String?)? error}) async {
    state = notifyLoading();
    state = await WalletRepository.getLimitedTransactions();
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class FundWalletNotifier extends StateNotifier<NotifierState<String>> {
  FundWalletNotifier() : super(NotifierState());

  void fundWallet(
      {
        required String amount,
        required String reference,
        Function()? then,
        Function(String?)? error}) async {
    state = notifyLoading();
    state = await WalletRepository.fundWallet(amount: amount, reference: reference);
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}