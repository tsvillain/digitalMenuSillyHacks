import 'dart:async';

import 'package:digitalMenuCustomer/Bloc/storeEvent.dart';
import 'package:digitalMenuCustomer/Model/storeModel.dart';
import 'package:digitalMenuCustomer/Service/fetchData.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class StoreBloc extends Bloc {
  FetchData fetchData = FetchData();
  Store _store;
  Store get getStore => _store;

  StreamController<StoreEvent> _storeEventController =
      StreamController<StoreEvent>.broadcast();
  StreamSink<StoreEvent> get eventSink => _storeEventController.sink;
  Stream<StoreEvent> get _eventStream => _storeEventController.stream;

  StreamController<Store> _storeController =
      StreamController<Store>.broadcast();
  StreamSink<Store> get _storeSink => _storeController.sink;
  Stream<Store> get storeStream => _storeController.stream;

  StoreBloc() {
    _eventStream.listen(_mapEventToState);
  }

  void _mapEventToState(StoreEvent event) async {
    if (event is GetStore) {
      _store = await fetchData.getStore(event.storeId);
      _storeSink.add(_store);
    }
  }

  @override
  void dispose() {
    _storeEventController.close();
    _storeController.close();
  }
}
