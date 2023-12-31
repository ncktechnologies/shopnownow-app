import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/modules/homepage/model/homepage_model.dart';
import 'package:shopnownow/modules/homepage/repository/homepage_repository.dart';

final getCategoriesProvider = StateNotifierProvider<GetCategoriesNotifier,
    NotifierState<List<GetCategories>>>((ref) {
  return GetCategoriesNotifier();
});

final getProductsBySearchProvider = StateNotifierProvider<
    GetProductsBySearchNotifier, NotifierState<GetProductsBySearch>>((ref) {
  return GetProductsBySearchNotifier();
});

final addToListProvider =
    StateNotifierProvider<AddToListNotifier, NotifierState<String>>((ref) {
  return AddToListNotifier();
});

final getLocationsProvider =
    StateNotifierProvider<GetLocationsNotifier, NotifierState<GetLocation>>(
        (ref) {
  return GetLocationsNotifier();
});

final getTimeSlotProvider =
    StateNotifierProvider<GetTimeSlotNotifier, NotifierState<GetTimeSlot>>(
        (ref) {
  return GetTimeSlotNotifier();
});

final createOrderProvider = StateNotifierProvider<CreateOrderNotifier,
    NotifierState<Map<String, dynamic>>>((ref) {
  return CreateOrderNotifier();
});

final processPaymentProvider =
    StateNotifierProvider<ProcessPaymentNotifier, NotifierState<String>>((ref) {
  return ProcessPaymentNotifier();
});

final processPaymentProvider2 = StateNotifierProvider.family<
    ProcessPaymentNotifier, NotifierState<String>, int>((ref, id) {
  return ProcessPaymentNotifier();
});

final loadCouponProvider =
    StateNotifierProvider<LoadCouponNotifier, NotifierState<String>>((ref) {
  return LoadCouponNotifier();
});

final getContactProvider = StateNotifierProvider<GetContactNotifier,
    NotifierState<Map<String, dynamic>>>((ref) {
  return GetContactNotifier();
});

final getQuickGuideProvider = StateNotifierProvider<GetQuickGuideNotifier,
    NotifierState<List<GetQuickGuide>>>((ref) {
  return GetQuickGuideNotifier();
});

class GetCategoriesNotifier
    extends StateNotifier<NotifierState<List<GetCategories>>> {
  GetCategoriesNotifier() : super(const NotifierState());

  void getCategories(
      {Function(List<GetCategories>)? then, Function(String?)? error}) async {
        logAnalyticsEvent('open_category');
    state = notifyLoading();
    state = await HomePageRepository.getCategories();
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class GetProductsBySearchNotifier
    extends StateNotifier<NotifierState<GetProductsBySearch>> {
  GetProductsBySearchNotifier() : super(const NotifierState());

  void getProductsBySearch(
      {required String query,
      required String categoryId,
      Function(List<Product>)? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await HomePageRepository.getProductsBySearch(
        query: query, categoryId: categoryId);
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!.products!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class AddToListNotifier extends StateNotifier<NotifierState<String>> {
  AddToListNotifier() : super(const NotifierState());

  void addToList(
      {required AddProductRequest request,
      Function(String)? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await HomePageRepository.addToList(request: request);
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class GetLocationsNotifier extends StateNotifier<NotifierState<GetLocation>> {
  GetLocationsNotifier() : super(const NotifierState());

  void getLocations(
      {Function(List<Location>)? then, Function(String?)? error}) async {
    state = notifyLoading();
    state = await HomePageRepository.getLocations();
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!.locations!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class GetTimeSlotNotifier extends StateNotifier<NotifierState<GetTimeSlot>> {
  GetTimeSlotNotifier() : super(const NotifierState());

  void getTimeSlot(
      {Function(List<TimeSlot>)? then, Function(String?)? error}) async {
    state = notifyLoading();
    state = await HomePageRepository.getTimeSlot();
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!.timeSlots!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class CreateOrderNotifier
    extends StateNotifier<NotifierState<Map<String, dynamic>>> {
  CreateOrderNotifier() : super(const NotifierState());

  void createOrder(
      {required CreateOrderRequest orderRequest,
      Function(Map<String, dynamic>)? then,
      Function(String?)? error}) async {
    logAnalyticsEvent('begin_checkout');
    state = notifyLoading();
    state = await HomePageRepository.createOrder(orderRequest: orderRequest);
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class ProcessPaymentNotifier extends StateNotifier<NotifierState<String>> {
  ProcessPaymentNotifier() : super(const NotifierState());

  void processPayment(
      {required ProcessPaymentRequest paymentRequest,
      Function(String)? then,
      bool noToken = false,
      Function(String?)? error}) async {
        logAnalyticsEvent('complete_payment');
    state = notifyLoading();
    state = await HomePageRepository.processPayment(
        paymentRequest: paymentRequest, noToken: noToken);
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class LoadCouponNotifier extends StateNotifier<NotifierState<String>> {
  LoadCouponNotifier() : super(const NotifierState());

  void loadCoupon(
      {required String coupon,
      Function(String)? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await HomePageRepository.loadCoupon(coupon: coupon);
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class GetContactNotifier
    extends StateNotifier<NotifierState<Map<String, dynamic>>> {
  GetContactNotifier() : super(const NotifierState());

  void getContact({Function()? then, Function(String?)? error}) async {
    state = notifyLoading();
    state = await HomePageRepository.getContact();
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class GetQuickGuideNotifier
    extends StateNotifier<NotifierState<List<GetQuickGuide>>> {
  GetQuickGuideNotifier() : super(const NotifierState());

  void getQuickGuide({Function()? then, Function(String?)? error}) async {
    state = notifyLoading();
    state = await HomePageRepository.getQuickGuide();
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

Future<void> logAnalyticsEvent(String eventName) async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await analytics.logEvent(
    name: eventName,
    parameters: <String, dynamic>{
      'string': 'string',
      'int': 42,
      'long': 12345678910,
      'double': 42.0,
      'bool': true.toString(), // Convert bool to String
    },
  );
}
