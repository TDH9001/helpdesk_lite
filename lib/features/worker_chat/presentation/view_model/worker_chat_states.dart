/// Pure empty state representations for Worker Chat screen.
abstract class WorkerChatStates {}

class WorkerChatInitial extends WorkerChatStates {}

class WorkerChatLoading extends WorkerChatStates {}

class WorkerChatLoaded extends WorkerChatStates {}

class WorkerChatModeChanged extends WorkerChatStates {}

class WorkerChatSending extends WorkerChatStates {}

class WorkerChatFailure extends WorkerChatStates {}

