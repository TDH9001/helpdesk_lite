import 'package:flutter/widgets.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/data/model/customer_auth_model.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/data/model/customer_auth_static_model.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/data/repos/customer_authentication_repo.dart';

// Team-Lead-Owned Implementation
class CustomerAuthenticationRepoImpl implements CustomerAuthenticationRepo {
  @override
  Future<CustomerAuthStaticModel> getCustomerAuthStaticData(
    BuildContext context,
  ) async {
    return StaticCustomerAuthenticationRepository.getStaticData(context);
  }

  @override
  Future<CustomerAuthModel> login({
    required String email,
    required String password,
  }) async {
    //! <Where login API integration should be handled>
    return CustomerAuthModel(
      email: email,
      token: 'mock_token',
      userId: 'mock_user_id',
    );
  }

  @override
  Future<CustomerAuthModel> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    //! <Where signup API integration should be handled>
    return CustomerAuthModel(
      email: email,
      token: 'mock_token',
      userId: 'mock_user_id',
    );
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    //! <Where password reset API integration should be handled>
  }
}
