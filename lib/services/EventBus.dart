import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ProductContentEvent{
  String? str;

  ProductContentEvent({this.str});
}

class UserEvent{
  String? str;

  UserEvent({this.str});
}

class AddressEvent{
  String? str;

  AddressEvent({this.str});
}

class CheckOutEvent{
  String? str;

  CheckOutEvent({this.str});
}