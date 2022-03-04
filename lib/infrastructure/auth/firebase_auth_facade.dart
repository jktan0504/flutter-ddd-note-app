import 'dart:developer';

import 'package:domain_driven/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/auth/i_auth_facade.dart';
import 'package:domain_driven/domain/auth/value_objects.dart';
import 'package:domain_driven/domain/core/errors.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthFacade implements IAuthFacade {
	final FirebaseAuth _firebaseAuth;
	final GoogleSignIn _googleSignIn;

	FirebaseAuthFacade(
		this._firebaseAuth,
		this._googleSignIn
	);

	@override
	Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({required EmailAddress emailAddress, required Password password}) async {
		final emailAddressStr = emailAddress.getOrCrash();
		final passwordStr = password.getOrCrash();
		
		try {
			await _firebaseAuth.createUserWithEmailAndPassword(email: emailAddressStr, password: passwordStr);
			return right(unit);
		} on PlatformException catch (e) {
			if (e.code == 'email-already-in-use') {
				return left(const AuthFailure.emailAlreadyInUse());
			}
			else {
				return left(const AuthFailure.serverError());
			}
		}
	}

	@override
	Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({required EmailAddress emailAddress, required Password password}) async {
		final emailAddressStr = emailAddress.getOrCrash();
		final passwordStr = password.getOrCrash();

		try {
			await _firebaseAuth.signInWithEmailAndPassword(email: emailAddressStr, password: passwordStr);
			return right(unit);
		} on PlatformException catch (e) {
			if (e.code == 'invalid-email' || e.code == 'wrong-password' || e.code == 'user-not-found') {
				return left(const AuthFailure.invalidEmailAndPasswordCombination());
			}
			else {
				return left(const AuthFailure.serverError());
			}
		}
	}

	@override
	Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
		final googleCurrentUser = await _googleSignIn.signIn();
		// ignore: unnecessary_null_comparison
		if (googleCurrentUser == null) {
			return left(const AuthFailure.serverError());
		}
		final googleAuthentication = await googleCurrentUser.authentication;
		final authCredential = GoogleAuthProvider.credential(accessToken: googleAuthentication.accessToken, idToken: googleAuthentication.idToken);

		return _firebaseAuth.signInWithCredential(authCredential).then((r) => right(unit));
	}
}