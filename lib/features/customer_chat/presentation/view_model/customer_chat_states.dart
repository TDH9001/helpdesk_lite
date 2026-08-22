import 'package:flutter/foundation.dart';

/// Pure empty state representations for Customer Chat screen.
@immutable
abstract class CustomerChatStates {
  const CustomerChatStates();
}

class CustomerChatInitial extends CustomerChatStates {
  const CustomerChatInitial();
}

class CustomerChatLoading extends CustomerChatStates {
  const CustomerChatLoading();
}

class CustomerChatLoaded extends CustomerChatStates {
  const CustomerChatLoaded();
}

class CustomerChatSending extends CustomerChatStates {
  const CustomerChatSending();
}

class CustomerChatFailure extends CustomerChatStates {
  const CustomerChatFailure();
}
