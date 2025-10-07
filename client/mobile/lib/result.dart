// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// Modified by Fruna97

sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok._;

  const factory Result.error(T error) = Error._;
}

final class Ok<T> extends Result<T> {
  final T value;

  const Ok._(this.value);
}

final class Error<T> extends Result<T> {
  final T error;

  const Error._(this.error);
}
