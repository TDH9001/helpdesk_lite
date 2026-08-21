import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view_models/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginStates());
}
