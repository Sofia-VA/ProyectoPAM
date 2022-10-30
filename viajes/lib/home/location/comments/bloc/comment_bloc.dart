import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<WriteToCommentBoxEvent>(_changeFocus);
  }

  FutureOr<void> _changeFocus(
      WriteToCommentBoxEvent event, Emitter<CommentState> emit) {
    emit(FocusCommentBoxState());
  }
}
