import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/auth/auth_failure.dart';
import 'package:domain_driven/domain/auth/i_auth_facade.dart';
import 'package:domain_driven/domain/auth/value_objects.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

part 'sign_in_form_bloc.freezed.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
	
	final IAuthFacade _authFacade;

	SignInFormBloc(this._authFacade) : super(
		SignInFormState.initial()
	) {
		on<SignInFormEvent>((event, emit) {
			// TODO: implement event handler
		});
  	}
}