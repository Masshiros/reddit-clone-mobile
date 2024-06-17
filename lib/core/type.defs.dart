import 'package:fpdart/fpdart.dart';
import 'package:reddit_mobile/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef VoidEither = FutureEither<void>;
