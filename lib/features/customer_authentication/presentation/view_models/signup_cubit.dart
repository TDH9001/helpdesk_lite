import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view_models/signup_states.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupStates());
}
