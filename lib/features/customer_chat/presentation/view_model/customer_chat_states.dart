/// State representations for Customer Chat screen.
abstract class CustomerChatStates {}

class CustomerChatInitial extends CustomerChatStates {}

class CustomerChatLoading extends CustomerChatStates {}

class CustomerChatLoaded extends CustomerChatStates {}

class CustomerChatSending extends CustomerChatStates {}

class CustomerChatFailure extends CustomerChatStates {}
