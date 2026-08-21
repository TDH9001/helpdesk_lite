/// States representing the provisioning lifecycle for a new agent.
class AddNewAgentStates {}

class AddNewAgentInitial extends AddNewAgentStates {}

class AddNewAgentLoading extends AddNewAgentStates {}

class AddNewAgentSuccess extends AddNewAgentStates {}

class AddNewAgentFailure extends AddNewAgentStates {}
