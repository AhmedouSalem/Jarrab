#!/usr/bin/env bash
set -euo pipefail

ROOT="lib"

mkdir -p "$ROOT"

# root files
touch "$ROOT/main.dart" "$ROOT/app.dart"

# core
mkdir -p \
  "$ROOT/core/config" \
  "$ROOT/core/constant" \
  "$ROOT/core/di" \
  "$ROOT/core/error" \
  "$ROOT/core/theme" \
  "$ROOT/core/utils" \
  "$ROOT/core/services"

touch \
  "$ROOT/core/config/app_router.dart" \
  "$ROOT/core/config/routes.dart" \
  "$ROOT/core/config/firebase_collections.dart" \
  "$ROOT/core/constant/app_image_asset.dart" \
  "$ROOT/core/di/injection.dart" \
  "$ROOT/core/error/app_exception.dart" \
  "$ROOT/core/error/failure.dart" \
  "$ROOT/core/error/result.dart" \
  "$ROOT/core/theme/app_theme.dart" \
  "$ROOT/core/utils/validators.dart" \
  "$ROOT/core/utils/util.dart" \
  "$ROOT/core/utils/date_time_utils.dart" \
  "$ROOT/core/services/analytics_service.dart" \
  "$ROOT/core/services/audio_service.dart" \
  "$ROOT/core/services/image_picker_service.dart"

# l10n
mkdir -p "$ROOT/l10n"
touch "$ROOT/l10n/app_en.arb" "$ROOT/l10n/app_fr.arb"

# data layer
mkdir -p \
  "$ROOT/data/datasources/remote" \
  "$ROOT/data/models" \
  "$ROOT/data/mappers" \
  "$ROOT/data/repositories"

touch \
  "$ROOT/data/datasources/remote/auth_remote_ds.dart" \
  "$ROOT/data/datasources/remote/firestore_remote_ds.dart" \
  "$ROOT/data/datasources/remote/storage_remote_ds.dart" \
  "$ROOT/data/models/user_model.dart" \
  "$ROOT/data/models/category_model.dart" \
  "$ROOT/data/models/quiz_model.dart" \
  "$ROOT/data/models/question_model.dart" \
  "$ROOT/data/models/leaderboard_entry_model.dart" \
  "$ROOT/data/mappers/user_mapper.dart" \
  "$ROOT/data/mappers/category_mapper.dart" \
  "$ROOT/data/mappers/quiz_mapper.dart" \
  "$ROOT/data/mappers/question_mapper.dart" \
  "$ROOT/data/mappers/leaderboard_entry_mapper.dart" \
  "$ROOT/data/repositories/auth_repository_impl.dart" \
  "$ROOT/data/repositories/user_repository_impl.dart" \
  "$ROOT/data/repositories/quiz_repository_impl.dart" \
  "$ROOT/data/repositories/leaderboard_repository_impl.dart"

# domain layer
mkdir -p \
  "$ROOT/domain/entities" \
  "$ROOT/domain/repositories" \
  "$ROOT/domain/usecases/auth" \
  "$ROOT/domain/usecases/user" \
  "$ROOT/domain/usecases/quiz" \
  "$ROOT/domain/usecases/leaderboard"

touch \
  "$ROOT/domain/entities/user.dart" \
  "$ROOT/domain/entities/category.dart" \
  "$ROOT/domain/entities/quiz.dart" \
  "$ROOT/domain/entities/question.dart" \
  "$ROOT/domain/entities/quiz_result.dart" \
  "$ROOT/domain/entities/leaderboard_entry.dart" \
  "$ROOT/domain/repositories/auth_repository.dart" \
  "$ROOT/domain/repositories/user_repository.dart" \
  "$ROOT/domain/repositories/quiz_repository.dart" \
  "$ROOT/domain/repositories/leaderboard_repository.dart" \
  "$ROOT/domain/usecases/auth/sign_in.dart" \
  "$ROOT/domain/usecases/auth/sign_up.dart" \
  "$ROOT/domain/usecases/auth/sign_out.dart" \
  "$ROOT/domain/usecases/auth/auth_state_stream.dart" \
  "$ROOT/domain/usecases/user/get_profile.dart" \
  "$ROOT/domain/usecases/user/update_profile.dart" \
  "$ROOT/domain/usecases/user/upload_avatar.dart" \
  "$ROOT/domain/usecases/quiz/get_categories.dart" \
  "$ROOT/domain/usecases/quiz/get_featured_quizzes.dart" \
  "$ROOT/domain/usecases/quiz/search_quizzes.dart" \
  "$ROOT/domain/usecases/quiz/get_quiz_questions.dart" \
  "$ROOT/domain/usecases/quiz/submit_quiz.dart" \
  "$ROOT/domain/usecases/leaderboard/get_weekly_leaderboard.dart" \
  "$ROOT/domain/usecases/leaderboard/get_all_time_leaderboard.dart"

# helper to create a feature with standard BLoC layout
create_feature() {
  local f="$1"
  mkdir -p \
    "$ROOT/features/$f/presentation/pages" \
    "$ROOT/features/$f/presentation/widgets" \
    "$ROOT/features/$f/presentation/bloc"

  # bloc files
  touch \
    "$ROOT/features/$f/presentation/bloc/${f}_bloc.dart" \
    "$ROOT/features/$f/presentation/bloc/${f}_event.dart" \
    "$ROOT/features/$f/presentation/bloc/${f}_state.dart"
}

mkdir -p "$ROOT/features"

# features
create_feature "splash"
touch "$ROOT/features/splash/presentation/pages/splash_page.dart"

create_feature "auth"
touch "$ROOT/features/auth/presentation/pages/login_signup_page.dart"

create_feature "home"
touch \
  "$ROOT/features/home/presentation/pages/home_page.dart" \
  "$ROOT/features/home/presentation/widgets/featured_quiz_card.dart" \
  "$ROOT/features/home/presentation/widgets/category_card.dart"

create_feature "quiz"
touch \
  "$ROOT/features/quiz/presentation/pages/quiz_page.dart" \
  "$ROOT/features/quiz/presentation/widgets/option_tile.dart" \
  "$ROOT/features/quiz/presentation/widgets/timer_bar.dart"

create_feature "results"
touch "$ROOT/features/results/presentation/pages/results_page.dart"

create_feature "leaderboard"
touch "$ROOT/features/leaderboard/presentation/pages/leaderboard_page.dart"

create_feature "profile"
touch \
  "$ROOT/features/profile/presentation/pages/profile_page.dart" \
  "$ROOT/features/profile/presentation/pages/edit_profile_page.dart"

create_feature "settings"
touch "$ROOT/features/settings/presentation/pages/settings_page.dart"

echo "✅ Architecture created under ./lib"
