import 'package:bloc/bloc.dart';
import 'package:news_app/models/news/cubit/news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
}
