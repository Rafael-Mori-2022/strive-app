/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 6
/// Strings: 1278 (213 per locale)
///
/// Built on 2025-12-20 at 20:09 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.pt;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.pt) // set locale
/// - Locale locale = AppLocale.pt.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.pt) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	pt(languageCode: 'pt', build: Translations.build),
	en(languageCode: 'en', build: _StringsEn.build),
	es(languageCode: 'es', build: _StringsEs.build),
	fr(languageCode: 'fr', build: _StringsFr.build),
	it(languageCode: 'it', build: _StringsIt.build),
	zh(languageCode: 'zh', build: _StringsZh.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.pt,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pt>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _StringsCommonPt common = _StringsCommonPt._(_root);
	late final _StringsLoginPt login = _StringsLoginPt._(_root);
	late final _StringsDashboardPt dashboard = _StringsDashboardPt._(_root);
	late final _StringsSuccessPt success = _StringsSuccessPt._(_root);
	late final _StringsUnderConstructionPt under_construction = _StringsUnderConstructionPt._(_root);
	late final _StringsEditStatsPt edit_stats = _StringsEditStatsPt._(_root);
	late final _StringsAddFoodPt add_food = _StringsAddFoodPt._(_root);
	late final _StringsDietPt diet = _StringsDietPt._(_root);
	late final _StringsMealDetailPt meal_detail = _StringsMealDetailPt._(_root);
	late final _StringsExplorePt explore = _StringsExplorePt._(_root);
	late final _StringsLeaderboardPt leaderboard = _StringsLeaderboardPt._(_root);
	late final _StringsProfileSetupPt profile_setup = _StringsProfileSetupPt._(_root);
	late final _StringsProfilePt profile = _StringsProfilePt._(_root);
	late final _StringsAddExercisePt add_exercise = _StringsAddExercisePt._(_root);
	late final _StringsWorkoutCreatePt workout_create = _StringsWorkoutCreatePt._(_root);
	late final _StringsWorkoutEditorPt workout_editor = _StringsWorkoutEditorPt._(_root);
	late final _StringsWorkoutPt workout = _StringsWorkoutPt._(_root);
	late final _StringsMockPt mock = _StringsMockPt._(_root);
}

// Path: common
class _StringsCommonPt {
	_StringsCommonPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get error => 'Erro ao carregar';
	String get error_profile => 'Erro ao carregar perfil';
	String get error_stats => 'Erro ao carregar estatísticas';
	String get back => 'Voltar';
	String get cancel => 'Cancelar';
	String get save => 'Salvar';
	String get not_authenticated => 'Usuário não autenticado.';
	String get xp_abbr => 'XP';
	String get league => 'Liga';
	String rank_pattern({required Object rank}) => 'Rank #${rank}';
	String get empty_list => 'Lista vazia';
}

// Path: login
class _StringsLoginPt {
	_StringsLoginPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get tagline => 'Seu esforço, seus dados,\nseus resultados.';
	String get google_button => 'Entrar com Google';
	String get terms_disclaimer => 'Ao continuar, você concorda com nossos Termos.';
}

// Path: dashboard
class _StringsDashboardPt {
	_StringsDashboardPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get level_abbr => 'nvl.';
	String get greeting => 'Olá, ';
	String get greeting_generic => 'Olá!';
	String get subtitle => 'Vamos juntos alcançar suas metas de saúde!';
	late final _StringsDashboardClassificationPt classification = _StringsDashboardClassificationPt._(_root);
	late final _StringsDashboardStatsPt stats = _StringsDashboardStatsPt._(_root);
}

// Path: success
class _StringsSuccessPt {
	_StringsSuccessPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Sucesso';
	String get default_message => 'Tudo Certo! Seus dados foram cadastrados!';
}

// Path: under_construction
class _StringsUnderConstructionPt {
	_StringsUnderConstructionPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '404';
	String get message => 'Essa página ainda está em construção!';
	String get subtitle => 'Estava fazendo seu cardio e se perdeu?';
}

// Path: edit_stats
class _StringsEditStatsPt {
	_StringsEditStatsPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Editar destaques';
	String get instruction => 'Selecione até 4 estatísticas para destacar';
}

// Path: add_food
class _StringsAddFoodPt {
	_StringsAddFoodPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Adicionar Alimento';
	String get search_hint => 'Busque ex: "Maçã", "Whey"...';
	String get not_found => 'Nenhum alimento encontrado';
	String get error_api => 'Erro na conexão com a API';
	String get instruction => 'Digite para buscar na base de dados global';
	String get macro_p => 'P';
	String get macro_c => 'C';
	String get macro_f => 'G';
}

// Path: diet
class _StringsDietPt {
	_StringsDietPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Dieta';
	late final _StringsDietWaterPt water = _StringsDietWaterPt._(_root);
	late final _StringsDietMacrosPt macros = _StringsDietMacrosPt._(_root);
	late final _StringsDietMealPt meal = _StringsDietMealPt._(_root);
	late final _StringsDietMealTypesPt meal_types = _StringsDietMealTypesPt._(_root);
}

// Path: meal_detail
class _StringsMealDetailPt {
	_StringsMealDetailPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Detalhes da Refeição';
	String macro_summary({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal • P ${protein}g • C ${carbs}g • G ${fat}g';
	String item_details({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal - P ${protein}g C ${carbs}g G ${fat}g';
}

// Path: explore
class _StringsExplorePt {
	_StringsExplorePt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Explorar';
	String get search_hint => 'Buscar funcionalidade';
	String get not_found => 'Nenhuma funcionalidade encontrada.';
	late final _StringsExploreCategoriesPt categories = _StringsExploreCategoriesPt._(_root);
}

// Path: leaderboard
class _StringsLeaderboardPt {
	_StringsLeaderboardPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Leaderboard';
	String get error => 'Erro ao carregar leaderboard';
	late final _StringsLeaderboardZonesPt zones = _StringsLeaderboardZonesPt._(_root);
	late final _StringsLeaderboardEntryPt entry = _StringsLeaderboardEntryPt._(_root);
	late final _StringsLeaderboardLeaguesPt leagues = _StringsLeaderboardLeaguesPt._(_root);
}

// Path: profile_setup
class _StringsProfileSetupPt {
	_StringsProfileSetupPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title_edit => 'Editar Perfil';
	String get title_create => 'Criar Perfil';
	String get welcome => 'Bem-vindo(a)!';
	String get subtitle => 'Vamos configurar seu perfil para personalizar sua jornada.';
	late final _StringsProfileSetupSectionsPt sections = _StringsProfileSetupSectionsPt._(_root);
	late final _StringsProfileSetupFieldsPt fields = _StringsProfileSetupFieldsPt._(_root);
	late final _StringsProfileSetupActionsPt actions = _StringsProfileSetupActionsPt._(_root);
	late final _StringsProfileSetupFeedbackPt feedback = _StringsProfileSetupFeedbackPt._(_root);
	late final _StringsProfileSetupGoalsPt goals = _StringsProfileSetupGoalsPt._(_root);
	late final _StringsProfileSetupGendersPt genders = _StringsProfileSetupGendersPt._(_root);
}

// Path: profile
class _StringsProfilePt {
	_StringsProfilePt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Perfil';
	String stats_format({required Object age, required Object height, required Object weight}) => '${age} anos • ${height} cm • ${weight} kg';
	String get dark_mode => 'Modo Escuro';
	String get edit_profile => 'Atualizar perfil';
	String get view_leaderboard => 'Ver Leaderboard';
	String get logout => 'Sair (Logout)';
	String get not_found => 'Perfil não encontrado';
	String get create_profile => 'Criar perfil';
	String get default_user => 'Atleta';
}

// Path: add_exercise
class _StringsAddExercisePt {
	_StringsAddExercisePt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Adicionar Exercício';
	String get search_hint => 'Buscar por grupo muscular (ex: Peito, Costas)';
	String error({required Object error}) => 'Erro: ${error}';
	String empty_title({required Object query}) => 'Nenhum exercício encontrado para "${query}"';
	String get empty_subtitle => 'Tente: Peito, Costas, Pernas, Bíceps...';
	String added_feedback({required Object name}) => '${name} adicionado ao treino!';
}

// Path: workout_create
class _StringsWorkoutCreatePt {
	_StringsWorkoutCreatePt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Novo Plano';
	String get subtitle => 'Dê um nome para sua nova rotina de treinos.';
	String get field_label => 'Nome do Treino';
	String get field_hint => 'Ex: Treino A';
	String get validator_error => 'Por favor, dê um nome ao treino.';
	String get button_create => 'Criar Treino';
	String get suggestions_label => 'Sugestões rápidas:';
	String success_feedback({required Object name}) => 'Treino "${name}" criado!';
	String error_feedback({required Object error}) => 'Erro ao criar: ${error}';
	late final _StringsWorkoutCreateSuggestionsPt suggestions = _StringsWorkoutCreateSuggestionsPt._(_root);
}

// Path: workout_editor
class _StringsWorkoutEditorPt {
	_StringsWorkoutEditorPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Editar Treino';
	String get add_button => 'Adicionar';
	String error({required Object error}) => 'Erro: ${error}';
	String get not_found => 'Plano não encontrado.';
	String get empty_text => 'Este treino está vazio.';
	String get add_exercise_button => 'Adicionar Exercício';
	String removed_snackbar({required Object name}) => '${name} removido';
	late final _StringsWorkoutEditorRemoveDialogPt remove_dialog = _StringsWorkoutEditorRemoveDialogPt._(_root);
}

// Path: workout
class _StringsWorkoutPt {
	_StringsWorkoutPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Treino';
	String get create_tooltip => 'Criar novo plano';
	late final _StringsWorkoutEmptyStatePt empty_state = _StringsWorkoutEmptyStatePt._(_root);
	late final _StringsWorkoutSummaryPt summary = _StringsWorkoutSummaryPt._(_root);
	late final _StringsWorkoutOptionsPt options = _StringsWorkoutOptionsPt._(_root);
	late final _StringsWorkoutDialogsPt dialogs = _StringsWorkoutDialogsPt._(_root);
	String get plan_empty => 'Este plano está vazio.';
	String get add_exercise_short => 'Exercício';
	late final _StringsWorkoutCalendarPt calendar = _StringsWorkoutCalendarPt._(_root);
}

// Path: mock
class _StringsMockPt {
	_StringsMockPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsMockExplorePt explore = _StringsMockExplorePt._(_root);
	late final _StringsMockStatsPt stats = _StringsMockStatsPt._(_root);
}

// Path: dashboard.classification
class _StringsDashboardClassificationPt {
	_StringsDashboardClassificationPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '⭐ Classificação';
	String get remaining_prefix => 'restam ';
	String get remaining_suffix => ' dias';
	String get rank_suffix => 'º Lugar';
}

// Path: dashboard.stats
class _StringsDashboardStatsPt {
	_StringsDashboardStatsPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Estatísticas';
	String get empty => 'Edite para adicionar estatísticas.';
}

// Path: diet.water
class _StringsDietWaterPt {
	_StringsDietWaterPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get edit_goal_title => 'Definir Meta de Água';
	String get liters_label => 'Litros';
	String get edit_stepper_title => 'Quantidade por Clique';
	String get ml_label => 'Mililitros (ml)';
	String goal_display({required Object value}) => 'Meta: ${value} L';
}

// Path: diet.macros
class _StringsDietMacrosPt {
	_StringsDietMacrosPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get carbs => 'Carboidrato';
	String get protein => 'Proteína';
	String get fat => 'Gordura';
}

// Path: diet.meal
class _StringsDietMealPt {
	_StringsDietMealPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String more_items({required Object count}) => '+ ${count} outros itens';
	String total_calories({required Object calories}) => 'Total: ${calories} kcal';
	String get empty => 'Nenhum alimento registrado';
	String get not_found => 'Refeição não encontrada';
}

// Path: diet.meal_types
class _StringsDietMealTypesPt {
	_StringsDietMealTypesPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get breakfast => 'Café da Manhã';
	String get morning_snack => 'Lanche da Manhã';
	String get lunch => 'Almoço';
	String get afternoon_snack => 'Lanche da Tarde';
	String get dinner => 'Jantar';
	String get supper => 'Ceia';
	String get pre_workout => 'Pré-treino';
	String get post_workout => 'Pós-treino';
	String get snack => 'Lanche';
}

// Path: explore.categories
class _StringsExploreCategoriesPt {
	_StringsExploreCategoriesPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get activity => 'Atividade';
	String get nutrition => 'Alimentação';
	String get sleep => 'Sono';
	String get medication => 'Medicamentos';
	String get body_measurements => 'Medidas Corporais';
	String get mobility => 'Mobilidade';
}

// Path: leaderboard.zones
class _StringsLeaderboardZonesPt {
	_StringsLeaderboardZonesPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get promotion => 'ZONA DE PROMOÇÃO';
	String get demotion => 'ZONA DE REBAIXAMENTO';
}

// Path: leaderboard.entry
class _StringsLeaderboardEntryPt {
	_StringsLeaderboardEntryPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String level({required Object level}) => 'Nível ${level}';
	String xp({required Object value}) => '${value} XP';
}

// Path: leaderboard.leagues
class _StringsLeaderboardLeaguesPt {
	_StringsLeaderboardLeaguesPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get wood => 'MADEIRA';
	String get iron => 'FERRO';
	String get bronze => 'BRONZE';
	String get silver => 'PRATA';
	String get gold => 'OURO';
	String get platinum => 'PLATINA';
	String get diamond => 'DIAMANTE';
	String get obsidian => 'OBSIDIANA';
	String get master => 'MESTRE';
	String get stellar => 'ESTELAR';
	String get legend => 'LENDA';
}

// Path: profile_setup.sections
class _StringsProfileSetupSectionsPt {
	_StringsProfileSetupSectionsPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get about => 'Sobre você';
	String get measures => 'Medidas';
	String get goal => 'Objetivo Principal';
}

// Path: profile_setup.fields
class _StringsProfileSetupFieldsPt {
	_StringsProfileSetupFieldsPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'Nome Completo';
	String get name_error => 'Informe seu nome';
	String get dob => 'Nascimento';
	String get gender => 'Gênero';
	String get height => 'Altura (cm)';
	String get weight => 'Peso (kg)';
	String get goal_select => 'Selecione seu objetivo';
	String get required_error => 'Obrigatório';
}

// Path: profile_setup.actions
class _StringsProfileSetupActionsPt {
	_StringsProfileSetupActionsPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get save => 'Salvar Alterações';
	String get finish => 'Finalizar Cadastro';
}

// Path: profile_setup.feedback
class _StringsProfileSetupFeedbackPt {
	_StringsProfileSetupFeedbackPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get fill_all => 'Por favor, preencha todos os campos.';
	String get success => 'Perfil salvo com sucesso!';
	String error({required Object error}) => 'Erro ao salvar: ${error}';
}

// Path: profile_setup.goals
class _StringsProfileSetupGoalsPt {
	_StringsProfileSetupGoalsPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get lose_weight => 'Perder Peso';
	String get gain_muscle => 'Ganhar Massa Muscular';
	String get endurance => 'Melhorar Resistência';
	String get health => 'Manter Saúde';
}

// Path: profile_setup.genders
class _StringsProfileSetupGendersPt {
	_StringsProfileSetupGendersPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get male => 'Masculino';
	String get female => 'Feminino';
	String get other => 'Outro';
}

// Path: workout_create.suggestions
class _StringsWorkoutCreateSuggestionsPt {
	_StringsWorkoutCreateSuggestionsPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get full_body => 'Full Body';
	String get upper_body => 'Upper Body';
	String get lower_body => 'Lower Body';
	String get push_day => 'Push Day';
	String get pull_day => 'Pull Day';
	String get leg_day => 'Leg Day';
	String get cardio_abs => 'Cardio & Abs';
	String get yoga_flow => 'Yoga Flow';
}

// Path: workout_editor.remove_dialog
class _StringsWorkoutEditorRemoveDialogPt {
	_StringsWorkoutEditorRemoveDialogPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Remover exercício?';
	String content({required Object name}) => 'Deseja remover ${name}?';
	String get confirm => 'Remover';
}

// Path: workout.empty_state
class _StringsWorkoutEmptyStatePt {
	_StringsWorkoutEmptyStatePt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Nenhum plano de treino encontrado.';
	String get button => 'Criar meu primeiro treino';
}

// Path: workout.summary
class _StringsWorkoutSummaryPt {
	_StringsWorkoutSummaryPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get today => 'Hoje';
}

// Path: workout.options
class _StringsWorkoutOptionsPt {
	_StringsWorkoutOptionsPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get rename => 'Renomear Plano';
	String get delete => 'Excluir Plano';
}

// Path: workout.dialogs
class _StringsWorkoutDialogsPt {
	_StringsWorkoutDialogsPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get rename_label => 'Nome do treino';
	String get delete_title => 'Excluir Plano?';
	String delete_content({required Object name}) => 'Tem certeza que deseja excluir "${name}"? Esta ação não pode ser desfeita.';
	String get delete_confirm => 'Excluir';
}

// Path: workout.calendar
class _StringsWorkoutCalendarPt {
	_StringsWorkoutCalendarPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	List<String> get months => [
		'',
		'Janeiro',
		'Fevereiro',
		'Março',
		'Abril',
		'Maio',
		'Junho',
		'Julho',
		'Agosto',
		'Setembro',
		'Outubro',
		'Novembro',
		'Dezembro',
	];
	List<String> get weekdays => [
		'D',
		'S',
		'T',
		'Q',
		'Q',
		'S',
		'S',
	];
}

// Path: mock.explore
class _StringsMockExplorePt {
	_StringsMockExplorePt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get nutrition => 'Nutrição';
	String get training => 'Treino';
	String get sleep => 'Sono';
	String get mindfulness => 'Mindfulness';
	late final _StringsMockExploreTagsPt tags = _StringsMockExploreTagsPt._(_root);
}

// Path: mock.stats
class _StringsMockStatsPt {
	_StringsMockStatsPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get calories => 'Calorias';
	String get protein => 'Proteína';
	String get carbs => 'Carbo';
	String get fat => 'Gordura';
	String get water => 'Água';
	String get steps => 'Passos';
	String get sleep => 'Sono';
}

// Path: mock.explore.tags
class _StringsMockExploreTagsPt {
	_StringsMockExploreTagsPt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get macros => 'macros';
	String get hydration => 'hidratação';
	String get recipes => 'receitas';
	String get hypertrophy => 'hipertrofia';
	String get strength => 'força';
	String get mobility => 'mobilidade';
	String get hygiene => 'higiene';
	String get cycle => 'ciclo';
	String get breathing => 'respiração';
	String get focus => 'foco';
}

// Path: <root>
class _StringsEn extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	@override late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsCommonEn common = _StringsCommonEn._(_root);
	@override late final _StringsLoginEn login = _StringsLoginEn._(_root);
	@override late final _StringsDashboardEn dashboard = _StringsDashboardEn._(_root);
	@override late final _StringsSuccessEn success = _StringsSuccessEn._(_root);
	@override late final _StringsUnderConstructionEn under_construction = _StringsUnderConstructionEn._(_root);
	@override late final _StringsEditStatsEn edit_stats = _StringsEditStatsEn._(_root);
	@override late final _StringsAddFoodEn add_food = _StringsAddFoodEn._(_root);
	@override late final _StringsDietEn diet = _StringsDietEn._(_root);
	@override late final _StringsMealDetailEn meal_detail = _StringsMealDetailEn._(_root);
	@override late final _StringsExploreEn explore = _StringsExploreEn._(_root);
	@override late final _StringsLeaderboardEn leaderboard = _StringsLeaderboardEn._(_root);
	@override late final _StringsProfileSetupEn profile_setup = _StringsProfileSetupEn._(_root);
	@override late final _StringsProfileEn profile = _StringsProfileEn._(_root);
	@override late final _StringsAddExerciseEn add_exercise = _StringsAddExerciseEn._(_root);
	@override late final _StringsWorkoutCreateEn workout_create = _StringsWorkoutCreateEn._(_root);
	@override late final _StringsWorkoutEditorEn workout_editor = _StringsWorkoutEditorEn._(_root);
	@override late final _StringsWorkoutEn workout = _StringsWorkoutEn._(_root);
	@override late final _StringsMockEn mock = _StringsMockEn._(_root);
}

// Path: common
class _StringsCommonEn extends _StringsCommonPt {
	_StringsCommonEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get error => 'Error loading';
	@override String get error_profile => 'Error loading profile';
	@override String get error_stats => 'Error loading stats';
	@override String get back => 'Back';
	@override String get cancel => 'Cancel';
	@override String get save => 'Save';
	@override String get not_authenticated => 'User not authenticated.';
	@override String get xp_abbr => 'XP';
	@override String get league => 'League';
	@override String rank_pattern({required Object rank}) => 'Rank #${rank}';
	@override String get empty_list => 'Empty list';
}

// Path: login
class _StringsLoginEn extends _StringsLoginPt {
	_StringsLoginEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get tagline => 'Your effort, your data,\nyour results.';
	@override String get google_button => 'Sign in with Google';
	@override String get terms_disclaimer => 'By continuing, you agree to our Terms.';
}

// Path: dashboard
class _StringsDashboardEn extends _StringsDashboardPt {
	_StringsDashboardEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get level_abbr => 'lvl.';
	@override String get greeting => 'Hello, ';
	@override String get greeting_generic => 'Hello!';
	@override String get subtitle => 'Let\'s reach your health goals together!';
	@override late final _StringsDashboardClassificationEn classification = _StringsDashboardClassificationEn._(_root);
	@override late final _StringsDashboardStatsEn stats = _StringsDashboardStatsEn._(_root);
}

// Path: success
class _StringsSuccessEn extends _StringsSuccessPt {
	_StringsSuccessEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Success';
	@override String get default_message => 'All set! Your data has been registered!';
}

// Path: under_construction
class _StringsUnderConstructionEn extends _StringsUnderConstructionPt {
	_StringsUnderConstructionEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => '404';
	@override String get message => 'This page is still under construction!';
	@override String get subtitle => 'Were you doing cardio and got lost?';
}

// Path: edit_stats
class _StringsEditStatsEn extends _StringsEditStatsPt {
	_StringsEditStatsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Edit Highlights';
	@override String get instruction => 'Select up to 4 statistics to highlight';
}

// Path: add_food
class _StringsAddFoodEn extends _StringsAddFoodPt {
	_StringsAddFoodEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Add Food';
	@override String get search_hint => 'Search ex: "Apple", "Whey"...';
	@override String get not_found => 'No food found';
	@override String get error_api => 'Error connecting to API';
	@override String get instruction => 'Type to search the global database';
	@override String get macro_p => 'P';
	@override String get macro_c => 'C';
	@override String get macro_f => 'F';
}

// Path: diet
class _StringsDietEn extends _StringsDietPt {
	_StringsDietEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Diet';
	@override late final _StringsDietWaterEn water = _StringsDietWaterEn._(_root);
	@override late final _StringsDietMacrosEn macros = _StringsDietMacrosEn._(_root);
	@override late final _StringsDietMealEn meal = _StringsDietMealEn._(_root);
	@override late final _StringsDietMealTypesEn meal_types = _StringsDietMealTypesEn._(_root);
}

// Path: meal_detail
class _StringsMealDetailEn extends _StringsMealDetailPt {
	_StringsMealDetailEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Meal Details';
	@override String macro_summary({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal • P ${protein}g • C ${carbs}g • F ${fat}g';
	@override String item_details({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal - P ${protein}g C ${carbs}g F ${fat}g';
}

// Path: explore
class _StringsExploreEn extends _StringsExplorePt {
	_StringsExploreEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Explore';
	@override String get search_hint => 'Search feature';
	@override String get not_found => 'No features found.';
	@override late final _StringsExploreCategoriesEn categories = _StringsExploreCategoriesEn._(_root);
}

// Path: leaderboard
class _StringsLeaderboardEn extends _StringsLeaderboardPt {
	_StringsLeaderboardEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Leaderboard';
	@override String get error => 'Error loading leaderboard';
	@override late final _StringsLeaderboardZonesEn zones = _StringsLeaderboardZonesEn._(_root);
	@override late final _StringsLeaderboardEntryEn entry = _StringsLeaderboardEntryEn._(_root);
	@override late final _StringsLeaderboardLeaguesEn leagues = _StringsLeaderboardLeaguesEn._(_root);
}

// Path: profile_setup
class _StringsProfileSetupEn extends _StringsProfileSetupPt {
	_StringsProfileSetupEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title_edit => 'Edit Profile';
	@override String get title_create => 'Create Profile';
	@override String get welcome => 'Welcome!';
	@override String get subtitle => 'Let\'s set up your profile to personalize your journey.';
	@override late final _StringsProfileSetupSectionsEn sections = _StringsProfileSetupSectionsEn._(_root);
	@override late final _StringsProfileSetupFieldsEn fields = _StringsProfileSetupFieldsEn._(_root);
	@override late final _StringsProfileSetupActionsEn actions = _StringsProfileSetupActionsEn._(_root);
	@override late final _StringsProfileSetupFeedbackEn feedback = _StringsProfileSetupFeedbackEn._(_root);
	@override late final _StringsProfileSetupGoalsEn goals = _StringsProfileSetupGoalsEn._(_root);
	@override late final _StringsProfileSetupGendersEn genders = _StringsProfileSetupGendersEn._(_root);
}

// Path: profile
class _StringsProfileEn extends _StringsProfilePt {
	_StringsProfileEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profile';
	@override String stats_format({required Object age, required Object height, required Object weight}) => '${age} years • ${height} cm • ${weight} kg';
	@override String get dark_mode => 'Dark Mode';
	@override String get edit_profile => 'Update profile';
	@override String get view_leaderboard => 'View Leaderboard';
	@override String get logout => 'Log out';
	@override String get not_found => 'Profile not found';
	@override String get create_profile => 'Create profile';
	@override String get default_user => 'Athlete';
}

// Path: add_exercise
class _StringsAddExerciseEn extends _StringsAddExercisePt {
	_StringsAddExerciseEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Add Exercise';
	@override String get search_hint => 'Search by muscle group (e.g. Chest, Back)';
	@override String error({required Object error}) => 'Error: ${error}';
	@override String empty_title({required Object query}) => 'No exercises found for "${query}"';
	@override String get empty_subtitle => 'Try: Chest, Back, Legs, Biceps...';
	@override String added_feedback({required Object name}) => '${name} added to workout!';
}

// Path: workout_create
class _StringsWorkoutCreateEn extends _StringsWorkoutCreatePt {
	_StringsWorkoutCreateEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'New Plan';
	@override String get subtitle => 'Name your new workout routine.';
	@override String get field_label => 'Workout Name';
	@override String get field_hint => 'Ex: Workout A';
	@override String get validator_error => 'Please name the workout.';
	@override String get button_create => 'Create Workout';
	@override String get suggestions_label => 'Quick suggestions:';
	@override String success_feedback({required Object name}) => 'Workout "${name}" created!';
	@override String error_feedback({required Object error}) => 'Error creating: ${error}';
	@override late final _StringsWorkoutCreateSuggestionsEn suggestions = _StringsWorkoutCreateSuggestionsEn._(_root);
}

// Path: workout_editor
class _StringsWorkoutEditorEn extends _StringsWorkoutEditorPt {
	_StringsWorkoutEditorEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Edit Workout';
	@override String get add_button => 'Add';
	@override String error({required Object error}) => 'Error: ${error}';
	@override String get not_found => 'Plan not found.';
	@override String get empty_text => 'This workout is empty.';
	@override String get add_exercise_button => 'Add Exercise';
	@override String removed_snackbar({required Object name}) => '${name} removed';
	@override late final _StringsWorkoutEditorRemoveDialogEn remove_dialog = _StringsWorkoutEditorRemoveDialogEn._(_root);
}

// Path: workout
class _StringsWorkoutEn extends _StringsWorkoutPt {
	_StringsWorkoutEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Workout';
	@override String get create_tooltip => 'Create new plan';
	@override late final _StringsWorkoutEmptyStateEn empty_state = _StringsWorkoutEmptyStateEn._(_root);
	@override late final _StringsWorkoutSummaryEn summary = _StringsWorkoutSummaryEn._(_root);
	@override late final _StringsWorkoutOptionsEn options = _StringsWorkoutOptionsEn._(_root);
	@override late final _StringsWorkoutDialogsEn dialogs = _StringsWorkoutDialogsEn._(_root);
	@override String get plan_empty => 'This plan is empty.';
	@override String get add_exercise_short => 'Exercise';
	@override late final _StringsWorkoutCalendarEn calendar = _StringsWorkoutCalendarEn._(_root);
}

// Path: mock
class _StringsMockEn extends _StringsMockPt {
	_StringsMockEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override late final _StringsMockExploreEn explore = _StringsMockExploreEn._(_root);
	@override late final _StringsMockStatsEn stats = _StringsMockStatsEn._(_root);
}

// Path: dashboard.classification
class _StringsDashboardClassificationEn extends _StringsDashboardClassificationPt {
	_StringsDashboardClassificationEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => '⭐ Leaderboard';
	@override String get remaining_prefix => 'ending in ';
	@override String get remaining_suffix => ' days';
	@override String get rank_suffix => ' Place';
}

// Path: dashboard.stats
class _StringsDashboardStatsEn extends _StringsDashboardStatsPt {
	_StringsDashboardStatsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistics';
	@override String get empty => 'Edit to add statistics.';
}

// Path: diet.water
class _StringsDietWaterEn extends _StringsDietWaterPt {
	_StringsDietWaterEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get edit_goal_title => 'Set Water Goal';
	@override String get liters_label => 'Liters';
	@override String get edit_stepper_title => 'Amount per Click';
	@override String get ml_label => 'Milliliters (ml)';
	@override String goal_display({required Object value}) => 'Goal: ${value} L';
}

// Path: diet.macros
class _StringsDietMacrosEn extends _StringsDietMacrosPt {
	_StringsDietMacrosEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get carbs => 'Carbs';
	@override String get protein => 'Protein';
	@override String get fat => 'Fat';
}

// Path: diet.meal
class _StringsDietMealEn extends _StringsDietMealPt {
	_StringsDietMealEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String more_items({required Object count}) => '+ ${count} other items';
	@override String total_calories({required Object calories}) => 'Total: ${calories} kcal';
	@override String get empty => 'No food registered';
	@override String get not_found => 'Meal not found';
}

// Path: diet.meal_types
class _StringsDietMealTypesEn extends _StringsDietMealTypesPt {
	_StringsDietMealTypesEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get breakfast => 'Breakfast';
	@override String get morning_snack => 'Morning Snack';
	@override String get lunch => 'Lunch';
	@override String get afternoon_snack => 'Afternoon Snack';
	@override String get dinner => 'Dinner';
	@override String get supper => 'Supper';
	@override String get pre_workout => 'Pre-workout';
	@override String get post_workout => 'Post-workout';
	@override String get snack => 'Snack';
}

// Path: explore.categories
class _StringsExploreCategoriesEn extends _StringsExploreCategoriesPt {
	_StringsExploreCategoriesEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get activity => 'Activity';
	@override String get nutrition => 'Nutrition';
	@override String get sleep => 'Sleep';
	@override String get medication => 'Medication';
	@override String get body_measurements => 'Body Measurements';
	@override String get mobility => 'Mobility';
}

// Path: leaderboard.zones
class _StringsLeaderboardZonesEn extends _StringsLeaderboardZonesPt {
	_StringsLeaderboardZonesEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get promotion => 'PROMOTION ZONE';
	@override String get demotion => 'DEMOTION ZONE';
}

// Path: leaderboard.entry
class _StringsLeaderboardEntryEn extends _StringsLeaderboardEntryPt {
	_StringsLeaderboardEntryEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String level({required Object level}) => 'Level ${level}';
	@override String xp({required Object value}) => '${value} XP';
}

// Path: leaderboard.leagues
class _StringsLeaderboardLeaguesEn extends _StringsLeaderboardLeaguesPt {
	_StringsLeaderboardLeaguesEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get wood => 'WOOD';
	@override String get iron => 'IRON';
	@override String get bronze => 'BRONZE';
	@override String get silver => 'SILVER';
	@override String get gold => 'GOLD';
	@override String get platinum => 'PLATINUM';
	@override String get diamond => 'DIAMOND';
	@override String get obsidian => 'OBSIDIAN';
	@override String get master => 'MASTER';
	@override String get stellar => 'STELLAR';
	@override String get legend => 'LEGEND';
}

// Path: profile_setup.sections
class _StringsProfileSetupSectionsEn extends _StringsProfileSetupSectionsPt {
	_StringsProfileSetupSectionsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get about => 'About you';
	@override String get measures => 'Measurements';
	@override String get goal => 'Main Goal';
}

// Path: profile_setup.fields
class _StringsProfileSetupFieldsEn extends _StringsProfileSetupFieldsPt {
	_StringsProfileSetupFieldsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get name => 'Full Name';
	@override String get name_error => 'Enter your name';
	@override String get dob => 'Birth Date';
	@override String get gender => 'Gender';
	@override String get height => 'Height (cm)';
	@override String get weight => 'Weight (kg)';
	@override String get goal_select => 'Select your goal';
	@override String get required_error => 'Required';
}

// Path: profile_setup.actions
class _StringsProfileSetupActionsEn extends _StringsProfileSetupActionsPt {
	_StringsProfileSetupActionsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get save => 'Save Changes';
	@override String get finish => 'Finish Registration';
}

// Path: profile_setup.feedback
class _StringsProfileSetupFeedbackEn extends _StringsProfileSetupFeedbackPt {
	_StringsProfileSetupFeedbackEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get fill_all => 'Please fill in all fields.';
	@override String get success => 'Profile saved successfully!';
	@override String error({required Object error}) => 'Error saving: ${error}';
}

// Path: profile_setup.goals
class _StringsProfileSetupGoalsEn extends _StringsProfileSetupGoalsPt {
	_StringsProfileSetupGoalsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get lose_weight => 'Lose Weight';
	@override String get gain_muscle => 'Build Muscle';
	@override String get endurance => 'Improve Endurance';
	@override String get health => 'Maintain Health';
}

// Path: profile_setup.genders
class _StringsProfileSetupGendersEn extends _StringsProfileSetupGendersPt {
	_StringsProfileSetupGendersEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get male => 'Male';
	@override String get female => 'Female';
	@override String get other => 'Other';
}

// Path: workout_create.suggestions
class _StringsWorkoutCreateSuggestionsEn extends _StringsWorkoutCreateSuggestionsPt {
	_StringsWorkoutCreateSuggestionsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get full_body => 'Full Body';
	@override String get upper_body => 'Upper Body';
	@override String get lower_body => 'Lower Body';
	@override String get push_day => 'Push Day';
	@override String get pull_day => 'Pull Day';
	@override String get leg_day => 'Leg Day';
	@override String get cardio_abs => 'Cardio & Abs';
	@override String get yoga_flow => 'Yoga Flow';
}

// Path: workout_editor.remove_dialog
class _StringsWorkoutEditorRemoveDialogEn extends _StringsWorkoutEditorRemoveDialogPt {
	_StringsWorkoutEditorRemoveDialogEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Remove exercise?';
	@override String content({required Object name}) => 'Do you want to remove ${name}?';
	@override String get confirm => 'Remove';
}

// Path: workout.empty_state
class _StringsWorkoutEmptyStateEn extends _StringsWorkoutEmptyStatePt {
	_StringsWorkoutEmptyStateEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'No workout plans found.';
	@override String get button => 'Create my first workout';
}

// Path: workout.summary
class _StringsWorkoutSummaryEn extends _StringsWorkoutSummaryPt {
	_StringsWorkoutSummaryEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get today => 'Today';
}

// Path: workout.options
class _StringsWorkoutOptionsEn extends _StringsWorkoutOptionsPt {
	_StringsWorkoutOptionsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get rename => 'Rename Plan';
	@override String get delete => 'Delete Plan';
}

// Path: workout.dialogs
class _StringsWorkoutDialogsEn extends _StringsWorkoutDialogsPt {
	_StringsWorkoutDialogsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get rename_label => 'Workout name';
	@override String get delete_title => 'Delete Plan?';
	@override String delete_content({required Object name}) => 'Are you sure you want to delete "${name}"? This action cannot be undone.';
	@override String get delete_confirm => 'Delete';
}

// Path: workout.calendar
class _StringsWorkoutCalendarEn extends _StringsWorkoutCalendarPt {
	_StringsWorkoutCalendarEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override List<String> get months => [
		'',
		'January',
		'February',
		'March',
		'April',
		'May',
		'June',
		'July',
		'August',
		'September',
		'October',
		'November',
		'December',
	];
	@override List<String> get weekdays => [
		'S',
		'M',
		'T',
		'W',
		'T',
		'F',
		'S',
	];
}

// Path: mock.explore
class _StringsMockExploreEn extends _StringsMockExplorePt {
	_StringsMockExploreEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get nutrition => 'Nutrition';
	@override String get training => 'Training';
	@override String get sleep => 'Sleep';
	@override String get mindfulness => 'Mindfulness';
	@override late final _StringsMockExploreTagsEn tags = _StringsMockExploreTagsEn._(_root);
}

// Path: mock.stats
class _StringsMockStatsEn extends _StringsMockStatsPt {
	_StringsMockStatsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get calories => 'Calories';
	@override String get protein => 'Protein';
	@override String get carbs => 'Carbs';
	@override String get fat => 'Fat';
	@override String get water => 'Water';
	@override String get steps => 'Steps';
	@override String get sleep => 'Sleep';
}

// Path: mock.explore.tags
class _StringsMockExploreTagsEn extends _StringsMockExploreTagsPt {
	_StringsMockExploreTagsEn._(_StringsEn root) : this._root = root, super._(root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get macros => 'macros';
	@override String get hydration => 'hydration';
	@override String get recipes => 'recipes';
	@override String get hypertrophy => 'hypertrophy';
	@override String get strength => 'strength';
	@override String get mobility => 'mobility';
	@override String get hygiene => 'hygiene';
	@override String get cycle => 'cycle';
	@override String get breathing => 'breathing';
	@override String get focus => 'focus';
}

// Path: <root>
class _StringsEs extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEs.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	@override late final _StringsEs _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsCommonEs common = _StringsCommonEs._(_root);
	@override late final _StringsLoginEs login = _StringsLoginEs._(_root);
	@override late final _StringsDashboardEs dashboard = _StringsDashboardEs._(_root);
	@override late final _StringsSuccessEs success = _StringsSuccessEs._(_root);
	@override late final _StringsUnderConstructionEs under_construction = _StringsUnderConstructionEs._(_root);
	@override late final _StringsEditStatsEs edit_stats = _StringsEditStatsEs._(_root);
	@override late final _StringsAddFoodEs add_food = _StringsAddFoodEs._(_root);
	@override late final _StringsDietEs diet = _StringsDietEs._(_root);
	@override late final _StringsMealDetailEs meal_detail = _StringsMealDetailEs._(_root);
	@override late final _StringsExploreEs explore = _StringsExploreEs._(_root);
	@override late final _StringsLeaderboardEs leaderboard = _StringsLeaderboardEs._(_root);
	@override late final _StringsProfileSetupEs profile_setup = _StringsProfileSetupEs._(_root);
	@override late final _StringsProfileEs profile = _StringsProfileEs._(_root);
	@override late final _StringsAddExerciseEs add_exercise = _StringsAddExerciseEs._(_root);
	@override late final _StringsWorkoutCreateEs workout_create = _StringsWorkoutCreateEs._(_root);
	@override late final _StringsWorkoutEditorEs workout_editor = _StringsWorkoutEditorEs._(_root);
	@override late final _StringsWorkoutEs workout = _StringsWorkoutEs._(_root);
	@override late final _StringsMockEs mock = _StringsMockEs._(_root);
}

// Path: common
class _StringsCommonEs extends _StringsCommonPt {
	_StringsCommonEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get error => 'Error al cargar';
	@override String get error_profile => 'Error al cargar perfil';
	@override String get error_stats => 'Error al cargar estadísticas';
	@override String get back => 'Volver';
	@override String get cancel => 'Cancelar';
	@override String get save => 'Guardar';
	@override String get not_authenticated => 'Usuario no autenticado.';
	@override String get xp_abbr => 'XP';
	@override String get league => 'Liga';
	@override String rank_pattern({required Object rank}) => 'Rango #${rank}';
	@override String get empty_list => 'Lista vacía';
}

// Path: login
class _StringsLoginEs extends _StringsLoginPt {
	_StringsLoginEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get tagline => 'Tu esfuerzo, tus datos,\ntus resultados.';
	@override String get google_button => 'Acceder con Google';
	@override String get terms_disclaimer => 'Al continuar, aceptas nuestros Términos.';
}

// Path: dashboard
class _StringsDashboardEs extends _StringsDashboardPt {
	_StringsDashboardEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get level_abbr => 'niv.';
	@override String get greeting => 'Hola, ';
	@override String get greeting_generic => '¡Hola!';
	@override String get subtitle => '¡Alcancemos tus metas de salud juntos!';
	@override late final _StringsDashboardClassificationEs classification = _StringsDashboardClassificationEs._(_root);
	@override late final _StringsDashboardStatsEs stats = _StringsDashboardStatsEs._(_root);
}

// Path: success
class _StringsSuccessEs extends _StringsSuccessPt {
	_StringsSuccessEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Éxito';
	@override String get default_message => '¡Listo! ¡Tus datos han sido registrados!';
}

// Path: under_construction
class _StringsUnderConstructionEs extends _StringsUnderConstructionPt {
	_StringsUnderConstructionEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '404';
	@override String get message => '¡Esta página aún está en construcción!';
	@override String get subtitle => '¿Hacías cardio y te perdiste?';
}

// Path: edit_stats
class _StringsEditStatsEs extends _StringsEditStatsPt {
	_StringsEditStatsEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Editar Destacados';
	@override String get instruction => 'Selecciona hasta 4 estadísticas para destacar';
}

// Path: add_food
class _StringsAddFoodEs extends _StringsAddFoodPt {
	_StringsAddFoodEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Añadir Alimento';
	@override String get search_hint => 'Buscar ej: "Manzana", "Whey"...';
	@override String get not_found => 'Ningún alimento encontrado';
	@override String get error_api => 'Error de conexión con la API';
	@override String get instruction => 'Escribe para buscar en la base global';
	@override String get macro_p => 'P';
	@override String get macro_c => 'C';
	@override String get macro_f => 'G';
}

// Path: diet
class _StringsDietEs extends _StringsDietPt {
	_StringsDietEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dieta';
	@override late final _StringsDietWaterEs water = _StringsDietWaterEs._(_root);
	@override late final _StringsDietMacrosEs macros = _StringsDietMacrosEs._(_root);
	@override late final _StringsDietMealEs meal = _StringsDietMealEs._(_root);
	@override late final _StringsDietMealTypesEs meal_types = _StringsDietMealTypesEs._(_root);
}

// Path: meal_detail
class _StringsMealDetailEs extends _StringsMealDetailPt {
	_StringsMealDetailEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalles de la Comida';
	@override String macro_summary({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal • P ${protein}g • C ${carbs}g • G ${fat}g';
	@override String item_details({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal - P ${protein}g C ${carbs}g G ${fat}g';
}

// Path: explore
class _StringsExploreEs extends _StringsExplorePt {
	_StringsExploreEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Explorar';
	@override String get search_hint => 'Buscar funcionalidad';
	@override String get not_found => 'Ninguna funcionalidad encontrada.';
	@override late final _StringsExploreCategoriesEs categories = _StringsExploreCategoriesEs._(_root);
}

// Path: leaderboard
class _StringsLeaderboardEs extends _StringsLeaderboardPt {
	_StringsLeaderboardEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Clasificación';
	@override String get error => 'Error al cargar clasificación';
	@override late final _StringsLeaderboardZonesEs zones = _StringsLeaderboardZonesEs._(_root);
	@override late final _StringsLeaderboardEntryEs entry = _StringsLeaderboardEntryEs._(_root);
	@override late final _StringsLeaderboardLeaguesEs leagues = _StringsLeaderboardLeaguesEs._(_root);
}

// Path: profile_setup
class _StringsProfileSetupEs extends _StringsProfileSetupPt {
	_StringsProfileSetupEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title_edit => 'Editar Perfil';
	@override String get title_create => 'Crear Perfil';
	@override String get welcome => '¡Bienvenido!';
	@override String get subtitle => 'Configuremos tu perfil para personalizar tu jornada.';
	@override late final _StringsProfileSetupSectionsEs sections = _StringsProfileSetupSectionsEs._(_root);
	@override late final _StringsProfileSetupFieldsEs fields = _StringsProfileSetupFieldsEs._(_root);
	@override late final _StringsProfileSetupActionsEs actions = _StringsProfileSetupActionsEs._(_root);
	@override late final _StringsProfileSetupFeedbackEs feedback = _StringsProfileSetupFeedbackEs._(_root);
	@override late final _StringsProfileSetupGoalsEs goals = _StringsProfileSetupGoalsEs._(_root);
	@override late final _StringsProfileSetupGendersEs genders = _StringsProfileSetupGendersEs._(_root);
}

// Path: profile
class _StringsProfileEs extends _StringsProfilePt {
	_StringsProfileEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Perfil';
	@override String stats_format({required Object age, required Object height, required Object weight}) => '${age} años • ${height} cm • ${weight} kg';
	@override String get dark_mode => 'Modo Oscuro';
	@override String get edit_profile => 'Actualizar perfil';
	@override String get view_leaderboard => 'Ver Clasificación';
	@override String get logout => 'Cerrar Sesión';
	@override String get not_found => 'Perfil no encontrado';
	@override String get create_profile => 'Crear perfil';
	@override String get default_user => 'Atleta';
}

// Path: add_exercise
class _StringsAddExerciseEs extends _StringsAddExercisePt {
	_StringsAddExerciseEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Añadir Ejercicio';
	@override String get search_hint => 'Buscar por músculo (ej: Pecho, Espalda)';
	@override String error({required Object error}) => 'Error: ${error}';
	@override String empty_title({required Object query}) => 'Ningún ejercicio encontrado para "${query}"';
	@override String get empty_subtitle => 'Prueba: Pecho, Espalda, Piernas, Bíceps...';
	@override String added_feedback({required Object name}) => '¡${name} añadido al entrenamiento!';
}

// Path: workout_create
class _StringsWorkoutCreateEs extends _StringsWorkoutCreatePt {
	_StringsWorkoutCreateEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nuevo Plan';
	@override String get subtitle => 'Dale un nombre a tu nueva rutina.';
	@override String get field_label => 'Nombre del Entrenamiento';
	@override String get field_hint => 'Ej: Entrenamiento A';
	@override String get validator_error => 'Por favor nombra el entrenamiento.';
	@override String get button_create => 'Crear Entrenamiento';
	@override String get suggestions_label => 'Sugerencias rápidas:';
	@override String success_feedback({required Object name}) => '¡Entrenamiento "${name}" creado!';
	@override String error_feedback({required Object error}) => 'Error al crear: ${error}';
	@override late final _StringsWorkoutCreateSuggestionsEs suggestions = _StringsWorkoutCreateSuggestionsEs._(_root);
}

// Path: workout_editor
class _StringsWorkoutEditorEs extends _StringsWorkoutEditorPt {
	_StringsWorkoutEditorEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Editar Entrenamiento';
	@override String get add_button => 'Añadir';
	@override String error({required Object error}) => 'Error: ${error}';
	@override String get not_found => 'Plan no encontrado.';
	@override String get empty_text => 'Este entrenamiento está vacío.';
	@override String get add_exercise_button => 'Añadir Ejercicio';
	@override String removed_snackbar({required Object name}) => '${name} eliminado';
	@override late final _StringsWorkoutEditorRemoveDialogEs remove_dialog = _StringsWorkoutEditorRemoveDialogEs._(_root);
}

// Path: workout
class _StringsWorkoutEs extends _StringsWorkoutPt {
	_StringsWorkoutEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Entrenamiento';
	@override String get create_tooltip => 'Crear nuevo plan';
	@override late final _StringsWorkoutEmptyStateEs empty_state = _StringsWorkoutEmptyStateEs._(_root);
	@override late final _StringsWorkoutSummaryEs summary = _StringsWorkoutSummaryEs._(_root);
	@override late final _StringsWorkoutOptionsEs options = _StringsWorkoutOptionsEs._(_root);
	@override late final _StringsWorkoutDialogsEs dialogs = _StringsWorkoutDialogsEs._(_root);
	@override String get plan_empty => 'Este plan está vacío.';
	@override String get add_exercise_short => 'Ejercicio';
	@override late final _StringsWorkoutCalendarEs calendar = _StringsWorkoutCalendarEs._(_root);
}

// Path: mock
class _StringsMockEs extends _StringsMockPt {
	_StringsMockEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override late final _StringsMockExploreEs explore = _StringsMockExploreEs._(_root);
	@override late final _StringsMockStatsEs stats = _StringsMockStatsEs._(_root);
}

// Path: dashboard.classification
class _StringsDashboardClassificationEs extends _StringsDashboardClassificationPt {
	_StringsDashboardClassificationEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '⭐ Clasificación';
	@override String get remaining_prefix => 'termina en ';
	@override String get remaining_suffix => ' días';
	@override String get rank_suffix => 'º Lugar';
}

// Path: dashboard.stats
class _StringsDashboardStatsEs extends _StringsDashboardStatsPt {
	_StringsDashboardStatsEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Estadísticas';
	@override String get empty => 'Editar para agregar estadísticas.';
}

// Path: diet.water
class _StringsDietWaterEs extends _StringsDietWaterPt {
	_StringsDietWaterEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get edit_goal_title => 'Meta de Agua';
	@override String get liters_label => 'Litros';
	@override String get edit_stepper_title => 'Cantidad por Clic';
	@override String get ml_label => 'Mililitros (ml)';
	@override String goal_display({required Object value}) => 'Meta: ${value} L';
}

// Path: diet.macros
class _StringsDietMacrosEs extends _StringsDietMacrosPt {
	_StringsDietMacrosEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get carbs => 'Carbohidratos';
	@override String get protein => 'Proteínas';
	@override String get fat => 'Grasas';
}

// Path: diet.meal
class _StringsDietMealEs extends _StringsDietMealPt {
	_StringsDietMealEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String more_items({required Object count}) => '+ ${count} otros ítems';
	@override String total_calories({required Object calories}) => 'Total: ${calories} kcal';
	@override String get empty => 'Ningún alimento registrado';
	@override String get not_found => 'Comida no encontrada';
}

// Path: diet.meal_types
class _StringsDietMealTypesEs extends _StringsDietMealTypesPt {
	_StringsDietMealTypesEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get breakfast => 'Desayuno';
	@override String get morning_snack => 'Media Mañana';
	@override String get lunch => 'Almuerzo';
	@override String get afternoon_snack => 'Merienda';
	@override String get dinner => 'Cena';
	@override String get supper => 'Recena';
	@override String get pre_workout => 'Pre-entreno';
	@override String get post_workout => 'Post-entreno';
	@override String get snack => 'Snack';
}

// Path: explore.categories
class _StringsExploreCategoriesEs extends _StringsExploreCategoriesPt {
	_StringsExploreCategoriesEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get activity => 'Actividad';
	@override String get nutrition => 'Nutrición';
	@override String get sleep => 'Sueño';
	@override String get medication => 'Medicamentos';
	@override String get body_measurements => 'Medidas Corporales';
	@override String get mobility => 'Movilidad';
}

// Path: leaderboard.zones
class _StringsLeaderboardZonesEs extends _StringsLeaderboardZonesPt {
	_StringsLeaderboardZonesEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get promotion => 'ZONA DE PROMOCIÓN';
	@override String get demotion => 'ZONA DE DESCENSO';
}

// Path: leaderboard.entry
class _StringsLeaderboardEntryEs extends _StringsLeaderboardEntryPt {
	_StringsLeaderboardEntryEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String level({required Object level}) => 'Nivel ${level}';
	@override String xp({required Object value}) => '${value} XP';
}

// Path: leaderboard.leagues
class _StringsLeaderboardLeaguesEs extends _StringsLeaderboardLeaguesPt {
	_StringsLeaderboardLeaguesEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get wood => 'MADERA';
	@override String get iron => 'HIERRO';
	@override String get bronze => 'BRONCE';
	@override String get silver => 'PLATA';
	@override String get gold => 'ORO';
	@override String get platinum => 'PLATINO';
	@override String get diamond => 'DIAMANTE';
	@override String get obsidian => 'OBSIDIANA';
	@override String get master => 'MAESTRO';
	@override String get stellar => 'ESTELAR';
	@override String get legend => 'LEYENDA';
}

// Path: profile_setup.sections
class _StringsProfileSetupSectionsEs extends _StringsProfileSetupSectionsPt {
	_StringsProfileSetupSectionsEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get about => 'Sobre ti';
	@override String get measures => 'Medidas';
	@override String get goal => 'Objetivo Principal';
}

// Path: profile_setup.fields
class _StringsProfileSetupFieldsEs extends _StringsProfileSetupFieldsPt {
	_StringsProfileSetupFieldsEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre Completo';
	@override String get name_error => 'Ingresa tu nombre';
	@override String get dob => 'Fecha de Nacimiento';
	@override String get gender => 'Género';
	@override String get height => 'Altura (cm)';
	@override String get weight => 'Peso (kg)';
	@override String get goal_select => 'Selecciona tu objetivo';
	@override String get required_error => 'Obligatorio';
}

// Path: profile_setup.actions
class _StringsProfileSetupActionsEs extends _StringsProfileSetupActionsPt {
	_StringsProfileSetupActionsEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get save => 'Guardar Cambios';
	@override String get finish => 'Finalizar Registro';
}

// Path: profile_setup.feedback
class _StringsProfileSetupFeedbackEs extends _StringsProfileSetupFeedbackPt {
	_StringsProfileSetupFeedbackEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get fill_all => 'Por favor completa todos los campos.';
	@override String get success => '¡Perfil guardado con éxito!';
	@override String error({required Object error}) => 'Error al guardar: ${error}';
}

// Path: profile_setup.goals
class _StringsProfileSetupGoalsEs extends _StringsProfileSetupGoalsPt {
	_StringsProfileSetupGoalsEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get lose_weight => 'Perder Peso';
	@override String get gain_muscle => 'Ganar Músculo';
	@override String get endurance => 'Mejorar Resistencia';
	@override String get health => 'Mantener Salud';
}

// Path: profile_setup.genders
class _StringsProfileSetupGendersEs extends _StringsProfileSetupGendersPt {
	_StringsProfileSetupGendersEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get male => 'Hombre';
	@override String get female => 'Mujer';
	@override String get other => 'Otro';
}

// Path: workout_create.suggestions
class _StringsWorkoutCreateSuggestionsEs extends _StringsWorkoutCreateSuggestionsPt {
	_StringsWorkoutCreateSuggestionsEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get full_body => 'Cuerpo Completo';
	@override String get upper_body => 'Torso';
	@override String get lower_body => 'Pierna';
	@override String get push_day => 'Día de Empuje';
	@override String get pull_day => 'Día de Tirón';
	@override String get leg_day => 'Día de Pierna';
	@override String get cardio_abs => 'Cardio y Abdomen';
	@override String get yoga_flow => 'Yoga Flow';
}

// Path: workout_editor.remove_dialog
class _StringsWorkoutEditorRemoveDialogEs extends _StringsWorkoutEditorRemoveDialogPt {
	_StringsWorkoutEditorRemoveDialogEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Eliminar ejercicio?';
	@override String content({required Object name}) => '¿Quieres eliminar ${name}?';
	@override String get confirm => 'Eliminar';
}

// Path: workout.empty_state
class _StringsWorkoutEmptyStateEs extends _StringsWorkoutEmptyStatePt {
	_StringsWorkoutEmptyStateEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ningún plan de entrenamiento encontrado.';
	@override String get button => 'Crear mi primer entrenamiento';
}

// Path: workout.summary
class _StringsWorkoutSummaryEs extends _StringsWorkoutSummaryPt {
	_StringsWorkoutSummaryEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get today => 'Hoy';
}

// Path: workout.options
class _StringsWorkoutOptionsEs extends _StringsWorkoutOptionsPt {
	_StringsWorkoutOptionsEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get rename => 'Renombrar Plan';
	@override String get delete => 'Eliminar Plan';
}

// Path: workout.dialogs
class _StringsWorkoutDialogsEs extends _StringsWorkoutDialogsPt {
	_StringsWorkoutDialogsEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get rename_label => 'Nombre del entrenamiento';
	@override String get delete_title => '¿Eliminar Plan?';
	@override String delete_content({required Object name}) => '¿Estás seguro de eliminar "${name}"? Esta acción no se puede deshacer.';
	@override String get delete_confirm => 'Eliminar';
}

// Path: workout.calendar
class _StringsWorkoutCalendarEs extends _StringsWorkoutCalendarPt {
	_StringsWorkoutCalendarEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override List<String> get months => [
		'',
		'Enero',
		'Febrero',
		'Marzo',
		'Abril',
		'Mayo',
		'Junio',
		'Julio',
		'Agosto',
		'Septiembre',
		'Octubre',
		'Noviembre',
		'Diciembre',
	];
	@override List<String> get weekdays => [
		'D',
		'L',
		'M',
		'M',
		'J',
		'V',
		'S',
	];
}

// Path: mock.explore
class _StringsMockExploreEs extends _StringsMockExplorePt {
	_StringsMockExploreEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get nutrition => 'Nutrición';
	@override String get training => 'Entrenamiento';
	@override String get sleep => 'Sueño';
	@override String get mindfulness => 'Mindfulness';
	@override late final _StringsMockExploreTagsEs tags = _StringsMockExploreTagsEs._(_root);
}

// Path: mock.stats
class _StringsMockStatsEs extends _StringsMockStatsPt {
	_StringsMockStatsEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get calories => 'Calorías';
	@override String get protein => 'Proteínas';
	@override String get carbs => 'Carbohidratos';
	@override String get fat => 'Grasas';
	@override String get water => 'Agua';
	@override String get steps => 'Pasos';
	@override String get sleep => 'Sueño';
}

// Path: mock.explore.tags
class _StringsMockExploreTagsEs extends _StringsMockExploreTagsPt {
	_StringsMockExploreTagsEs._(_StringsEs root) : this._root = root, super._(root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get macros => 'macros';
	@override String get hydration => 'hidratación';
	@override String get recipes => 'recetas';
	@override String get hypertrophy => 'hipertrofia';
	@override String get strength => 'fuerza';
	@override String get mobility => 'movilidad';
	@override String get hygiene => 'higiene';
	@override String get cycle => 'ciclo';
	@override String get breathing => 'respiración';
	@override String get focus => 'foco';
}

// Path: <root>
class _StringsFr extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsFr.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	@override late final _StringsFr _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsCommonFr common = _StringsCommonFr._(_root);
	@override late final _StringsLoginFr login = _StringsLoginFr._(_root);
	@override late final _StringsDashboardFr dashboard = _StringsDashboardFr._(_root);
	@override late final _StringsSuccessFr success = _StringsSuccessFr._(_root);
	@override late final _StringsUnderConstructionFr under_construction = _StringsUnderConstructionFr._(_root);
	@override late final _StringsEditStatsFr edit_stats = _StringsEditStatsFr._(_root);
	@override late final _StringsAddFoodFr add_food = _StringsAddFoodFr._(_root);
	@override late final _StringsDietFr diet = _StringsDietFr._(_root);
	@override late final _StringsMealDetailFr meal_detail = _StringsMealDetailFr._(_root);
	@override late final _StringsExploreFr explore = _StringsExploreFr._(_root);
	@override late final _StringsLeaderboardFr leaderboard = _StringsLeaderboardFr._(_root);
	@override late final _StringsProfileSetupFr profile_setup = _StringsProfileSetupFr._(_root);
	@override late final _StringsProfileFr profile = _StringsProfileFr._(_root);
	@override late final _StringsAddExerciseFr add_exercise = _StringsAddExerciseFr._(_root);
	@override late final _StringsWorkoutCreateFr workout_create = _StringsWorkoutCreateFr._(_root);
	@override late final _StringsWorkoutEditorFr workout_editor = _StringsWorkoutEditorFr._(_root);
	@override late final _StringsWorkoutFr workout = _StringsWorkoutFr._(_root);
	@override late final _StringsMockFr mock = _StringsMockFr._(_root);
}

// Path: common
class _StringsCommonFr extends _StringsCommonPt {
	_StringsCommonFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get error => 'Erreur de chargement';
	@override String get error_profile => 'Erreur de chargement du profil';
	@override String get error_stats => 'Erreur de chargement des statistiques';
	@override String get back => 'Retour';
	@override String get cancel => 'Annuler';
	@override String get save => 'Enregistrer';
	@override String get not_authenticated => 'Utilisateur non authentifié.';
	@override String get xp_abbr => 'XP';
	@override String get league => 'Ligue';
	@override String rank_pattern({required Object rank}) => 'Rang #${rank}';
	@override String get empty_list => 'Liste vide';
}

// Path: login
class _StringsLoginFr extends _StringsLoginPt {
	_StringsLoginFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get tagline => 'Vos efforts, vos données,\nvos résultats.';
	@override String get google_button => 'Se connecter avec Google';
	@override String get terms_disclaimer => 'En continuant, vous acceptez nos Conditions.';
}

// Path: dashboard
class _StringsDashboardFr extends _StringsDashboardPt {
	_StringsDashboardFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get level_abbr => 'niv.';
	@override String get greeting => 'Bonjour, ';
	@override String get greeting_generic => 'Bonjour !';
	@override String get subtitle => 'Atteignons vos objectifs santé ensemble !';
	@override late final _StringsDashboardClassificationFr classification = _StringsDashboardClassificationFr._(_root);
	@override late final _StringsDashboardStatsFr stats = _StringsDashboardStatsFr._(_root);
}

// Path: success
class _StringsSuccessFr extends _StringsSuccessPt {
	_StringsSuccessFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Succès';
	@override String get default_message => 'C\'est tout bon ! Vos données ont été enregistrées !';
}

// Path: under_construction
class _StringsUnderConstructionFr extends _StringsUnderConstructionPt {
	_StringsUnderConstructionFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => '404';
	@override String get message => 'Cette page est encore en construction !';
	@override String get subtitle => 'Vous faisiez du cardio et vous vous êtes perdu ?';
}

// Path: edit_stats
class _StringsEditStatsFr extends _StringsEditStatsPt {
	_StringsEditStatsFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Modifier les favoris';
	@override String get instruction => 'Sélectionnez jusqu\'à 4 statistiques à mettre en avant';
}

// Path: add_food
class _StringsAddFoodFr extends _StringsAddFoodPt {
	_StringsAddFoodFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajouter un aliment';
	@override String get search_hint => 'Recherche ex: "Pomme", "Whey"...';
	@override String get not_found => 'Aucun aliment trouvé';
	@override String get error_api => 'Erreur de connexion à l\'API';
	@override String get instruction => 'Tapez pour chercher dans la base mondiale';
	@override String get macro_p => 'P';
	@override String get macro_c => 'G';
	@override String get macro_f => 'L';
}

// Path: diet
class _StringsDietFr extends _StringsDietPt {
	_StringsDietFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Diète';
	@override late final _StringsDietWaterFr water = _StringsDietWaterFr._(_root);
	@override late final _StringsDietMacrosFr macros = _StringsDietMacrosFr._(_root);
	@override late final _StringsDietMealFr meal = _StringsDietMealFr._(_root);
	@override late final _StringsDietMealTypesFr meal_types = _StringsDietMealTypesFr._(_root);
}

// Path: meal_detail
class _StringsMealDetailFr extends _StringsMealDetailPt {
	_StringsMealDetailFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Détails du repas';
	@override String macro_summary({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal • P ${protein}g • G ${carbs}g • L ${fat}g';
	@override String item_details({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal - P ${protein}g G ${carbs}g L ${fat}g';
}

// Path: explore
class _StringsExploreFr extends _StringsExplorePt {
	_StringsExploreFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Explorer';
	@override String get search_hint => 'Rechercher une fonctionnalité';
	@override String get not_found => 'Aucune fonctionnalité trouvée.';
	@override late final _StringsExploreCategoriesFr categories = _StringsExploreCategoriesFr._(_root);
}

// Path: leaderboard
class _StringsLeaderboardFr extends _StringsLeaderboardPt {
	_StringsLeaderboardFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Classement';
	@override String get error => 'Erreur de chargement du classement';
	@override late final _StringsLeaderboardZonesFr zones = _StringsLeaderboardZonesFr._(_root);
	@override late final _StringsLeaderboardEntryFr entry = _StringsLeaderboardEntryFr._(_root);
	@override late final _StringsLeaderboardLeaguesFr leagues = _StringsLeaderboardLeaguesFr._(_root);
}

// Path: profile_setup
class _StringsProfileSetupFr extends _StringsProfileSetupPt {
	_StringsProfileSetupFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title_edit => 'Modifier le profil';
	@override String get title_create => 'Créer un profil';
	@override String get welcome => 'Bienvenue !';
	@override String get subtitle => 'Configurons votre profil pour personnaliser votre parcours.';
	@override late final _StringsProfileSetupSectionsFr sections = _StringsProfileSetupSectionsFr._(_root);
	@override late final _StringsProfileSetupFieldsFr fields = _StringsProfileSetupFieldsFr._(_root);
	@override late final _StringsProfileSetupActionsFr actions = _StringsProfileSetupActionsFr._(_root);
	@override late final _StringsProfileSetupFeedbackFr feedback = _StringsProfileSetupFeedbackFr._(_root);
	@override late final _StringsProfileSetupGoalsFr goals = _StringsProfileSetupGoalsFr._(_root);
	@override late final _StringsProfileSetupGendersFr genders = _StringsProfileSetupGendersFr._(_root);
}

// Path: profile
class _StringsProfileFr extends _StringsProfilePt {
	_StringsProfileFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profil';
	@override String stats_format({required Object age, required Object height, required Object weight}) => '${age} ans • ${height} cm • ${weight} kg';
	@override String get dark_mode => 'Mode Sombre';
	@override String get edit_profile => 'Mettre à jour le profil';
	@override String get view_leaderboard => 'Voir le classement';
	@override String get logout => 'Se déconnecter';
	@override String get not_found => 'Profil non trouvé';
	@override String get create_profile => 'Créer un profil';
	@override String get default_user => 'Athlète';
}

// Path: add_exercise
class _StringsAddExerciseFr extends _StringsAddExercisePt {
	_StringsAddExerciseFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajouter un exercice';
	@override String get search_hint => 'Chercher par muscle (ex: Pectoraux, Dos)';
	@override String error({required Object error}) => 'Erreur : ${error}';
	@override String empty_title({required Object query}) => 'Aucun exercice trouvé pour "${query}"';
	@override String get empty_subtitle => 'Essayez : Pectoraux, Dos, Jambes, Biceps...';
	@override String added_feedback({required Object name}) => '${name} ajouté à l\'entraînement !';
}

// Path: workout_create
class _StringsWorkoutCreateFr extends _StringsWorkoutCreatePt {
	_StringsWorkoutCreateFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nouveau Plan';
	@override String get subtitle => 'Donnez un nom à votre nouvelle routine.';
	@override String get field_label => 'Nom de l\'entraînement';
	@override String get field_hint => 'Ex : Entraînement A';
	@override String get validator_error => 'Veuillez nommer l\'entraînement.';
	@override String get button_create => 'Créer l\'entraînement';
	@override String get suggestions_label => 'Suggestions rapides :';
	@override String success_feedback({required Object name}) => 'Entraînement "${name}" créé !';
	@override String error_feedback({required Object error}) => 'Erreur lors de la création : ${error}';
	@override late final _StringsWorkoutCreateSuggestionsFr suggestions = _StringsWorkoutCreateSuggestionsFr._(_root);
}

// Path: workout_editor
class _StringsWorkoutEditorFr extends _StringsWorkoutEditorPt {
	_StringsWorkoutEditorFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Modifier l\'entraînement';
	@override String get add_button => 'Ajouter';
	@override String error({required Object error}) => 'Erreur : ${error}';
	@override String get not_found => 'Plan non trouvé.';
	@override String get empty_text => 'Cet entraînement est vide.';
	@override String get add_exercise_button => 'Ajouter un exercice';
	@override String removed_snackbar({required Object name}) => '${name} supprimé';
	@override late final _StringsWorkoutEditorRemoveDialogFr remove_dialog = _StringsWorkoutEditorRemoveDialogFr._(_root);
}

// Path: workout
class _StringsWorkoutFr extends _StringsWorkoutPt {
	_StringsWorkoutFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Entraînement';
	@override String get create_tooltip => 'Créer un nouveau plan';
	@override late final _StringsWorkoutEmptyStateFr empty_state = _StringsWorkoutEmptyStateFr._(_root);
	@override late final _StringsWorkoutSummaryFr summary = _StringsWorkoutSummaryFr._(_root);
	@override late final _StringsWorkoutOptionsFr options = _StringsWorkoutOptionsFr._(_root);
	@override late final _StringsWorkoutDialogsFr dialogs = _StringsWorkoutDialogsFr._(_root);
	@override String get plan_empty => 'Ce plan est vide.';
	@override String get add_exercise_short => 'Exercice';
	@override late final _StringsWorkoutCalendarFr calendar = _StringsWorkoutCalendarFr._(_root);
}

// Path: mock
class _StringsMockFr extends _StringsMockPt {
	_StringsMockFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override late final _StringsMockExploreFr explore = _StringsMockExploreFr._(_root);
	@override late final _StringsMockStatsFr stats = _StringsMockStatsFr._(_root);
}

// Path: dashboard.classification
class _StringsDashboardClassificationFr extends _StringsDashboardClassificationPt {
	_StringsDashboardClassificationFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => '⭐ Classement';
	@override String get remaining_prefix => 'se termine dans ';
	@override String get remaining_suffix => ' jours';
	@override String get rank_suffix => 'e Place';
}

// Path: dashboard.stats
class _StringsDashboardStatsFr extends _StringsDashboardStatsPt {
	_StringsDashboardStatsFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistiques';
	@override String get empty => 'Modifier pour ajouter des stats.';
}

// Path: diet.water
class _StringsDietWaterFr extends _StringsDietWaterPt {
	_StringsDietWaterFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get edit_goal_title => 'Objectif d\'eau';
	@override String get liters_label => 'Litres';
	@override String get edit_stepper_title => 'Quantité par clic';
	@override String get ml_label => 'Millilitres (ml)';
	@override String goal_display({required Object value}) => 'Objectif : ${value} L';
}

// Path: diet.macros
class _StringsDietMacrosFr extends _StringsDietMacrosPt {
	_StringsDietMacrosFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get carbs => 'Glucides';
	@override String get protein => 'Protéines';
	@override String get fat => 'Lipides';
}

// Path: diet.meal
class _StringsDietMealFr extends _StringsDietMealPt {
	_StringsDietMealFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String more_items({required Object count}) => '+ ${count} autres articles';
	@override String total_calories({required Object calories}) => 'Total : ${calories} kcal';
	@override String get empty => 'Aucun aliment enregistré';
	@override String get not_found => 'Repas non trouvé';
}

// Path: diet.meal_types
class _StringsDietMealTypesFr extends _StringsDietMealTypesPt {
	_StringsDietMealTypesFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get breakfast => 'Petit-déjeuner';
	@override String get morning_snack => 'Collation matin';
	@override String get lunch => 'Déjeuner';
	@override String get afternoon_snack => 'Goûter';
	@override String get dinner => 'Dîner';
	@override String get supper => 'Souper';
	@override String get pre_workout => 'Pré-entraînement';
	@override String get post_workout => 'Post-entraînement';
	@override String get snack => 'Collation';
}

// Path: explore.categories
class _StringsExploreCategoriesFr extends _StringsExploreCategoriesPt {
	_StringsExploreCategoriesFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get activity => 'Activité';
	@override String get nutrition => 'Nutrition';
	@override String get sleep => 'Sommeil';
	@override String get medication => 'Médicaments';
	@override String get body_measurements => 'Mensurations';
	@override String get mobility => 'Mobilité';
}

// Path: leaderboard.zones
class _StringsLeaderboardZonesFr extends _StringsLeaderboardZonesPt {
	_StringsLeaderboardZonesFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get promotion => 'ZONE DE PROMOTION';
	@override String get demotion => 'ZONE DE RELÉGATION';
}

// Path: leaderboard.entry
class _StringsLeaderboardEntryFr extends _StringsLeaderboardEntryPt {
	_StringsLeaderboardEntryFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String level({required Object level}) => 'Niveau ${level}';
	@override String xp({required Object value}) => '${value} XP';
}

// Path: leaderboard.leagues
class _StringsLeaderboardLeaguesFr extends _StringsLeaderboardLeaguesPt {
	_StringsLeaderboardLeaguesFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get wood => 'BOIS';
	@override String get iron => 'FER';
	@override String get bronze => 'BRONZE';
	@override String get silver => 'ARGENT';
	@override String get gold => 'OR';
	@override String get platinum => 'PLATINE';
	@override String get diamond => 'DIAMANT';
	@override String get obsidian => 'OBSIDIENNE';
	@override String get master => 'MAÎTRE';
	@override String get stellar => 'STELLAIRE';
	@override String get legend => 'LÉGENDE';
}

// Path: profile_setup.sections
class _StringsProfileSetupSectionsFr extends _StringsProfileSetupSectionsPt {
	_StringsProfileSetupSectionsFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get about => 'À propos de vous';
	@override String get measures => 'Mesures';
	@override String get goal => 'Objectif principal';
}

// Path: profile_setup.fields
class _StringsProfileSetupFieldsFr extends _StringsProfileSetupFieldsPt {
	_StringsProfileSetupFieldsFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nom complet';
	@override String get name_error => 'Entrez votre nom';
	@override String get dob => 'Date de naissance';
	@override String get gender => 'Genre';
	@override String get height => 'Taille (cm)';
	@override String get weight => 'Poids (kg)';
	@override String get goal_select => 'Sélectionnez votre objectif';
	@override String get required_error => 'Requis';
}

// Path: profile_setup.actions
class _StringsProfileSetupActionsFr extends _StringsProfileSetupActionsPt {
	_StringsProfileSetupActionsFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get save => 'Enregistrer';
	@override String get finish => 'Terminer l\'inscription';
}

// Path: profile_setup.feedback
class _StringsProfileSetupFeedbackFr extends _StringsProfileSetupFeedbackPt {
	_StringsProfileSetupFeedbackFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get fill_all => 'Veuillez remplir tous les champs.';
	@override String get success => 'Profil enregistré avec succès !';
	@override String error({required Object error}) => 'Erreur lors de l\'enregistrement : ${error}';
}

// Path: profile_setup.goals
class _StringsProfileSetupGoalsFr extends _StringsProfileSetupGoalsPt {
	_StringsProfileSetupGoalsFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get lose_weight => 'Perdre du poids';
	@override String get gain_muscle => 'Gagner du muscle';
	@override String get endurance => 'Améliorer l\'endurance';
	@override String get health => 'Rester en bonne santé';
}

// Path: profile_setup.genders
class _StringsProfileSetupGendersFr extends _StringsProfileSetupGendersPt {
	_StringsProfileSetupGendersFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get male => 'Homme';
	@override String get female => 'Femme';
	@override String get other => 'Autre';
}

// Path: workout_create.suggestions
class _StringsWorkoutCreateSuggestionsFr extends _StringsWorkoutCreateSuggestionsPt {
	_StringsWorkoutCreateSuggestionsFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get full_body => 'Corps entier';
	@override String get upper_body => 'Haut du corps';
	@override String get lower_body => 'Bas du corps';
	@override String get push_day => 'Push Day';
	@override String get pull_day => 'Pull Day';
	@override String get leg_day => 'Journée Jambes';
	@override String get cardio_abs => 'Cardio & Abdos';
	@override String get yoga_flow => 'Yoga Flow';
}

// Path: workout_editor.remove_dialog
class _StringsWorkoutEditorRemoveDialogFr extends _StringsWorkoutEditorRemoveDialogPt {
	_StringsWorkoutEditorRemoveDialogFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Supprimer l\'exercice ?';
	@override String content({required Object name}) => 'Voulez-vous supprimer ${name} ?';
	@override String get confirm => 'Supprimer';
}

// Path: workout.empty_state
class _StringsWorkoutEmptyStateFr extends _StringsWorkoutEmptyStatePt {
	_StringsWorkoutEmptyStateFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aucun plan d\'entraînement trouvé.';
	@override String get button => 'Créer mon premier entraînement';
}

// Path: workout.summary
class _StringsWorkoutSummaryFr extends _StringsWorkoutSummaryPt {
	_StringsWorkoutSummaryFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get today => 'Aujourd\'hui';
}

// Path: workout.options
class _StringsWorkoutOptionsFr extends _StringsWorkoutOptionsPt {
	_StringsWorkoutOptionsFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get rename => 'Renommer le plan';
	@override String get delete => 'Supprimer le plan';
}

// Path: workout.dialogs
class _StringsWorkoutDialogsFr extends _StringsWorkoutDialogsPt {
	_StringsWorkoutDialogsFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get rename_label => 'Nom de l\'entraînement';
	@override String get delete_title => 'Supprimer le plan ?';
	@override String delete_content({required Object name}) => 'Êtes-vous sûr de vouloir supprimer "${name}" ? Cette action est irréversible.';
	@override String get delete_confirm => 'Supprimer';
}

// Path: workout.calendar
class _StringsWorkoutCalendarFr extends _StringsWorkoutCalendarPt {
	_StringsWorkoutCalendarFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override List<String> get months => [
		'',
		'Janvier',
		'Février',
		'Mars',
		'Avril',
		'Mai',
		'Juin',
		'Juillet',
		'Août',
		'Septembre',
		'Octobre',
		'Novembre',
		'Décembre',
	];
	@override List<String> get weekdays => [
		'D',
		'L',
		'M',
		'M',
		'J',
		'V',
		'S',
	];
}

// Path: mock.explore
class _StringsMockExploreFr extends _StringsMockExplorePt {
	_StringsMockExploreFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get nutrition => 'Nutrition';
	@override String get training => 'Entraînement';
	@override String get sleep => 'Sommeil';
	@override String get mindfulness => 'Pleine conscience';
	@override late final _StringsMockExploreTagsFr tags = _StringsMockExploreTagsFr._(_root);
}

// Path: mock.stats
class _StringsMockStatsFr extends _StringsMockStatsPt {
	_StringsMockStatsFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get calories => 'Calories';
	@override String get protein => 'Protéines';
	@override String get carbs => 'Glucides';
	@override String get fat => 'Lipides';
	@override String get water => 'Eau';
	@override String get steps => 'Pas';
	@override String get sleep => 'Sommeil';
}

// Path: mock.explore.tags
class _StringsMockExploreTagsFr extends _StringsMockExploreTagsPt {
	_StringsMockExploreTagsFr._(_StringsFr root) : this._root = root, super._(root);

	@override final _StringsFr _root; // ignore: unused_field

	// Translations
	@override String get macros => 'macros';
	@override String get hydration => 'hydratation';
	@override String get recipes => 'recettes';
	@override String get hypertrophy => 'hypertrophie';
	@override String get strength => 'force';
	@override String get mobility => 'mobilité';
	@override String get hygiene => 'hygiène';
	@override String get cycle => 'cycle';
	@override String get breathing => 'respiration';
	@override String get focus => 'concentration';
}

// Path: <root>
class _StringsIt extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsIt.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.it,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <it>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	@override late final _StringsIt _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsCommonIt common = _StringsCommonIt._(_root);
	@override late final _StringsLoginIt login = _StringsLoginIt._(_root);
	@override late final _StringsDashboardIt dashboard = _StringsDashboardIt._(_root);
	@override late final _StringsSuccessIt success = _StringsSuccessIt._(_root);
	@override late final _StringsUnderConstructionIt under_construction = _StringsUnderConstructionIt._(_root);
	@override late final _StringsEditStatsIt edit_stats = _StringsEditStatsIt._(_root);
	@override late final _StringsAddFoodIt add_food = _StringsAddFoodIt._(_root);
	@override late final _StringsDietIt diet = _StringsDietIt._(_root);
	@override late final _StringsMealDetailIt meal_detail = _StringsMealDetailIt._(_root);
	@override late final _StringsExploreIt explore = _StringsExploreIt._(_root);
	@override late final _StringsLeaderboardIt leaderboard = _StringsLeaderboardIt._(_root);
	@override late final _StringsProfileSetupIt profile_setup = _StringsProfileSetupIt._(_root);
	@override late final _StringsProfileIt profile = _StringsProfileIt._(_root);
	@override late final _StringsAddExerciseIt add_exercise = _StringsAddExerciseIt._(_root);
	@override late final _StringsWorkoutCreateIt workout_create = _StringsWorkoutCreateIt._(_root);
	@override late final _StringsWorkoutEditorIt workout_editor = _StringsWorkoutEditorIt._(_root);
	@override late final _StringsWorkoutIt workout = _StringsWorkoutIt._(_root);
	@override late final _StringsMockIt mock = _StringsMockIt._(_root);
}

// Path: common
class _StringsCommonIt extends _StringsCommonPt {
	_StringsCommonIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get error => 'Errore di caricamento';
	@override String get error_profile => 'Errore caricamento profilo';
	@override String get error_stats => 'Errore caricamento statistiche';
	@override String get back => 'Indietro';
	@override String get cancel => 'Annulla';
	@override String get save => 'Salva';
	@override String get not_authenticated => 'Utente non autenticato.';
	@override String get xp_abbr => 'XP';
	@override String get league => 'Lega';
	@override String rank_pattern({required Object rank}) => 'Rango #${rank}';
	@override String get empty_list => 'Elenco vuoto';
}

// Path: login
class _StringsLoginIt extends _StringsLoginPt {
	_StringsLoginIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get tagline => 'Il tuo impegno, i tuoi dati,\ni tuoi risultati.';
	@override String get google_button => 'Accedi con Google';
	@override String get terms_disclaimer => 'Continuando, accetti i nostri Termini.';
}

// Path: dashboard
class _StringsDashboardIt extends _StringsDashboardPt {
	_StringsDashboardIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get level_abbr => 'liv.';
	@override String get greeting => 'Ciao, ';
	@override String get greeting_generic => 'Ciao!';
	@override String get subtitle => 'Raggiungiamo insieme i tuoi obiettivi!';
	@override late final _StringsDashboardClassificationIt classification = _StringsDashboardClassificationIt._(_root);
	@override late final _StringsDashboardStatsIt stats = _StringsDashboardStatsIt._(_root);
}

// Path: success
class _StringsSuccessIt extends _StringsSuccessPt {
	_StringsSuccessIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Successo';
	@override String get default_message => 'Tutto pronto! I tuoi dati sono stati registrati!';
}

// Path: under_construction
class _StringsUnderConstructionIt extends _StringsUnderConstructionPt {
	_StringsUnderConstructionIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => '404';
	@override String get message => 'Questa pagina è ancora in costruzione!';
	@override String get subtitle => 'Stavi facendo cardio e ti sei perso?';
}

// Path: edit_stats
class _StringsEditStatsIt extends _StringsEditStatsPt {
	_StringsEditStatsIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Modifica In Evidenza';
	@override String get instruction => 'Seleziona fino a 4 statistiche da mettere in evidenza';
}

// Path: add_food
class _StringsAddFoodIt extends _StringsAddFoodPt {
	_StringsAddFoodIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aggiungi Cibo';
	@override String get search_hint => 'Cerca es: "Mela", "Whey"...';
	@override String get not_found => 'Nessun alimento trovato';
	@override String get error_api => 'Errore di connessione all\'API';
	@override String get instruction => 'Digita per cercare nel database globale';
	@override String get macro_p => 'P';
	@override String get macro_c => 'C';
	@override String get macro_f => 'G';
}

// Path: diet
class _StringsDietIt extends _StringsDietPt {
	_StringsDietIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dieta';
	@override late final _StringsDietWaterIt water = _StringsDietWaterIt._(_root);
	@override late final _StringsDietMacrosIt macros = _StringsDietMacrosIt._(_root);
	@override late final _StringsDietMealIt meal = _StringsDietMealIt._(_root);
	@override late final _StringsDietMealTypesIt meal_types = _StringsDietMealTypesIt._(_root);
}

// Path: meal_detail
class _StringsMealDetailIt extends _StringsMealDetailPt {
	_StringsMealDetailIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dettagli Pasto';
	@override String macro_summary({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal • P ${protein}g • C ${carbs}g • G ${fat}g';
	@override String item_details({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal - P ${protein}g C ${carbs}g G ${fat}g';
}

// Path: explore
class _StringsExploreIt extends _StringsExplorePt {
	_StringsExploreIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Esplora';
	@override String get search_hint => 'Cerca funzionalità';
	@override String get not_found => 'Nessuna funzionalità trovata.';
	@override late final _StringsExploreCategoriesIt categories = _StringsExploreCategoriesIt._(_root);
}

// Path: leaderboard
class _StringsLeaderboardIt extends _StringsLeaderboardPt {
	_StringsLeaderboardIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Classifica';
	@override String get error => 'Errore caricamento classifica';
	@override late final _StringsLeaderboardZonesIt zones = _StringsLeaderboardZonesIt._(_root);
	@override late final _StringsLeaderboardEntryIt entry = _StringsLeaderboardEntryIt._(_root);
	@override late final _StringsLeaderboardLeaguesIt leagues = _StringsLeaderboardLeaguesIt._(_root);
}

// Path: profile_setup
class _StringsProfileSetupIt extends _StringsProfileSetupPt {
	_StringsProfileSetupIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title_edit => 'Modifica Profilo';
	@override String get title_create => 'Crea Profilo';
	@override String get welcome => 'Benvenuto!';
	@override String get subtitle => 'Impostiamo il tuo profilo per personalizzare il tuo percorso.';
	@override late final _StringsProfileSetupSectionsIt sections = _StringsProfileSetupSectionsIt._(_root);
	@override late final _StringsProfileSetupFieldsIt fields = _StringsProfileSetupFieldsIt._(_root);
	@override late final _StringsProfileSetupActionsIt actions = _StringsProfileSetupActionsIt._(_root);
	@override late final _StringsProfileSetupFeedbackIt feedback = _StringsProfileSetupFeedbackIt._(_root);
	@override late final _StringsProfileSetupGoalsIt goals = _StringsProfileSetupGoalsIt._(_root);
	@override late final _StringsProfileSetupGendersIt genders = _StringsProfileSetupGendersIt._(_root);
}

// Path: profile
class _StringsProfileIt extends _StringsProfilePt {
	_StringsProfileIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profilo';
	@override String stats_format({required Object age, required Object height, required Object weight}) => '${age} anni • ${height} cm • ${weight} kg';
	@override String get dark_mode => 'Modalità Scura';
	@override String get edit_profile => 'Aggiorna profilo';
	@override String get view_leaderboard => 'Vedi Classifica';
	@override String get logout => 'Esci';
	@override String get not_found => 'Profilo non trovato';
	@override String get create_profile => 'Crea profilo';
	@override String get default_user => 'Atleta';
}

// Path: add_exercise
class _StringsAddExerciseIt extends _StringsAddExercisePt {
	_StringsAddExerciseIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aggiungi Esercizio';
	@override String get search_hint => 'Cerca per gruppo muscolare (es: Petto, Schiena)';
	@override String error({required Object error}) => 'Errore: ${error}';
	@override String empty_title({required Object query}) => 'Nessun esercizio trovato per "${query}"';
	@override String get empty_subtitle => 'Prova: Petto, Schiena, Gambe, Bicipiti...';
	@override String added_feedback({required Object name}) => '${name} aggiunto all\'allenamento!';
}

// Path: workout_create
class _StringsWorkoutCreateIt extends _StringsWorkoutCreatePt {
	_StringsWorkoutCreateIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nuovo Piano';
	@override String get subtitle => 'Dai un nome alla tua nuova routine.';
	@override String get field_label => 'Nome Allenamento';
	@override String get field_hint => 'Es: Allenamento A';
	@override String get validator_error => 'Per favore dai un nome all\'allenamento.';
	@override String get button_create => 'Crea Allenamento';
	@override String get suggestions_label => 'Suggerimenti rapidi:';
	@override String success_feedback({required Object name}) => 'Allenamento "${name}" creato!';
	@override String error_feedback({required Object error}) => 'Errore creazione: ${error}';
	@override late final _StringsWorkoutCreateSuggestionsIt suggestions = _StringsWorkoutCreateSuggestionsIt._(_root);
}

// Path: workout_editor
class _StringsWorkoutEditorIt extends _StringsWorkoutEditorPt {
	_StringsWorkoutEditorIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Modifica Allenamento';
	@override String get add_button => 'Aggiungi';
	@override String error({required Object error}) => 'Errore: ${error}';
	@override String get not_found => 'Piano non trovato.';
	@override String get empty_text => 'Questo allenamento è vuoto.';
	@override String get add_exercise_button => 'Aggiungi Esercizio';
	@override String removed_snackbar({required Object name}) => '${name} rimosso';
	@override late final _StringsWorkoutEditorRemoveDialogIt remove_dialog = _StringsWorkoutEditorRemoveDialogIt._(_root);
}

// Path: workout
class _StringsWorkoutIt extends _StringsWorkoutPt {
	_StringsWorkoutIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Allenamento';
	@override String get create_tooltip => 'Crea nuovo piano';
	@override late final _StringsWorkoutEmptyStateIt empty_state = _StringsWorkoutEmptyStateIt._(_root);
	@override late final _StringsWorkoutSummaryIt summary = _StringsWorkoutSummaryIt._(_root);
	@override late final _StringsWorkoutOptionsIt options = _StringsWorkoutOptionsIt._(_root);
	@override late final _StringsWorkoutDialogsIt dialogs = _StringsWorkoutDialogsIt._(_root);
	@override String get plan_empty => 'Questo piano è vuoto.';
	@override String get add_exercise_short => 'Esercizio';
	@override late final _StringsWorkoutCalendarIt calendar = _StringsWorkoutCalendarIt._(_root);
}

// Path: mock
class _StringsMockIt extends _StringsMockPt {
	_StringsMockIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override late final _StringsMockExploreIt explore = _StringsMockExploreIt._(_root);
	@override late final _StringsMockStatsIt stats = _StringsMockStatsIt._(_root);
}

// Path: dashboard.classification
class _StringsDashboardClassificationIt extends _StringsDashboardClassificationPt {
	_StringsDashboardClassificationIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => '⭐ Classifica';
	@override String get remaining_prefix => 'termina in ';
	@override String get remaining_suffix => ' giorni';
	@override String get rank_suffix => '° Posto';
}

// Path: dashboard.stats
class _StringsDashboardStatsIt extends _StringsDashboardStatsPt {
	_StringsDashboardStatsIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistiche';
	@override String get empty => 'Modifica per aggiungere statistiche.';
}

// Path: diet.water
class _StringsDietWaterIt extends _StringsDietWaterPt {
	_StringsDietWaterIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get edit_goal_title => 'Obiettivo Acqua';
	@override String get liters_label => 'Litri';
	@override String get edit_stepper_title => 'Quantità per Click';
	@override String get ml_label => 'Millilitri (ml)';
	@override String goal_display({required Object value}) => 'Obiettivo: ${value} L';
}

// Path: diet.macros
class _StringsDietMacrosIt extends _StringsDietMacrosPt {
	_StringsDietMacrosIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get carbs => 'Carboidrati';
	@override String get protein => 'Proteine';
	@override String get fat => 'Grassi';
}

// Path: diet.meal
class _StringsDietMealIt extends _StringsDietMealPt {
	_StringsDietMealIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String more_items({required Object count}) => '+ altri ${count} elementi';
	@override String total_calories({required Object calories}) => 'Totale: ${calories} kcal';
	@override String get empty => 'Nessun alimento registrato';
	@override String get not_found => 'Pasto non trovato';
}

// Path: diet.meal_types
class _StringsDietMealTypesIt extends _StringsDietMealTypesPt {
	_StringsDietMealTypesIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get breakfast => 'Colazione';
	@override String get morning_snack => 'Spuntino Mattina';
	@override String get lunch => 'Pranzo';
	@override String get afternoon_snack => 'Merenda';
	@override String get dinner => 'Cena';
	@override String get supper => 'Spuntino Serale';
	@override String get pre_workout => 'Pre-workout';
	@override String get post_workout => 'Post-workout';
	@override String get snack => 'Spuntino';
}

// Path: explore.categories
class _StringsExploreCategoriesIt extends _StringsExploreCategoriesPt {
	_StringsExploreCategoriesIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get activity => 'Attività';
	@override String get nutrition => 'Nutrizione';
	@override String get sleep => 'Sonno';
	@override String get medication => 'Farmaci';
	@override String get body_measurements => 'Misure Corporee';
	@override String get mobility => 'Mobilità';
}

// Path: leaderboard.zones
class _StringsLeaderboardZonesIt extends _StringsLeaderboardZonesPt {
	_StringsLeaderboardZonesIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get promotion => 'ZONA PROMOZIONE';
	@override String get demotion => 'ZONA RETROCESSIONE';
}

// Path: leaderboard.entry
class _StringsLeaderboardEntryIt extends _StringsLeaderboardEntryPt {
	_StringsLeaderboardEntryIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String level({required Object level}) => 'Livello ${level}';
	@override String xp({required Object value}) => '${value} XP';
}

// Path: leaderboard.leagues
class _StringsLeaderboardLeaguesIt extends _StringsLeaderboardLeaguesPt {
	_StringsLeaderboardLeaguesIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get wood => 'LEGNO';
	@override String get iron => 'FERRO';
	@override String get bronze => 'BRONZO';
	@override String get silver => 'ARGENTO';
	@override String get gold => 'ORO';
	@override String get platinum => 'PLATINO';
	@override String get diamond => 'DIAMANTE';
	@override String get obsidian => 'OSSIDIANA';
	@override String get master => 'MAESTRO';
	@override String get stellar => 'STELLARE';
	@override String get legend => 'LEGGENDA';
}

// Path: profile_setup.sections
class _StringsProfileSetupSectionsIt extends _StringsProfileSetupSectionsPt {
	_StringsProfileSetupSectionsIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get about => 'Su di te';
	@override String get measures => 'Misure';
	@override String get goal => 'Obiettivo Principale';
}

// Path: profile_setup.fields
class _StringsProfileSetupFieldsIt extends _StringsProfileSetupFieldsPt {
	_StringsProfileSetupFieldsIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nome Completo';
	@override String get name_error => 'Inserisci il tuo nome';
	@override String get dob => 'Data di Nascita';
	@override String get gender => 'Genere';
	@override String get height => 'Altezza (cm)';
	@override String get weight => 'Peso (kg)';
	@override String get goal_select => 'Seleziona il tuo obiettivo';
	@override String get required_error => 'Obbligatorio';
}

// Path: profile_setup.actions
class _StringsProfileSetupActionsIt extends _StringsProfileSetupActionsPt {
	_StringsProfileSetupActionsIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get save => 'Salva Modifiche';
	@override String get finish => 'Termina Registrazione';
}

// Path: profile_setup.feedback
class _StringsProfileSetupFeedbackIt extends _StringsProfileSetupFeedbackPt {
	_StringsProfileSetupFeedbackIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get fill_all => 'Per favore compila tutti i campi.';
	@override String get success => 'Profilo salvato con successo!';
	@override String error({required Object error}) => 'Errore durante il salvataggio: ${error}';
}

// Path: profile_setup.goals
class _StringsProfileSetupGoalsIt extends _StringsProfileSetupGoalsPt {
	_StringsProfileSetupGoalsIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get lose_weight => 'Perdere Peso';
	@override String get gain_muscle => 'Aumentare Massa';
	@override String get endurance => 'Migliorare Resistenza';
	@override String get health => 'Mantenere Salute';
}

// Path: profile_setup.genders
class _StringsProfileSetupGendersIt extends _StringsProfileSetupGendersPt {
	_StringsProfileSetupGendersIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get male => 'Uomo';
	@override String get female => 'Donna';
	@override String get other => 'Altro';
}

// Path: workout_create.suggestions
class _StringsWorkoutCreateSuggestionsIt extends _StringsWorkoutCreateSuggestionsPt {
	_StringsWorkoutCreateSuggestionsIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get full_body => 'Full Body';
	@override String get upper_body => 'Upper Body';
	@override String get lower_body => 'Lower Body';
	@override String get push_day => 'Push Day';
	@override String get pull_day => 'Pull Day';
	@override String get leg_day => 'Leg Day';
	@override String get cardio_abs => 'Cardio & Addome';
	@override String get yoga_flow => 'Yoga Flow';
}

// Path: workout_editor.remove_dialog
class _StringsWorkoutEditorRemoveDialogIt extends _StringsWorkoutEditorRemoveDialogPt {
	_StringsWorkoutEditorRemoveDialogIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Rimuovere esercizio?';
	@override String content({required Object name}) => 'Vuoi rimuovere ${name}?';
	@override String get confirm => 'Rimuovi';
}

// Path: workout.empty_state
class _StringsWorkoutEmptyStateIt extends _StringsWorkoutEmptyStatePt {
	_StringsWorkoutEmptyStateIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nessun piano di allenamento trovato.';
	@override String get button => 'Crea il mio primo allenamento';
}

// Path: workout.summary
class _StringsWorkoutSummaryIt extends _StringsWorkoutSummaryPt {
	_StringsWorkoutSummaryIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get today => 'Oggi';
}

// Path: workout.options
class _StringsWorkoutOptionsIt extends _StringsWorkoutOptionsPt {
	_StringsWorkoutOptionsIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get rename => 'Rinomina Piano';
	@override String get delete => 'Elimina Piano';
}

// Path: workout.dialogs
class _StringsWorkoutDialogsIt extends _StringsWorkoutDialogsPt {
	_StringsWorkoutDialogsIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get rename_label => 'Nome allenamento';
	@override String get delete_title => 'Eliminare Piano?';
	@override String delete_content({required Object name}) => 'Sei sicuro di voler eliminare "${name}"? Questa azione non può essere annullata.';
	@override String get delete_confirm => 'Elimina';
}

// Path: workout.calendar
class _StringsWorkoutCalendarIt extends _StringsWorkoutCalendarPt {
	_StringsWorkoutCalendarIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override List<String> get months => [
		'',
		'Gennaio',
		'Febbraio',
		'Marzo',
		'Aprile',
		'Maggio',
		'Giugno',
		'Luglio',
		'Agosto',
		'Settembre',
		'Ottobre',
		'Novembre',
		'Dicembre',
	];
	@override List<String> get weekdays => [
		'D',
		'L',
		'M',
		'M',
		'G',
		'V',
		'S',
	];
}

// Path: mock.explore
class _StringsMockExploreIt extends _StringsMockExplorePt {
	_StringsMockExploreIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get nutrition => 'Nutrizione';
	@override String get training => 'Allenamento';
	@override String get sleep => 'Sonno';
	@override String get mindfulness => 'Mindfulness';
	@override late final _StringsMockExploreTagsIt tags = _StringsMockExploreTagsIt._(_root);
}

// Path: mock.stats
class _StringsMockStatsIt extends _StringsMockStatsPt {
	_StringsMockStatsIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get calories => 'Calorie';
	@override String get protein => 'Proteine';
	@override String get carbs => 'Carboidrati';
	@override String get fat => 'Grassi';
	@override String get water => 'Acqua';
	@override String get steps => 'Passi';
	@override String get sleep => 'Sonno';
}

// Path: mock.explore.tags
class _StringsMockExploreTagsIt extends _StringsMockExploreTagsPt {
	_StringsMockExploreTagsIt._(_StringsIt root) : this._root = root, super._(root);

	@override final _StringsIt _root; // ignore: unused_field

	// Translations
	@override String get macros => 'macros';
	@override String get hydration => 'idratazione';
	@override String get recipes => 'ricette';
	@override String get hypertrophy => 'ipertrofia';
	@override String get strength => 'forza';
	@override String get mobility => 'mobilità';
	@override String get hygiene => 'igiene';
	@override String get cycle => 'ciclo';
	@override String get breathing => 'respirazione';
	@override String get focus => 'focus';
}

// Path: <root>
class _StringsZh extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsZh.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	@override late final _StringsZh _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsCommonZh common = _StringsCommonZh._(_root);
	@override late final _StringsLoginZh login = _StringsLoginZh._(_root);
	@override late final _StringsDashboardZh dashboard = _StringsDashboardZh._(_root);
	@override late final _StringsSuccessZh success = _StringsSuccessZh._(_root);
	@override late final _StringsUnderConstructionZh under_construction = _StringsUnderConstructionZh._(_root);
	@override late final _StringsEditStatsZh edit_stats = _StringsEditStatsZh._(_root);
	@override late final _StringsAddFoodZh add_food = _StringsAddFoodZh._(_root);
	@override late final _StringsDietZh diet = _StringsDietZh._(_root);
	@override late final _StringsMealDetailZh meal_detail = _StringsMealDetailZh._(_root);
	@override late final _StringsExploreZh explore = _StringsExploreZh._(_root);
	@override late final _StringsLeaderboardZh leaderboard = _StringsLeaderboardZh._(_root);
	@override late final _StringsProfileSetupZh profile_setup = _StringsProfileSetupZh._(_root);
	@override late final _StringsProfileZh profile = _StringsProfileZh._(_root);
	@override late final _StringsAddExerciseZh add_exercise = _StringsAddExerciseZh._(_root);
	@override late final _StringsWorkoutCreateZh workout_create = _StringsWorkoutCreateZh._(_root);
	@override late final _StringsWorkoutEditorZh workout_editor = _StringsWorkoutEditorZh._(_root);
	@override late final _StringsWorkoutZh workout = _StringsWorkoutZh._(_root);
	@override late final _StringsMockZh mock = _StringsMockZh._(_root);
}

// Path: common
class _StringsCommonZh extends _StringsCommonPt {
	_StringsCommonZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get error => '加载错误';
	@override String get error_profile => '加载个人资料错误';
	@override String get error_stats => '加载统计数据错误';
	@override String get back => '返回';
	@override String get cancel => '取消';
	@override String get save => '保存';
	@override String get not_authenticated => '用户未验证。';
	@override String get xp_abbr => 'XP';
	@override String get league => '联赛';
	@override String rank_pattern({required Object rank}) => '排名 #${rank}';
	@override String get empty_list => '空列表';
}

// Path: login
class _StringsLoginZh extends _StringsLoginPt {
	_StringsLoginZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get tagline => '您的努力，您的数据，\n您的成果。';
	@override String get google_button => '使用 Google 登录';
	@override String get terms_disclaimer => '继续即表示您同意我们的条款。';
}

// Path: dashboard
class _StringsDashboardZh extends _StringsDashboardPt {
	_StringsDashboardZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get level_abbr => '等级';
	@override String get greeting => '你好，';
	@override String get greeting_generic => '你好！';
	@override String get subtitle => '让我们一起实现您的健康目标！';
	@override late final _StringsDashboardClassificationZh classification = _StringsDashboardClassificationZh._(_root);
	@override late final _StringsDashboardStatsZh stats = _StringsDashboardStatsZh._(_root);
}

// Path: success
class _StringsSuccessZh extends _StringsSuccessPt {
	_StringsSuccessZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '成功';
	@override String get default_message => '一切就绪！您的数据已注册！';
}

// Path: under_construction
class _StringsUnderConstructionZh extends _StringsUnderConstructionPt {
	_StringsUnderConstructionZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '404';
	@override String get message => '此页面仍在建设中！';
	@override String get subtitle => '是有氧运动做迷路了吗？';
}

// Path: edit_stats
class _StringsEditStatsZh extends _StringsEditStatsPt {
	_StringsEditStatsZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '编辑精选';
	@override String get instruction => '最多选择 4 个统计数据进行展示';
}

// Path: add_food
class _StringsAddFoodZh extends _StringsAddFoodPt {
	_StringsAddFoodZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '添加食物';
	@override String get search_hint => '搜索例如：“苹果”，“蛋白粉”...';
	@override String get not_found => '未找到食物';
	@override String get error_api => 'API 连接错误';
	@override String get instruction => '输入以在全​​球数据库中搜索';
	@override String get macro_p => '蛋';
	@override String get macro_c => '碳';
	@override String get macro_f => '脂';
}

// Path: diet
class _StringsDietZh extends _StringsDietPt {
	_StringsDietZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '饮食';
	@override late final _StringsDietWaterZh water = _StringsDietWaterZh._(_root);
	@override late final _StringsDietMacrosZh macros = _StringsDietMacrosZh._(_root);
	@override late final _StringsDietMealZh meal = _StringsDietMealZh._(_root);
	@override late final _StringsDietMealTypesZh meal_types = _StringsDietMealTypesZh._(_root);
}

// Path: meal_detail
class _StringsMealDetailZh extends _StringsMealDetailPt {
	_StringsMealDetailZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '餐点详情';
	@override String macro_summary({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} 千卡 • 蛋 ${protein}g • 碳 ${carbs}g • 脂 ${fat}g';
	@override String item_details({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} 千卡 - 蛋 ${protein}g 碳 ${carbs}g 脂 ${fat}g';
}

// Path: explore
class _StringsExploreZh extends _StringsExplorePt {
	_StringsExploreZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '探索';
	@override String get search_hint => '搜索功能';
	@override String get not_found => '未找到功能。';
	@override late final _StringsExploreCategoriesZh categories = _StringsExploreCategoriesZh._(_root);
}

// Path: leaderboard
class _StringsLeaderboardZh extends _StringsLeaderboardPt {
	_StringsLeaderboardZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '排行榜';
	@override String get error => '加载排行榜错误';
	@override late final _StringsLeaderboardZonesZh zones = _StringsLeaderboardZonesZh._(_root);
	@override late final _StringsLeaderboardEntryZh entry = _StringsLeaderboardEntryZh._(_root);
	@override late final _StringsLeaderboardLeaguesZh leagues = _StringsLeaderboardLeaguesZh._(_root);
}

// Path: profile_setup
class _StringsProfileSetupZh extends _StringsProfileSetupPt {
	_StringsProfileSetupZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title_edit => '编辑资料';
	@override String get title_create => '创建资料';
	@override String get welcome => '欢迎！';
	@override String get subtitle => '让我们设置您的个人资料以个性化您的旅程。';
	@override late final _StringsProfileSetupSectionsZh sections = _StringsProfileSetupSectionsZh._(_root);
	@override late final _StringsProfileSetupFieldsZh fields = _StringsProfileSetupFieldsZh._(_root);
	@override late final _StringsProfileSetupActionsZh actions = _StringsProfileSetupActionsZh._(_root);
	@override late final _StringsProfileSetupFeedbackZh feedback = _StringsProfileSetupFeedbackZh._(_root);
	@override late final _StringsProfileSetupGoalsZh goals = _StringsProfileSetupGoalsZh._(_root);
	@override late final _StringsProfileSetupGendersZh genders = _StringsProfileSetupGendersZh._(_root);
}

// Path: profile
class _StringsProfileZh extends _StringsProfilePt {
	_StringsProfileZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '个人资料';
	@override String stats_format({required Object age, required Object height, required Object weight}) => '${age} 岁 • ${height} cm • ${weight} kg';
	@override String get dark_mode => '深色模式';
	@override String get edit_profile => '更新资料';
	@override String get view_leaderboard => '查看排行榜';
	@override String get logout => '退出 (Logout)';
	@override String get not_found => '未找到个人资料';
	@override String get create_profile => '创建资料';
	@override String get default_user => '运动员';
}

// Path: add_exercise
class _StringsAddExerciseZh extends _StringsAddExercisePt {
	_StringsAddExerciseZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '添加运动';
	@override String get search_hint => '按肌肉群搜索 (如: 胸部, 背部)';
	@override String error({required Object error}) => '错误: ${error}';
	@override String empty_title({required Object query}) => '未找到关于 "${query}" 的运动';
	@override String get empty_subtitle => '尝试: 胸部, 背部, 腿部, 二头肌...';
	@override String added_feedback({required Object name}) => '${name} 已添加到训练中！';
}

// Path: workout_create
class _StringsWorkoutCreateZh extends _StringsWorkoutCreatePt {
	_StringsWorkoutCreateZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '新计划';
	@override String get subtitle => '为您的新训练计划命名。';
	@override String get field_label => '训练名称';
	@override String get field_hint => '例如: 训练 A';
	@override String get validator_error => '请给训练命名。';
	@override String get button_create => '创建计划';
	@override String get suggestions_label => '快速建议:';
	@override String success_feedback({required Object name}) => '训练 "${name}" 已创建！';
	@override String error_feedback({required Object error}) => '创建错误: ${error}';
	@override late final _StringsWorkoutCreateSuggestionsZh suggestions = _StringsWorkoutCreateSuggestionsZh._(_root);
}

// Path: workout_editor
class _StringsWorkoutEditorZh extends _StringsWorkoutEditorPt {
	_StringsWorkoutEditorZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '编辑训练';
	@override String get add_button => '添加';
	@override String error({required Object error}) => '错误: ${error}';
	@override String get not_found => '未找到计划。';
	@override String get empty_text => '此训练为空。';
	@override String get add_exercise_button => '添加运动';
	@override String removed_snackbar({required Object name}) => '${name} 已移除';
	@override late final _StringsWorkoutEditorRemoveDialogZh remove_dialog = _StringsWorkoutEditorRemoveDialogZh._(_root);
}

// Path: workout
class _StringsWorkoutZh extends _StringsWorkoutPt {
	_StringsWorkoutZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '训练';
	@override String get create_tooltip => '创建新计划';
	@override late final _StringsWorkoutEmptyStateZh empty_state = _StringsWorkoutEmptyStateZh._(_root);
	@override late final _StringsWorkoutSummaryZh summary = _StringsWorkoutSummaryZh._(_root);
	@override late final _StringsWorkoutOptionsZh options = _StringsWorkoutOptionsZh._(_root);
	@override late final _StringsWorkoutDialogsZh dialogs = _StringsWorkoutDialogsZh._(_root);
	@override String get plan_empty => '此计划为空。';
	@override String get add_exercise_short => '运动';
	@override late final _StringsWorkoutCalendarZh calendar = _StringsWorkoutCalendarZh._(_root);
}

// Path: mock
class _StringsMockZh extends _StringsMockPt {
	_StringsMockZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsMockExploreZh explore = _StringsMockExploreZh._(_root);
	@override late final _StringsMockStatsZh stats = _StringsMockStatsZh._(_root);
}

// Path: dashboard.classification
class _StringsDashboardClassificationZh extends _StringsDashboardClassificationPt {
	_StringsDashboardClassificationZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '⭐ 排名';
	@override String get remaining_prefix => '剩余 ';
	@override String get remaining_suffix => ' 天';
	@override String get rank_suffix => '名';
}

// Path: dashboard.stats
class _StringsDashboardStatsZh extends _StringsDashboardStatsPt {
	_StringsDashboardStatsZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '统计';
	@override String get empty => '编辑以添加统计数据。';
}

// Path: diet.water
class _StringsDietWaterZh extends _StringsDietWaterPt {
	_StringsDietWaterZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get edit_goal_title => '设定饮水目标';
	@override String get liters_label => '升';
	@override String get edit_stepper_title => '每次点击量';
	@override String get ml_label => '毫升 (ml)';
	@override String goal_display({required Object value}) => '目标: ${value} L';
}

// Path: diet.macros
class _StringsDietMacrosZh extends _StringsDietMacrosPt {
	_StringsDietMacrosZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get carbs => '碳水化合物';
	@override String get protein => '蛋白质';
	@override String get fat => '脂肪';
}

// Path: diet.meal
class _StringsDietMealZh extends _StringsDietMealPt {
	_StringsDietMealZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String more_items({required Object count}) => '+ ${count} 其他项目';
	@override String total_calories({required Object calories}) => '总计: ${calories} 千卡';
	@override String get empty => '未记录食物';
	@override String get not_found => '未找到餐点';
}

// Path: diet.meal_types
class _StringsDietMealTypesZh extends _StringsDietMealTypesPt {
	_StringsDietMealTypesZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get breakfast => '早餐';
	@override String get morning_snack => '早间加餐';
	@override String get lunch => '午餐';
	@override String get afternoon_snack => '下午加餐';
	@override String get dinner => '晚餐';
	@override String get supper => '夜宵';
	@override String get pre_workout => '训练前';
	@override String get post_workout => '训练后';
	@override String get snack => '零食';
}

// Path: explore.categories
class _StringsExploreCategoriesZh extends _StringsExploreCategoriesPt {
	_StringsExploreCategoriesZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get activity => '活动';
	@override String get nutrition => '营养';
	@override String get sleep => '睡眠';
	@override String get medication => '药物';
	@override String get body_measurements => '身体测量';
	@override String get mobility => '灵活性';
}

// Path: leaderboard.zones
class _StringsLeaderboardZonesZh extends _StringsLeaderboardZonesPt {
	_StringsLeaderboardZonesZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get promotion => '晋级区';
	@override String get demotion => '降级区';
}

// Path: leaderboard.entry
class _StringsLeaderboardEntryZh extends _StringsLeaderboardEntryPt {
	_StringsLeaderboardEntryZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String level({required Object level}) => '等级 ${level}';
	@override String xp({required Object value}) => '${value} XP';
}

// Path: leaderboard.leagues
class _StringsLeaderboardLeaguesZh extends _StringsLeaderboardLeaguesPt {
	_StringsLeaderboardLeaguesZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get wood => '木头';
	@override String get iron => '铁';
	@override String get bronze => '青铜';
	@override String get silver => '白银';
	@override String get gold => '黄金';
	@override String get platinum => '白金';
	@override String get diamond => '钻石';
	@override String get obsidian => '黑曜石';
	@override String get master => '大师';
	@override String get stellar => '星耀';
	@override String get legend => '传奇';
}

// Path: profile_setup.sections
class _StringsProfileSetupSectionsZh extends _StringsProfileSetupSectionsPt {
	_StringsProfileSetupSectionsZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get about => '关于您';
	@override String get measures => '测量';
	@override String get goal => '主要目标';
}

// Path: profile_setup.fields
class _StringsProfileSetupFieldsZh extends _StringsProfileSetupFieldsPt {
	_StringsProfileSetupFieldsZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get name => '全名';
	@override String get name_error => '请输入您的名字';
	@override String get dob => '出生日期';
	@override String get gender => '性别';
	@override String get height => '身高 (cm)';
	@override String get weight => '体重 (kg)';
	@override String get goal_select => '选择您的目标';
	@override String get required_error => '必填';
}

// Path: profile_setup.actions
class _StringsProfileSetupActionsZh extends _StringsProfileSetupActionsPt {
	_StringsProfileSetupActionsZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get save => '保存更改';
	@override String get finish => '完成注册';
}

// Path: profile_setup.feedback
class _StringsProfileSetupFeedbackZh extends _StringsProfileSetupFeedbackPt {
	_StringsProfileSetupFeedbackZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get fill_all => '请填写所有字段。';
	@override String get success => '个人资料保存成功！';
	@override String error({required Object error}) => '保存错误: ${error}';
}

// Path: profile_setup.goals
class _StringsProfileSetupGoalsZh extends _StringsProfileSetupGoalsPt {
	_StringsProfileSetupGoalsZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get lose_weight => '减肥';
	@override String get gain_muscle => '增肌';
	@override String get endurance => '提高耐力';
	@override String get health => '保持健康';
}

// Path: profile_setup.genders
class _StringsProfileSetupGendersZh extends _StringsProfileSetupGendersPt {
	_StringsProfileSetupGendersZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get male => '男';
	@override String get female => '女';
	@override String get other => '其他';
}

// Path: workout_create.suggestions
class _StringsWorkoutCreateSuggestionsZh extends _StringsWorkoutCreateSuggestionsPt {
	_StringsWorkoutCreateSuggestionsZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get full_body => '全身';
	@override String get upper_body => '上半身';
	@override String get lower_body => '下半身';
	@override String get push_day => '推力日 (Push)';
	@override String get pull_day => '拉力日 (Pull)';
	@override String get leg_day => '腿部日';
	@override String get cardio_abs => '有氧 & 腹肌';
	@override String get yoga_flow => '瑜伽流';
}

// Path: workout_editor.remove_dialog
class _StringsWorkoutEditorRemoveDialogZh extends _StringsWorkoutEditorRemoveDialogPt {
	_StringsWorkoutEditorRemoveDialogZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '移除运动？';
	@override String content({required Object name}) => '您确定要移除 ${name} 吗？';
	@override String get confirm => '移除';
}

// Path: workout.empty_state
class _StringsWorkoutEmptyStateZh extends _StringsWorkoutEmptyStatePt {
	_StringsWorkoutEmptyStateZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '未找到训练计划。';
	@override String get button => '创建我的第一个训练';
}

// Path: workout.summary
class _StringsWorkoutSummaryZh extends _StringsWorkoutSummaryPt {
	_StringsWorkoutSummaryZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get today => '今天';
}

// Path: workout.options
class _StringsWorkoutOptionsZh extends _StringsWorkoutOptionsPt {
	_StringsWorkoutOptionsZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get rename => '重命名计划';
	@override String get delete => '删除计划';
}

// Path: workout.dialogs
class _StringsWorkoutDialogsZh extends _StringsWorkoutDialogsPt {
	_StringsWorkoutDialogsZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get rename_label => '训练名称';
	@override String get delete_title => '删除计划？';
	@override String delete_content({required Object name}) => '您确定要删除 "${name}" 吗？此操作无法撤销。';
	@override String get delete_confirm => '删除';
}

// Path: workout.calendar
class _StringsWorkoutCalendarZh extends _StringsWorkoutCalendarPt {
	_StringsWorkoutCalendarZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override List<String> get months => [
		'',
		'一月',
		'二月',
		'三月',
		'四月',
		'五月',
		'六月',
		'七月',
		'八月',
		'九月',
		'十月',
		'十一月',
		'十二月',
	];
	@override List<String> get weekdays => [
		'日',
		'一',
		'二',
		'三',
		'四',
		'五',
		'六',
	];
}

// Path: mock.explore
class _StringsMockExploreZh extends _StringsMockExplorePt {
	_StringsMockExploreZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get nutrition => '营养';
	@override String get training => '训练';
	@override String get sleep => '睡眠';
	@override String get mindfulness => '正念';
	@override late final _StringsMockExploreTagsZh tags = _StringsMockExploreTagsZh._(_root);
}

// Path: mock.stats
class _StringsMockStatsZh extends _StringsMockStatsPt {
	_StringsMockStatsZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get calories => '卡路里';
	@override String get protein => '蛋白质';
	@override String get carbs => '碳水';
	@override String get fat => '脂肪';
	@override String get water => '水';
	@override String get steps => '步数';
	@override String get sleep => '睡眠';
}

// Path: mock.explore.tags
class _StringsMockExploreTagsZh extends _StringsMockExploreTagsPt {
	_StringsMockExploreTagsZh._(_StringsZh root) : this._root = root, super._(root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get macros => '宏量营养素';
	@override String get hydration => '补水';
	@override String get recipes => '食谱';
	@override String get hypertrophy => '肥大';
	@override String get strength => '力量';
	@override String get mobility => '灵活性';
	@override String get hygiene => '卫生';
	@override String get cycle => '周期';
	@override String get breathing => '呼吸';
	@override String get focus => '专注';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.error': return 'Erro ao carregar';
			case 'common.error_profile': return 'Erro ao carregar perfil';
			case 'common.error_stats': return 'Erro ao carregar estatísticas';
			case 'common.back': return 'Voltar';
			case 'common.cancel': return 'Cancelar';
			case 'common.save': return 'Salvar';
			case 'common.not_authenticated': return 'Usuário não autenticado.';
			case 'common.xp_abbr': return 'XP';
			case 'common.league': return 'Liga';
			case 'common.rank_pattern': return ({required Object rank}) => 'Rank #${rank}';
			case 'common.empty_list': return 'Lista vazia';
			case 'login.tagline': return 'Seu esforço, seus dados,\nseus resultados.';
			case 'login.google_button': return 'Entrar com Google';
			case 'login.terms_disclaimer': return 'Ao continuar, você concorda com nossos Termos.';
			case 'dashboard.level_abbr': return 'nvl.';
			case 'dashboard.greeting': return 'Olá, ';
			case 'dashboard.greeting_generic': return 'Olá!';
			case 'dashboard.subtitle': return 'Vamos juntos alcançar suas metas de saúde!';
			case 'dashboard.classification.title': return '⭐ Classificação';
			case 'dashboard.classification.remaining_prefix': return 'restam ';
			case 'dashboard.classification.remaining_suffix': return ' dias';
			case 'dashboard.classification.rank_suffix': return 'º Lugar';
			case 'dashboard.stats.title': return 'Estatísticas';
			case 'dashboard.stats.empty': return 'Edite para adicionar estatísticas.';
			case 'success.title': return 'Sucesso';
			case 'success.default_message': return 'Tudo Certo! Seus dados foram cadastrados!';
			case 'under_construction.title': return '404';
			case 'under_construction.message': return 'Essa página ainda está em construção!';
			case 'under_construction.subtitle': return 'Estava fazendo seu cardio e se perdeu?';
			case 'edit_stats.title': return 'Editar destaques';
			case 'edit_stats.instruction': return 'Selecione até 4 estatísticas para destacar';
			case 'add_food.title': return 'Adicionar Alimento';
			case 'add_food.search_hint': return 'Busque ex: "Maçã", "Whey"...';
			case 'add_food.not_found': return 'Nenhum alimento encontrado';
			case 'add_food.error_api': return 'Erro na conexão com a API';
			case 'add_food.instruction': return 'Digite para buscar na base de dados global';
			case 'add_food.macro_p': return 'P';
			case 'add_food.macro_c': return 'C';
			case 'add_food.macro_f': return 'G';
			case 'diet.title': return 'Dieta';
			case 'diet.water.edit_goal_title': return 'Definir Meta de Água';
			case 'diet.water.liters_label': return 'Litros';
			case 'diet.water.edit_stepper_title': return 'Quantidade por Clique';
			case 'diet.water.ml_label': return 'Mililitros (ml)';
			case 'diet.water.goal_display': return ({required Object value}) => 'Meta: ${value} L';
			case 'diet.macros.carbs': return 'Carboidrato';
			case 'diet.macros.protein': return 'Proteína';
			case 'diet.macros.fat': return 'Gordura';
			case 'diet.meal.more_items': return ({required Object count}) => '+ ${count} outros itens';
			case 'diet.meal.total_calories': return ({required Object calories}) => 'Total: ${calories} kcal';
			case 'diet.meal.empty': return 'Nenhum alimento registrado';
			case 'diet.meal.not_found': return 'Refeição não encontrada';
			case 'diet.meal_types.breakfast': return 'Café da Manhã';
			case 'diet.meal_types.morning_snack': return 'Lanche da Manhã';
			case 'diet.meal_types.lunch': return 'Almoço';
			case 'diet.meal_types.afternoon_snack': return 'Lanche da Tarde';
			case 'diet.meal_types.dinner': return 'Jantar';
			case 'diet.meal_types.supper': return 'Ceia';
			case 'diet.meal_types.pre_workout': return 'Pré-treino';
			case 'diet.meal_types.post_workout': return 'Pós-treino';
			case 'diet.meal_types.snack': return 'Lanche';
			case 'meal_detail.title': return 'Detalhes da Refeição';
			case 'meal_detail.macro_summary': return ({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal • P ${protein}g • C ${carbs}g • G ${fat}g';
			case 'meal_detail.item_details': return ({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal - P ${protein}g C ${carbs}g G ${fat}g';
			case 'explore.title': return 'Explorar';
			case 'explore.search_hint': return 'Buscar funcionalidade';
			case 'explore.not_found': return 'Nenhuma funcionalidade encontrada.';
			case 'explore.categories.activity': return 'Atividade';
			case 'explore.categories.nutrition': return 'Alimentação';
			case 'explore.categories.sleep': return 'Sono';
			case 'explore.categories.medication': return 'Medicamentos';
			case 'explore.categories.body_measurements': return 'Medidas Corporais';
			case 'explore.categories.mobility': return 'Mobilidade';
			case 'leaderboard.title': return 'Leaderboard';
			case 'leaderboard.error': return 'Erro ao carregar leaderboard';
			case 'leaderboard.zones.promotion': return 'ZONA DE PROMOÇÃO';
			case 'leaderboard.zones.demotion': return 'ZONA DE REBAIXAMENTO';
			case 'leaderboard.entry.level': return ({required Object level}) => 'Nível ${level}';
			case 'leaderboard.entry.xp': return ({required Object value}) => '${value} XP';
			case 'leaderboard.leagues.wood': return 'MADEIRA';
			case 'leaderboard.leagues.iron': return 'FERRO';
			case 'leaderboard.leagues.bronze': return 'BRONZE';
			case 'leaderboard.leagues.silver': return 'PRATA';
			case 'leaderboard.leagues.gold': return 'OURO';
			case 'leaderboard.leagues.platinum': return 'PLATINA';
			case 'leaderboard.leagues.diamond': return 'DIAMANTE';
			case 'leaderboard.leagues.obsidian': return 'OBSIDIANA';
			case 'leaderboard.leagues.master': return 'MESTRE';
			case 'leaderboard.leagues.stellar': return 'ESTELAR';
			case 'leaderboard.leagues.legend': return 'LENDA';
			case 'profile_setup.title_edit': return 'Editar Perfil';
			case 'profile_setup.title_create': return 'Criar Perfil';
			case 'profile_setup.welcome': return 'Bem-vindo(a)!';
			case 'profile_setup.subtitle': return 'Vamos configurar seu perfil para personalizar sua jornada.';
			case 'profile_setup.sections.about': return 'Sobre você';
			case 'profile_setup.sections.measures': return 'Medidas';
			case 'profile_setup.sections.goal': return 'Objetivo Principal';
			case 'profile_setup.fields.name': return 'Nome Completo';
			case 'profile_setup.fields.name_error': return 'Informe seu nome';
			case 'profile_setup.fields.dob': return 'Nascimento';
			case 'profile_setup.fields.gender': return 'Gênero';
			case 'profile_setup.fields.height': return 'Altura (cm)';
			case 'profile_setup.fields.weight': return 'Peso (kg)';
			case 'profile_setup.fields.goal_select': return 'Selecione seu objetivo';
			case 'profile_setup.fields.required_error': return 'Obrigatório';
			case 'profile_setup.actions.save': return 'Salvar Alterações';
			case 'profile_setup.actions.finish': return 'Finalizar Cadastro';
			case 'profile_setup.feedback.fill_all': return 'Por favor, preencha todos os campos.';
			case 'profile_setup.feedback.success': return 'Perfil salvo com sucesso!';
			case 'profile_setup.feedback.error': return ({required Object error}) => 'Erro ao salvar: ${error}';
			case 'profile_setup.goals.lose_weight': return 'Perder Peso';
			case 'profile_setup.goals.gain_muscle': return 'Ganhar Massa Muscular';
			case 'profile_setup.goals.endurance': return 'Melhorar Resistência';
			case 'profile_setup.goals.health': return 'Manter Saúde';
			case 'profile_setup.genders.male': return 'Masculino';
			case 'profile_setup.genders.female': return 'Feminino';
			case 'profile_setup.genders.other': return 'Outro';
			case 'profile.title': return 'Perfil';
			case 'profile.stats_format': return ({required Object age, required Object height, required Object weight}) => '${age} anos • ${height} cm • ${weight} kg';
			case 'profile.dark_mode': return 'Modo Escuro';
			case 'profile.edit_profile': return 'Atualizar perfil';
			case 'profile.view_leaderboard': return 'Ver Leaderboard';
			case 'profile.logout': return 'Sair (Logout)';
			case 'profile.not_found': return 'Perfil não encontrado';
			case 'profile.create_profile': return 'Criar perfil';
			case 'profile.default_user': return 'Atleta';
			case 'add_exercise.title': return 'Adicionar Exercício';
			case 'add_exercise.search_hint': return 'Buscar por grupo muscular (ex: Peito, Costas)';
			case 'add_exercise.error': return ({required Object error}) => 'Erro: ${error}';
			case 'add_exercise.empty_title': return ({required Object query}) => 'Nenhum exercício encontrado para "${query}"';
			case 'add_exercise.empty_subtitle': return 'Tente: Peito, Costas, Pernas, Bíceps...';
			case 'add_exercise.added_feedback': return ({required Object name}) => '${name} adicionado ao treino!';
			case 'workout_create.title': return 'Novo Plano';
			case 'workout_create.subtitle': return 'Dê um nome para sua nova rotina de treinos.';
			case 'workout_create.field_label': return 'Nome do Treino';
			case 'workout_create.field_hint': return 'Ex: Treino A';
			case 'workout_create.validator_error': return 'Por favor, dê um nome ao treino.';
			case 'workout_create.button_create': return 'Criar Treino';
			case 'workout_create.suggestions_label': return 'Sugestões rápidas:';
			case 'workout_create.success_feedback': return ({required Object name}) => 'Treino "${name}" criado!';
			case 'workout_create.error_feedback': return ({required Object error}) => 'Erro ao criar: ${error}';
			case 'workout_create.suggestions.full_body': return 'Full Body';
			case 'workout_create.suggestions.upper_body': return 'Upper Body';
			case 'workout_create.suggestions.lower_body': return 'Lower Body';
			case 'workout_create.suggestions.push_day': return 'Push Day';
			case 'workout_create.suggestions.pull_day': return 'Pull Day';
			case 'workout_create.suggestions.leg_day': return 'Leg Day';
			case 'workout_create.suggestions.cardio_abs': return 'Cardio & Abs';
			case 'workout_create.suggestions.yoga_flow': return 'Yoga Flow';
			case 'workout_editor.title': return 'Editar Treino';
			case 'workout_editor.add_button': return 'Adicionar';
			case 'workout_editor.error': return ({required Object error}) => 'Erro: ${error}';
			case 'workout_editor.not_found': return 'Plano não encontrado.';
			case 'workout_editor.empty_text': return 'Este treino está vazio.';
			case 'workout_editor.add_exercise_button': return 'Adicionar Exercício';
			case 'workout_editor.removed_snackbar': return ({required Object name}) => '${name} removido';
			case 'workout_editor.remove_dialog.title': return 'Remover exercício?';
			case 'workout_editor.remove_dialog.content': return ({required Object name}) => 'Deseja remover ${name}?';
			case 'workout_editor.remove_dialog.confirm': return 'Remover';
			case 'workout.title': return 'Treino';
			case 'workout.create_tooltip': return 'Criar novo plano';
			case 'workout.empty_state.title': return 'Nenhum plano de treino encontrado.';
			case 'workout.empty_state.button': return 'Criar meu primeiro treino';
			case 'workout.summary.today': return 'Hoje';
			case 'workout.options.rename': return 'Renomear Plano';
			case 'workout.options.delete': return 'Excluir Plano';
			case 'workout.dialogs.rename_label': return 'Nome do treino';
			case 'workout.dialogs.delete_title': return 'Excluir Plano?';
			case 'workout.dialogs.delete_content': return ({required Object name}) => 'Tem certeza que deseja excluir "${name}"? Esta ação não pode ser desfeita.';
			case 'workout.dialogs.delete_confirm': return 'Excluir';
			case 'workout.plan_empty': return 'Este plano está vazio.';
			case 'workout.add_exercise_short': return 'Exercício';
			case 'workout.calendar.months.0': return '';
			case 'workout.calendar.months.1': return 'Janeiro';
			case 'workout.calendar.months.2': return 'Fevereiro';
			case 'workout.calendar.months.3': return 'Março';
			case 'workout.calendar.months.4': return 'Abril';
			case 'workout.calendar.months.5': return 'Maio';
			case 'workout.calendar.months.6': return 'Junho';
			case 'workout.calendar.months.7': return 'Julho';
			case 'workout.calendar.months.8': return 'Agosto';
			case 'workout.calendar.months.9': return 'Setembro';
			case 'workout.calendar.months.10': return 'Outubro';
			case 'workout.calendar.months.11': return 'Novembro';
			case 'workout.calendar.months.12': return 'Dezembro';
			case 'workout.calendar.weekdays.0': return 'D';
			case 'workout.calendar.weekdays.1': return 'S';
			case 'workout.calendar.weekdays.2': return 'T';
			case 'workout.calendar.weekdays.3': return 'Q';
			case 'workout.calendar.weekdays.4': return 'Q';
			case 'workout.calendar.weekdays.5': return 'S';
			case 'workout.calendar.weekdays.6': return 'S';
			case 'mock.explore.nutrition': return 'Nutrição';
			case 'mock.explore.training': return 'Treino';
			case 'mock.explore.sleep': return 'Sono';
			case 'mock.explore.mindfulness': return 'Mindfulness';
			case 'mock.explore.tags.macros': return 'macros';
			case 'mock.explore.tags.hydration': return 'hidratação';
			case 'mock.explore.tags.recipes': return 'receitas';
			case 'mock.explore.tags.hypertrophy': return 'hipertrofia';
			case 'mock.explore.tags.strength': return 'força';
			case 'mock.explore.tags.mobility': return 'mobilidade';
			case 'mock.explore.tags.hygiene': return 'higiene';
			case 'mock.explore.tags.cycle': return 'ciclo';
			case 'mock.explore.tags.breathing': return 'respiração';
			case 'mock.explore.tags.focus': return 'foco';
			case 'mock.stats.calories': return 'Calorias';
			case 'mock.stats.protein': return 'Proteína';
			case 'mock.stats.carbs': return 'Carbo';
			case 'mock.stats.fat': return 'Gordura';
			case 'mock.stats.water': return 'Água';
			case 'mock.stats.steps': return 'Passos';
			case 'mock.stats.sleep': return 'Sono';
			default: return null;
		}
	}
}

extension on _StringsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.error': return 'Error loading';
			case 'common.error_profile': return 'Error loading profile';
			case 'common.error_stats': return 'Error loading stats';
			case 'common.back': return 'Back';
			case 'common.cancel': return 'Cancel';
			case 'common.save': return 'Save';
			case 'common.not_authenticated': return 'User not authenticated.';
			case 'common.xp_abbr': return 'XP';
			case 'common.league': return 'League';
			case 'common.rank_pattern': return ({required Object rank}) => 'Rank #${rank}';
			case 'common.empty_list': return 'Empty list';
			case 'login.tagline': return 'Your effort, your data,\nyour results.';
			case 'login.google_button': return 'Sign in with Google';
			case 'login.terms_disclaimer': return 'By continuing, you agree to our Terms.';
			case 'dashboard.level_abbr': return 'lvl.';
			case 'dashboard.greeting': return 'Hello, ';
			case 'dashboard.greeting_generic': return 'Hello!';
			case 'dashboard.subtitle': return 'Let\'s reach your health goals together!';
			case 'dashboard.classification.title': return '⭐ Leaderboard';
			case 'dashboard.classification.remaining_prefix': return 'ending in ';
			case 'dashboard.classification.remaining_suffix': return ' days';
			case 'dashboard.classification.rank_suffix': return ' Place';
			case 'dashboard.stats.title': return 'Statistics';
			case 'dashboard.stats.empty': return 'Edit to add statistics.';
			case 'success.title': return 'Success';
			case 'success.default_message': return 'All set! Your data has been registered!';
			case 'under_construction.title': return '404';
			case 'under_construction.message': return 'This page is still under construction!';
			case 'under_construction.subtitle': return 'Were you doing cardio and got lost?';
			case 'edit_stats.title': return 'Edit Highlights';
			case 'edit_stats.instruction': return 'Select up to 4 statistics to highlight';
			case 'add_food.title': return 'Add Food';
			case 'add_food.search_hint': return 'Search ex: "Apple", "Whey"...';
			case 'add_food.not_found': return 'No food found';
			case 'add_food.error_api': return 'Error connecting to API';
			case 'add_food.instruction': return 'Type to search the global database';
			case 'add_food.macro_p': return 'P';
			case 'add_food.macro_c': return 'C';
			case 'add_food.macro_f': return 'F';
			case 'diet.title': return 'Diet';
			case 'diet.water.edit_goal_title': return 'Set Water Goal';
			case 'diet.water.liters_label': return 'Liters';
			case 'diet.water.edit_stepper_title': return 'Amount per Click';
			case 'diet.water.ml_label': return 'Milliliters (ml)';
			case 'diet.water.goal_display': return ({required Object value}) => 'Goal: ${value} L';
			case 'diet.macros.carbs': return 'Carbs';
			case 'diet.macros.protein': return 'Protein';
			case 'diet.macros.fat': return 'Fat';
			case 'diet.meal.more_items': return ({required Object count}) => '+ ${count} other items';
			case 'diet.meal.total_calories': return ({required Object calories}) => 'Total: ${calories} kcal';
			case 'diet.meal.empty': return 'No food registered';
			case 'diet.meal.not_found': return 'Meal not found';
			case 'diet.meal_types.breakfast': return 'Breakfast';
			case 'diet.meal_types.morning_snack': return 'Morning Snack';
			case 'diet.meal_types.lunch': return 'Lunch';
			case 'diet.meal_types.afternoon_snack': return 'Afternoon Snack';
			case 'diet.meal_types.dinner': return 'Dinner';
			case 'diet.meal_types.supper': return 'Supper';
			case 'diet.meal_types.pre_workout': return 'Pre-workout';
			case 'diet.meal_types.post_workout': return 'Post-workout';
			case 'diet.meal_types.snack': return 'Snack';
			case 'meal_detail.title': return 'Meal Details';
			case 'meal_detail.macro_summary': return ({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal • P ${protein}g • C ${carbs}g • F ${fat}g';
			case 'meal_detail.item_details': return ({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal - P ${protein}g C ${carbs}g F ${fat}g';
			case 'explore.title': return 'Explore';
			case 'explore.search_hint': return 'Search feature';
			case 'explore.not_found': return 'No features found.';
			case 'explore.categories.activity': return 'Activity';
			case 'explore.categories.nutrition': return 'Nutrition';
			case 'explore.categories.sleep': return 'Sleep';
			case 'explore.categories.medication': return 'Medication';
			case 'explore.categories.body_measurements': return 'Body Measurements';
			case 'explore.categories.mobility': return 'Mobility';
			case 'leaderboard.title': return 'Leaderboard';
			case 'leaderboard.error': return 'Error loading leaderboard';
			case 'leaderboard.zones.promotion': return 'PROMOTION ZONE';
			case 'leaderboard.zones.demotion': return 'DEMOTION ZONE';
			case 'leaderboard.entry.level': return ({required Object level}) => 'Level ${level}';
			case 'leaderboard.entry.xp': return ({required Object value}) => '${value} XP';
			case 'leaderboard.leagues.wood': return 'WOOD';
			case 'leaderboard.leagues.iron': return 'IRON';
			case 'leaderboard.leagues.bronze': return 'BRONZE';
			case 'leaderboard.leagues.silver': return 'SILVER';
			case 'leaderboard.leagues.gold': return 'GOLD';
			case 'leaderboard.leagues.platinum': return 'PLATINUM';
			case 'leaderboard.leagues.diamond': return 'DIAMOND';
			case 'leaderboard.leagues.obsidian': return 'OBSIDIAN';
			case 'leaderboard.leagues.master': return 'MASTER';
			case 'leaderboard.leagues.stellar': return 'STELLAR';
			case 'leaderboard.leagues.legend': return 'LEGEND';
			case 'profile_setup.title_edit': return 'Edit Profile';
			case 'profile_setup.title_create': return 'Create Profile';
			case 'profile_setup.welcome': return 'Welcome!';
			case 'profile_setup.subtitle': return 'Let\'s set up your profile to personalize your journey.';
			case 'profile_setup.sections.about': return 'About you';
			case 'profile_setup.sections.measures': return 'Measurements';
			case 'profile_setup.sections.goal': return 'Main Goal';
			case 'profile_setup.fields.name': return 'Full Name';
			case 'profile_setup.fields.name_error': return 'Enter your name';
			case 'profile_setup.fields.dob': return 'Birth Date';
			case 'profile_setup.fields.gender': return 'Gender';
			case 'profile_setup.fields.height': return 'Height (cm)';
			case 'profile_setup.fields.weight': return 'Weight (kg)';
			case 'profile_setup.fields.goal_select': return 'Select your goal';
			case 'profile_setup.fields.required_error': return 'Required';
			case 'profile_setup.actions.save': return 'Save Changes';
			case 'profile_setup.actions.finish': return 'Finish Registration';
			case 'profile_setup.feedback.fill_all': return 'Please fill in all fields.';
			case 'profile_setup.feedback.success': return 'Profile saved successfully!';
			case 'profile_setup.feedback.error': return ({required Object error}) => 'Error saving: ${error}';
			case 'profile_setup.goals.lose_weight': return 'Lose Weight';
			case 'profile_setup.goals.gain_muscle': return 'Build Muscle';
			case 'profile_setup.goals.endurance': return 'Improve Endurance';
			case 'profile_setup.goals.health': return 'Maintain Health';
			case 'profile_setup.genders.male': return 'Male';
			case 'profile_setup.genders.female': return 'Female';
			case 'profile_setup.genders.other': return 'Other';
			case 'profile.title': return 'Profile';
			case 'profile.stats_format': return ({required Object age, required Object height, required Object weight}) => '${age} years • ${height} cm • ${weight} kg';
			case 'profile.dark_mode': return 'Dark Mode';
			case 'profile.edit_profile': return 'Update profile';
			case 'profile.view_leaderboard': return 'View Leaderboard';
			case 'profile.logout': return 'Log out';
			case 'profile.not_found': return 'Profile not found';
			case 'profile.create_profile': return 'Create profile';
			case 'profile.default_user': return 'Athlete';
			case 'add_exercise.title': return 'Add Exercise';
			case 'add_exercise.search_hint': return 'Search by muscle group (e.g. Chest, Back)';
			case 'add_exercise.error': return ({required Object error}) => 'Error: ${error}';
			case 'add_exercise.empty_title': return ({required Object query}) => 'No exercises found for "${query}"';
			case 'add_exercise.empty_subtitle': return 'Try: Chest, Back, Legs, Biceps...';
			case 'add_exercise.added_feedback': return ({required Object name}) => '${name} added to workout!';
			case 'workout_create.title': return 'New Plan';
			case 'workout_create.subtitle': return 'Name your new workout routine.';
			case 'workout_create.field_label': return 'Workout Name';
			case 'workout_create.field_hint': return 'Ex: Workout A';
			case 'workout_create.validator_error': return 'Please name the workout.';
			case 'workout_create.button_create': return 'Create Workout';
			case 'workout_create.suggestions_label': return 'Quick suggestions:';
			case 'workout_create.success_feedback': return ({required Object name}) => 'Workout "${name}" created!';
			case 'workout_create.error_feedback': return ({required Object error}) => 'Error creating: ${error}';
			case 'workout_create.suggestions.full_body': return 'Full Body';
			case 'workout_create.suggestions.upper_body': return 'Upper Body';
			case 'workout_create.suggestions.lower_body': return 'Lower Body';
			case 'workout_create.suggestions.push_day': return 'Push Day';
			case 'workout_create.suggestions.pull_day': return 'Pull Day';
			case 'workout_create.suggestions.leg_day': return 'Leg Day';
			case 'workout_create.suggestions.cardio_abs': return 'Cardio & Abs';
			case 'workout_create.suggestions.yoga_flow': return 'Yoga Flow';
			case 'workout_editor.title': return 'Edit Workout';
			case 'workout_editor.add_button': return 'Add';
			case 'workout_editor.error': return ({required Object error}) => 'Error: ${error}';
			case 'workout_editor.not_found': return 'Plan not found.';
			case 'workout_editor.empty_text': return 'This workout is empty.';
			case 'workout_editor.add_exercise_button': return 'Add Exercise';
			case 'workout_editor.removed_snackbar': return ({required Object name}) => '${name} removed';
			case 'workout_editor.remove_dialog.title': return 'Remove exercise?';
			case 'workout_editor.remove_dialog.content': return ({required Object name}) => 'Do you want to remove ${name}?';
			case 'workout_editor.remove_dialog.confirm': return 'Remove';
			case 'workout.title': return 'Workout';
			case 'workout.create_tooltip': return 'Create new plan';
			case 'workout.empty_state.title': return 'No workout plans found.';
			case 'workout.empty_state.button': return 'Create my first workout';
			case 'workout.summary.today': return 'Today';
			case 'workout.options.rename': return 'Rename Plan';
			case 'workout.options.delete': return 'Delete Plan';
			case 'workout.dialogs.rename_label': return 'Workout name';
			case 'workout.dialogs.delete_title': return 'Delete Plan?';
			case 'workout.dialogs.delete_content': return ({required Object name}) => 'Are you sure you want to delete "${name}"? This action cannot be undone.';
			case 'workout.dialogs.delete_confirm': return 'Delete';
			case 'workout.plan_empty': return 'This plan is empty.';
			case 'workout.add_exercise_short': return 'Exercise';
			case 'workout.calendar.months.0': return '';
			case 'workout.calendar.months.1': return 'January';
			case 'workout.calendar.months.2': return 'February';
			case 'workout.calendar.months.3': return 'March';
			case 'workout.calendar.months.4': return 'April';
			case 'workout.calendar.months.5': return 'May';
			case 'workout.calendar.months.6': return 'June';
			case 'workout.calendar.months.7': return 'July';
			case 'workout.calendar.months.8': return 'August';
			case 'workout.calendar.months.9': return 'September';
			case 'workout.calendar.months.10': return 'October';
			case 'workout.calendar.months.11': return 'November';
			case 'workout.calendar.months.12': return 'December';
			case 'workout.calendar.weekdays.0': return 'S';
			case 'workout.calendar.weekdays.1': return 'M';
			case 'workout.calendar.weekdays.2': return 'T';
			case 'workout.calendar.weekdays.3': return 'W';
			case 'workout.calendar.weekdays.4': return 'T';
			case 'workout.calendar.weekdays.5': return 'F';
			case 'workout.calendar.weekdays.6': return 'S';
			case 'mock.explore.nutrition': return 'Nutrition';
			case 'mock.explore.training': return 'Training';
			case 'mock.explore.sleep': return 'Sleep';
			case 'mock.explore.mindfulness': return 'Mindfulness';
			case 'mock.explore.tags.macros': return 'macros';
			case 'mock.explore.tags.hydration': return 'hydration';
			case 'mock.explore.tags.recipes': return 'recipes';
			case 'mock.explore.tags.hypertrophy': return 'hypertrophy';
			case 'mock.explore.tags.strength': return 'strength';
			case 'mock.explore.tags.mobility': return 'mobility';
			case 'mock.explore.tags.hygiene': return 'hygiene';
			case 'mock.explore.tags.cycle': return 'cycle';
			case 'mock.explore.tags.breathing': return 'breathing';
			case 'mock.explore.tags.focus': return 'focus';
			case 'mock.stats.calories': return 'Calories';
			case 'mock.stats.protein': return 'Protein';
			case 'mock.stats.carbs': return 'Carbs';
			case 'mock.stats.fat': return 'Fat';
			case 'mock.stats.water': return 'Water';
			case 'mock.stats.steps': return 'Steps';
			case 'mock.stats.sleep': return 'Sleep';
			default: return null;
		}
	}
}

extension on _StringsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.error': return 'Error al cargar';
			case 'common.error_profile': return 'Error al cargar perfil';
			case 'common.error_stats': return 'Error al cargar estadísticas';
			case 'common.back': return 'Volver';
			case 'common.cancel': return 'Cancelar';
			case 'common.save': return 'Guardar';
			case 'common.not_authenticated': return 'Usuario no autenticado.';
			case 'common.xp_abbr': return 'XP';
			case 'common.league': return 'Liga';
			case 'common.rank_pattern': return ({required Object rank}) => 'Rango #${rank}';
			case 'common.empty_list': return 'Lista vacía';
			case 'login.tagline': return 'Tu esfuerzo, tus datos,\ntus resultados.';
			case 'login.google_button': return 'Acceder con Google';
			case 'login.terms_disclaimer': return 'Al continuar, aceptas nuestros Términos.';
			case 'dashboard.level_abbr': return 'niv.';
			case 'dashboard.greeting': return 'Hola, ';
			case 'dashboard.greeting_generic': return '¡Hola!';
			case 'dashboard.subtitle': return '¡Alcancemos tus metas de salud juntos!';
			case 'dashboard.classification.title': return '⭐ Clasificación';
			case 'dashboard.classification.remaining_prefix': return 'termina en ';
			case 'dashboard.classification.remaining_suffix': return ' días';
			case 'dashboard.classification.rank_suffix': return 'º Lugar';
			case 'dashboard.stats.title': return 'Estadísticas';
			case 'dashboard.stats.empty': return 'Editar para agregar estadísticas.';
			case 'success.title': return 'Éxito';
			case 'success.default_message': return '¡Listo! ¡Tus datos han sido registrados!';
			case 'under_construction.title': return '404';
			case 'under_construction.message': return '¡Esta página aún está en construcción!';
			case 'under_construction.subtitle': return '¿Hacías cardio y te perdiste?';
			case 'edit_stats.title': return 'Editar Destacados';
			case 'edit_stats.instruction': return 'Selecciona hasta 4 estadísticas para destacar';
			case 'add_food.title': return 'Añadir Alimento';
			case 'add_food.search_hint': return 'Buscar ej: "Manzana", "Whey"...';
			case 'add_food.not_found': return 'Ningún alimento encontrado';
			case 'add_food.error_api': return 'Error de conexión con la API';
			case 'add_food.instruction': return 'Escribe para buscar en la base global';
			case 'add_food.macro_p': return 'P';
			case 'add_food.macro_c': return 'C';
			case 'add_food.macro_f': return 'G';
			case 'diet.title': return 'Dieta';
			case 'diet.water.edit_goal_title': return 'Meta de Agua';
			case 'diet.water.liters_label': return 'Litros';
			case 'diet.water.edit_stepper_title': return 'Cantidad por Clic';
			case 'diet.water.ml_label': return 'Mililitros (ml)';
			case 'diet.water.goal_display': return ({required Object value}) => 'Meta: ${value} L';
			case 'diet.macros.carbs': return 'Carbohidratos';
			case 'diet.macros.protein': return 'Proteínas';
			case 'diet.macros.fat': return 'Grasas';
			case 'diet.meal.more_items': return ({required Object count}) => '+ ${count} otros ítems';
			case 'diet.meal.total_calories': return ({required Object calories}) => 'Total: ${calories} kcal';
			case 'diet.meal.empty': return 'Ningún alimento registrado';
			case 'diet.meal.not_found': return 'Comida no encontrada';
			case 'diet.meal_types.breakfast': return 'Desayuno';
			case 'diet.meal_types.morning_snack': return 'Media Mañana';
			case 'diet.meal_types.lunch': return 'Almuerzo';
			case 'diet.meal_types.afternoon_snack': return 'Merienda';
			case 'diet.meal_types.dinner': return 'Cena';
			case 'diet.meal_types.supper': return 'Recena';
			case 'diet.meal_types.pre_workout': return 'Pre-entreno';
			case 'diet.meal_types.post_workout': return 'Post-entreno';
			case 'diet.meal_types.snack': return 'Snack';
			case 'meal_detail.title': return 'Detalles de la Comida';
			case 'meal_detail.macro_summary': return ({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal • P ${protein}g • C ${carbs}g • G ${fat}g';
			case 'meal_detail.item_details': return ({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal - P ${protein}g C ${carbs}g G ${fat}g';
			case 'explore.title': return 'Explorar';
			case 'explore.search_hint': return 'Buscar funcionalidad';
			case 'explore.not_found': return 'Ninguna funcionalidad encontrada.';
			case 'explore.categories.activity': return 'Actividad';
			case 'explore.categories.nutrition': return 'Nutrición';
			case 'explore.categories.sleep': return 'Sueño';
			case 'explore.categories.medication': return 'Medicamentos';
			case 'explore.categories.body_measurements': return 'Medidas Corporales';
			case 'explore.categories.mobility': return 'Movilidad';
			case 'leaderboard.title': return 'Clasificación';
			case 'leaderboard.error': return 'Error al cargar clasificación';
			case 'leaderboard.zones.promotion': return 'ZONA DE PROMOCIÓN';
			case 'leaderboard.zones.demotion': return 'ZONA DE DESCENSO';
			case 'leaderboard.entry.level': return ({required Object level}) => 'Nivel ${level}';
			case 'leaderboard.entry.xp': return ({required Object value}) => '${value} XP';
			case 'leaderboard.leagues.wood': return 'MADERA';
			case 'leaderboard.leagues.iron': return 'HIERRO';
			case 'leaderboard.leagues.bronze': return 'BRONCE';
			case 'leaderboard.leagues.silver': return 'PLATA';
			case 'leaderboard.leagues.gold': return 'ORO';
			case 'leaderboard.leagues.platinum': return 'PLATINO';
			case 'leaderboard.leagues.diamond': return 'DIAMANTE';
			case 'leaderboard.leagues.obsidian': return 'OBSIDIANA';
			case 'leaderboard.leagues.master': return 'MAESTRO';
			case 'leaderboard.leagues.stellar': return 'ESTELAR';
			case 'leaderboard.leagues.legend': return 'LEYENDA';
			case 'profile_setup.title_edit': return 'Editar Perfil';
			case 'profile_setup.title_create': return 'Crear Perfil';
			case 'profile_setup.welcome': return '¡Bienvenido!';
			case 'profile_setup.subtitle': return 'Configuremos tu perfil para personalizar tu jornada.';
			case 'profile_setup.sections.about': return 'Sobre ti';
			case 'profile_setup.sections.measures': return 'Medidas';
			case 'profile_setup.sections.goal': return 'Objetivo Principal';
			case 'profile_setup.fields.name': return 'Nombre Completo';
			case 'profile_setup.fields.name_error': return 'Ingresa tu nombre';
			case 'profile_setup.fields.dob': return 'Fecha de Nacimiento';
			case 'profile_setup.fields.gender': return 'Género';
			case 'profile_setup.fields.height': return 'Altura (cm)';
			case 'profile_setup.fields.weight': return 'Peso (kg)';
			case 'profile_setup.fields.goal_select': return 'Selecciona tu objetivo';
			case 'profile_setup.fields.required_error': return 'Obligatorio';
			case 'profile_setup.actions.save': return 'Guardar Cambios';
			case 'profile_setup.actions.finish': return 'Finalizar Registro';
			case 'profile_setup.feedback.fill_all': return 'Por favor completa todos los campos.';
			case 'profile_setup.feedback.success': return '¡Perfil guardado con éxito!';
			case 'profile_setup.feedback.error': return ({required Object error}) => 'Error al guardar: ${error}';
			case 'profile_setup.goals.lose_weight': return 'Perder Peso';
			case 'profile_setup.goals.gain_muscle': return 'Ganar Músculo';
			case 'profile_setup.goals.endurance': return 'Mejorar Resistencia';
			case 'profile_setup.goals.health': return 'Mantener Salud';
			case 'profile_setup.genders.male': return 'Hombre';
			case 'profile_setup.genders.female': return 'Mujer';
			case 'profile_setup.genders.other': return 'Otro';
			case 'profile.title': return 'Perfil';
			case 'profile.stats_format': return ({required Object age, required Object height, required Object weight}) => '${age} años • ${height} cm • ${weight} kg';
			case 'profile.dark_mode': return 'Modo Oscuro';
			case 'profile.edit_profile': return 'Actualizar perfil';
			case 'profile.view_leaderboard': return 'Ver Clasificación';
			case 'profile.logout': return 'Cerrar Sesión';
			case 'profile.not_found': return 'Perfil no encontrado';
			case 'profile.create_profile': return 'Crear perfil';
			case 'profile.default_user': return 'Atleta';
			case 'add_exercise.title': return 'Añadir Ejercicio';
			case 'add_exercise.search_hint': return 'Buscar por músculo (ej: Pecho, Espalda)';
			case 'add_exercise.error': return ({required Object error}) => 'Error: ${error}';
			case 'add_exercise.empty_title': return ({required Object query}) => 'Ningún ejercicio encontrado para "${query}"';
			case 'add_exercise.empty_subtitle': return 'Prueba: Pecho, Espalda, Piernas, Bíceps...';
			case 'add_exercise.added_feedback': return ({required Object name}) => '¡${name} añadido al entrenamiento!';
			case 'workout_create.title': return 'Nuevo Plan';
			case 'workout_create.subtitle': return 'Dale un nombre a tu nueva rutina.';
			case 'workout_create.field_label': return 'Nombre del Entrenamiento';
			case 'workout_create.field_hint': return 'Ej: Entrenamiento A';
			case 'workout_create.validator_error': return 'Por favor nombra el entrenamiento.';
			case 'workout_create.button_create': return 'Crear Entrenamiento';
			case 'workout_create.suggestions_label': return 'Sugerencias rápidas:';
			case 'workout_create.success_feedback': return ({required Object name}) => '¡Entrenamiento "${name}" creado!';
			case 'workout_create.error_feedback': return ({required Object error}) => 'Error al crear: ${error}';
			case 'workout_create.suggestions.full_body': return 'Cuerpo Completo';
			case 'workout_create.suggestions.upper_body': return 'Torso';
			case 'workout_create.suggestions.lower_body': return 'Pierna';
			case 'workout_create.suggestions.push_day': return 'Día de Empuje';
			case 'workout_create.suggestions.pull_day': return 'Día de Tirón';
			case 'workout_create.suggestions.leg_day': return 'Día de Pierna';
			case 'workout_create.suggestions.cardio_abs': return 'Cardio y Abdomen';
			case 'workout_create.suggestions.yoga_flow': return 'Yoga Flow';
			case 'workout_editor.title': return 'Editar Entrenamiento';
			case 'workout_editor.add_button': return 'Añadir';
			case 'workout_editor.error': return ({required Object error}) => 'Error: ${error}';
			case 'workout_editor.not_found': return 'Plan no encontrado.';
			case 'workout_editor.empty_text': return 'Este entrenamiento está vacío.';
			case 'workout_editor.add_exercise_button': return 'Añadir Ejercicio';
			case 'workout_editor.removed_snackbar': return ({required Object name}) => '${name} eliminado';
			case 'workout_editor.remove_dialog.title': return '¿Eliminar ejercicio?';
			case 'workout_editor.remove_dialog.content': return ({required Object name}) => '¿Quieres eliminar ${name}?';
			case 'workout_editor.remove_dialog.confirm': return 'Eliminar';
			case 'workout.title': return 'Entrenamiento';
			case 'workout.create_tooltip': return 'Crear nuevo plan';
			case 'workout.empty_state.title': return 'Ningún plan de entrenamiento encontrado.';
			case 'workout.empty_state.button': return 'Crear mi primer entrenamiento';
			case 'workout.summary.today': return 'Hoy';
			case 'workout.options.rename': return 'Renombrar Plan';
			case 'workout.options.delete': return 'Eliminar Plan';
			case 'workout.dialogs.rename_label': return 'Nombre del entrenamiento';
			case 'workout.dialogs.delete_title': return '¿Eliminar Plan?';
			case 'workout.dialogs.delete_content': return ({required Object name}) => '¿Estás seguro de eliminar "${name}"? Esta acción no se puede deshacer.';
			case 'workout.dialogs.delete_confirm': return 'Eliminar';
			case 'workout.plan_empty': return 'Este plan está vacío.';
			case 'workout.add_exercise_short': return 'Ejercicio';
			case 'workout.calendar.months.0': return '';
			case 'workout.calendar.months.1': return 'Enero';
			case 'workout.calendar.months.2': return 'Febrero';
			case 'workout.calendar.months.3': return 'Marzo';
			case 'workout.calendar.months.4': return 'Abril';
			case 'workout.calendar.months.5': return 'Mayo';
			case 'workout.calendar.months.6': return 'Junio';
			case 'workout.calendar.months.7': return 'Julio';
			case 'workout.calendar.months.8': return 'Agosto';
			case 'workout.calendar.months.9': return 'Septiembre';
			case 'workout.calendar.months.10': return 'Octubre';
			case 'workout.calendar.months.11': return 'Noviembre';
			case 'workout.calendar.months.12': return 'Diciembre';
			case 'workout.calendar.weekdays.0': return 'D';
			case 'workout.calendar.weekdays.1': return 'L';
			case 'workout.calendar.weekdays.2': return 'M';
			case 'workout.calendar.weekdays.3': return 'M';
			case 'workout.calendar.weekdays.4': return 'J';
			case 'workout.calendar.weekdays.5': return 'V';
			case 'workout.calendar.weekdays.6': return 'S';
			case 'mock.explore.nutrition': return 'Nutrición';
			case 'mock.explore.training': return 'Entrenamiento';
			case 'mock.explore.sleep': return 'Sueño';
			case 'mock.explore.mindfulness': return 'Mindfulness';
			case 'mock.explore.tags.macros': return 'macros';
			case 'mock.explore.tags.hydration': return 'hidratación';
			case 'mock.explore.tags.recipes': return 'recetas';
			case 'mock.explore.tags.hypertrophy': return 'hipertrofia';
			case 'mock.explore.tags.strength': return 'fuerza';
			case 'mock.explore.tags.mobility': return 'movilidad';
			case 'mock.explore.tags.hygiene': return 'higiene';
			case 'mock.explore.tags.cycle': return 'ciclo';
			case 'mock.explore.tags.breathing': return 'respiración';
			case 'mock.explore.tags.focus': return 'foco';
			case 'mock.stats.calories': return 'Calorías';
			case 'mock.stats.protein': return 'Proteínas';
			case 'mock.stats.carbs': return 'Carbohidratos';
			case 'mock.stats.fat': return 'Grasas';
			case 'mock.stats.water': return 'Agua';
			case 'mock.stats.steps': return 'Pasos';
			case 'mock.stats.sleep': return 'Sueño';
			default: return null;
		}
	}
}

extension on _StringsFr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.error': return 'Erreur de chargement';
			case 'common.error_profile': return 'Erreur de chargement du profil';
			case 'common.error_stats': return 'Erreur de chargement des statistiques';
			case 'common.back': return 'Retour';
			case 'common.cancel': return 'Annuler';
			case 'common.save': return 'Enregistrer';
			case 'common.not_authenticated': return 'Utilisateur non authentifié.';
			case 'common.xp_abbr': return 'XP';
			case 'common.league': return 'Ligue';
			case 'common.rank_pattern': return ({required Object rank}) => 'Rang #${rank}';
			case 'common.empty_list': return 'Liste vide';
			case 'login.tagline': return 'Vos efforts, vos données,\nvos résultats.';
			case 'login.google_button': return 'Se connecter avec Google';
			case 'login.terms_disclaimer': return 'En continuant, vous acceptez nos Conditions.';
			case 'dashboard.level_abbr': return 'niv.';
			case 'dashboard.greeting': return 'Bonjour, ';
			case 'dashboard.greeting_generic': return 'Bonjour !';
			case 'dashboard.subtitle': return 'Atteignons vos objectifs santé ensemble !';
			case 'dashboard.classification.title': return '⭐ Classement';
			case 'dashboard.classification.remaining_prefix': return 'se termine dans ';
			case 'dashboard.classification.remaining_suffix': return ' jours';
			case 'dashboard.classification.rank_suffix': return 'e Place';
			case 'dashboard.stats.title': return 'Statistiques';
			case 'dashboard.stats.empty': return 'Modifier pour ajouter des stats.';
			case 'success.title': return 'Succès';
			case 'success.default_message': return 'C\'est tout bon ! Vos données ont été enregistrées !';
			case 'under_construction.title': return '404';
			case 'under_construction.message': return 'Cette page est encore en construction !';
			case 'under_construction.subtitle': return 'Vous faisiez du cardio et vous vous êtes perdu ?';
			case 'edit_stats.title': return 'Modifier les favoris';
			case 'edit_stats.instruction': return 'Sélectionnez jusqu\'à 4 statistiques à mettre en avant';
			case 'add_food.title': return 'Ajouter un aliment';
			case 'add_food.search_hint': return 'Recherche ex: "Pomme", "Whey"...';
			case 'add_food.not_found': return 'Aucun aliment trouvé';
			case 'add_food.error_api': return 'Erreur de connexion à l\'API';
			case 'add_food.instruction': return 'Tapez pour chercher dans la base mondiale';
			case 'add_food.macro_p': return 'P';
			case 'add_food.macro_c': return 'G';
			case 'add_food.macro_f': return 'L';
			case 'diet.title': return 'Diète';
			case 'diet.water.edit_goal_title': return 'Objectif d\'eau';
			case 'diet.water.liters_label': return 'Litres';
			case 'diet.water.edit_stepper_title': return 'Quantité par clic';
			case 'diet.water.ml_label': return 'Millilitres (ml)';
			case 'diet.water.goal_display': return ({required Object value}) => 'Objectif : ${value} L';
			case 'diet.macros.carbs': return 'Glucides';
			case 'diet.macros.protein': return 'Protéines';
			case 'diet.macros.fat': return 'Lipides';
			case 'diet.meal.more_items': return ({required Object count}) => '+ ${count} autres articles';
			case 'diet.meal.total_calories': return ({required Object calories}) => 'Total : ${calories} kcal';
			case 'diet.meal.empty': return 'Aucun aliment enregistré';
			case 'diet.meal.not_found': return 'Repas non trouvé';
			case 'diet.meal_types.breakfast': return 'Petit-déjeuner';
			case 'diet.meal_types.morning_snack': return 'Collation matin';
			case 'diet.meal_types.lunch': return 'Déjeuner';
			case 'diet.meal_types.afternoon_snack': return 'Goûter';
			case 'diet.meal_types.dinner': return 'Dîner';
			case 'diet.meal_types.supper': return 'Souper';
			case 'diet.meal_types.pre_workout': return 'Pré-entraînement';
			case 'diet.meal_types.post_workout': return 'Post-entraînement';
			case 'diet.meal_types.snack': return 'Collation';
			case 'meal_detail.title': return 'Détails du repas';
			case 'meal_detail.macro_summary': return ({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal • P ${protein}g • G ${carbs}g • L ${fat}g';
			case 'meal_detail.item_details': return ({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal - P ${protein}g G ${carbs}g L ${fat}g';
			case 'explore.title': return 'Explorer';
			case 'explore.search_hint': return 'Rechercher une fonctionnalité';
			case 'explore.not_found': return 'Aucune fonctionnalité trouvée.';
			case 'explore.categories.activity': return 'Activité';
			case 'explore.categories.nutrition': return 'Nutrition';
			case 'explore.categories.sleep': return 'Sommeil';
			case 'explore.categories.medication': return 'Médicaments';
			case 'explore.categories.body_measurements': return 'Mensurations';
			case 'explore.categories.mobility': return 'Mobilité';
			case 'leaderboard.title': return 'Classement';
			case 'leaderboard.error': return 'Erreur de chargement du classement';
			case 'leaderboard.zones.promotion': return 'ZONE DE PROMOTION';
			case 'leaderboard.zones.demotion': return 'ZONE DE RELÉGATION';
			case 'leaderboard.entry.level': return ({required Object level}) => 'Niveau ${level}';
			case 'leaderboard.entry.xp': return ({required Object value}) => '${value} XP';
			case 'leaderboard.leagues.wood': return 'BOIS';
			case 'leaderboard.leagues.iron': return 'FER';
			case 'leaderboard.leagues.bronze': return 'BRONZE';
			case 'leaderboard.leagues.silver': return 'ARGENT';
			case 'leaderboard.leagues.gold': return 'OR';
			case 'leaderboard.leagues.platinum': return 'PLATINE';
			case 'leaderboard.leagues.diamond': return 'DIAMANT';
			case 'leaderboard.leagues.obsidian': return 'OBSIDIENNE';
			case 'leaderboard.leagues.master': return 'MAÎTRE';
			case 'leaderboard.leagues.stellar': return 'STELLAIRE';
			case 'leaderboard.leagues.legend': return 'LÉGENDE';
			case 'profile_setup.title_edit': return 'Modifier le profil';
			case 'profile_setup.title_create': return 'Créer un profil';
			case 'profile_setup.welcome': return 'Bienvenue !';
			case 'profile_setup.subtitle': return 'Configurons votre profil pour personnaliser votre parcours.';
			case 'profile_setup.sections.about': return 'À propos de vous';
			case 'profile_setup.sections.measures': return 'Mesures';
			case 'profile_setup.sections.goal': return 'Objectif principal';
			case 'profile_setup.fields.name': return 'Nom complet';
			case 'profile_setup.fields.name_error': return 'Entrez votre nom';
			case 'profile_setup.fields.dob': return 'Date de naissance';
			case 'profile_setup.fields.gender': return 'Genre';
			case 'profile_setup.fields.height': return 'Taille (cm)';
			case 'profile_setup.fields.weight': return 'Poids (kg)';
			case 'profile_setup.fields.goal_select': return 'Sélectionnez votre objectif';
			case 'profile_setup.fields.required_error': return 'Requis';
			case 'profile_setup.actions.save': return 'Enregistrer';
			case 'profile_setup.actions.finish': return 'Terminer l\'inscription';
			case 'profile_setup.feedback.fill_all': return 'Veuillez remplir tous les champs.';
			case 'profile_setup.feedback.success': return 'Profil enregistré avec succès !';
			case 'profile_setup.feedback.error': return ({required Object error}) => 'Erreur lors de l\'enregistrement : ${error}';
			case 'profile_setup.goals.lose_weight': return 'Perdre du poids';
			case 'profile_setup.goals.gain_muscle': return 'Gagner du muscle';
			case 'profile_setup.goals.endurance': return 'Améliorer l\'endurance';
			case 'profile_setup.goals.health': return 'Rester en bonne santé';
			case 'profile_setup.genders.male': return 'Homme';
			case 'profile_setup.genders.female': return 'Femme';
			case 'profile_setup.genders.other': return 'Autre';
			case 'profile.title': return 'Profil';
			case 'profile.stats_format': return ({required Object age, required Object height, required Object weight}) => '${age} ans • ${height} cm • ${weight} kg';
			case 'profile.dark_mode': return 'Mode Sombre';
			case 'profile.edit_profile': return 'Mettre à jour le profil';
			case 'profile.view_leaderboard': return 'Voir le classement';
			case 'profile.logout': return 'Se déconnecter';
			case 'profile.not_found': return 'Profil non trouvé';
			case 'profile.create_profile': return 'Créer un profil';
			case 'profile.default_user': return 'Athlète';
			case 'add_exercise.title': return 'Ajouter un exercice';
			case 'add_exercise.search_hint': return 'Chercher par muscle (ex: Pectoraux, Dos)';
			case 'add_exercise.error': return ({required Object error}) => 'Erreur : ${error}';
			case 'add_exercise.empty_title': return ({required Object query}) => 'Aucun exercice trouvé pour "${query}"';
			case 'add_exercise.empty_subtitle': return 'Essayez : Pectoraux, Dos, Jambes, Biceps...';
			case 'add_exercise.added_feedback': return ({required Object name}) => '${name} ajouté à l\'entraînement !';
			case 'workout_create.title': return 'Nouveau Plan';
			case 'workout_create.subtitle': return 'Donnez un nom à votre nouvelle routine.';
			case 'workout_create.field_label': return 'Nom de l\'entraînement';
			case 'workout_create.field_hint': return 'Ex : Entraînement A';
			case 'workout_create.validator_error': return 'Veuillez nommer l\'entraînement.';
			case 'workout_create.button_create': return 'Créer l\'entraînement';
			case 'workout_create.suggestions_label': return 'Suggestions rapides :';
			case 'workout_create.success_feedback': return ({required Object name}) => 'Entraînement "${name}" créé !';
			case 'workout_create.error_feedback': return ({required Object error}) => 'Erreur lors de la création : ${error}';
			case 'workout_create.suggestions.full_body': return 'Corps entier';
			case 'workout_create.suggestions.upper_body': return 'Haut du corps';
			case 'workout_create.suggestions.lower_body': return 'Bas du corps';
			case 'workout_create.suggestions.push_day': return 'Push Day';
			case 'workout_create.suggestions.pull_day': return 'Pull Day';
			case 'workout_create.suggestions.leg_day': return 'Journée Jambes';
			case 'workout_create.suggestions.cardio_abs': return 'Cardio & Abdos';
			case 'workout_create.suggestions.yoga_flow': return 'Yoga Flow';
			case 'workout_editor.title': return 'Modifier l\'entraînement';
			case 'workout_editor.add_button': return 'Ajouter';
			case 'workout_editor.error': return ({required Object error}) => 'Erreur : ${error}';
			case 'workout_editor.not_found': return 'Plan non trouvé.';
			case 'workout_editor.empty_text': return 'Cet entraînement est vide.';
			case 'workout_editor.add_exercise_button': return 'Ajouter un exercice';
			case 'workout_editor.removed_snackbar': return ({required Object name}) => '${name} supprimé';
			case 'workout_editor.remove_dialog.title': return 'Supprimer l\'exercice ?';
			case 'workout_editor.remove_dialog.content': return ({required Object name}) => 'Voulez-vous supprimer ${name} ?';
			case 'workout_editor.remove_dialog.confirm': return 'Supprimer';
			case 'workout.title': return 'Entraînement';
			case 'workout.create_tooltip': return 'Créer un nouveau plan';
			case 'workout.empty_state.title': return 'Aucun plan d\'entraînement trouvé.';
			case 'workout.empty_state.button': return 'Créer mon premier entraînement';
			case 'workout.summary.today': return 'Aujourd\'hui';
			case 'workout.options.rename': return 'Renommer le plan';
			case 'workout.options.delete': return 'Supprimer le plan';
			case 'workout.dialogs.rename_label': return 'Nom de l\'entraînement';
			case 'workout.dialogs.delete_title': return 'Supprimer le plan ?';
			case 'workout.dialogs.delete_content': return ({required Object name}) => 'Êtes-vous sûr de vouloir supprimer "${name}" ? Cette action est irréversible.';
			case 'workout.dialogs.delete_confirm': return 'Supprimer';
			case 'workout.plan_empty': return 'Ce plan est vide.';
			case 'workout.add_exercise_short': return 'Exercice';
			case 'workout.calendar.months.0': return '';
			case 'workout.calendar.months.1': return 'Janvier';
			case 'workout.calendar.months.2': return 'Février';
			case 'workout.calendar.months.3': return 'Mars';
			case 'workout.calendar.months.4': return 'Avril';
			case 'workout.calendar.months.5': return 'Mai';
			case 'workout.calendar.months.6': return 'Juin';
			case 'workout.calendar.months.7': return 'Juillet';
			case 'workout.calendar.months.8': return 'Août';
			case 'workout.calendar.months.9': return 'Septembre';
			case 'workout.calendar.months.10': return 'Octobre';
			case 'workout.calendar.months.11': return 'Novembre';
			case 'workout.calendar.months.12': return 'Décembre';
			case 'workout.calendar.weekdays.0': return 'D';
			case 'workout.calendar.weekdays.1': return 'L';
			case 'workout.calendar.weekdays.2': return 'M';
			case 'workout.calendar.weekdays.3': return 'M';
			case 'workout.calendar.weekdays.4': return 'J';
			case 'workout.calendar.weekdays.5': return 'V';
			case 'workout.calendar.weekdays.6': return 'S';
			case 'mock.explore.nutrition': return 'Nutrition';
			case 'mock.explore.training': return 'Entraînement';
			case 'mock.explore.sleep': return 'Sommeil';
			case 'mock.explore.mindfulness': return 'Pleine conscience';
			case 'mock.explore.tags.macros': return 'macros';
			case 'mock.explore.tags.hydration': return 'hydratation';
			case 'mock.explore.tags.recipes': return 'recettes';
			case 'mock.explore.tags.hypertrophy': return 'hypertrophie';
			case 'mock.explore.tags.strength': return 'force';
			case 'mock.explore.tags.mobility': return 'mobilité';
			case 'mock.explore.tags.hygiene': return 'hygiène';
			case 'mock.explore.tags.cycle': return 'cycle';
			case 'mock.explore.tags.breathing': return 'respiration';
			case 'mock.explore.tags.focus': return 'concentration';
			case 'mock.stats.calories': return 'Calories';
			case 'mock.stats.protein': return 'Protéines';
			case 'mock.stats.carbs': return 'Glucides';
			case 'mock.stats.fat': return 'Lipides';
			case 'mock.stats.water': return 'Eau';
			case 'mock.stats.steps': return 'Pas';
			case 'mock.stats.sleep': return 'Sommeil';
			default: return null;
		}
	}
}

extension on _StringsIt {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.error': return 'Errore di caricamento';
			case 'common.error_profile': return 'Errore caricamento profilo';
			case 'common.error_stats': return 'Errore caricamento statistiche';
			case 'common.back': return 'Indietro';
			case 'common.cancel': return 'Annulla';
			case 'common.save': return 'Salva';
			case 'common.not_authenticated': return 'Utente non autenticato.';
			case 'common.xp_abbr': return 'XP';
			case 'common.league': return 'Lega';
			case 'common.rank_pattern': return ({required Object rank}) => 'Rango #${rank}';
			case 'common.empty_list': return 'Elenco vuoto';
			case 'login.tagline': return 'Il tuo impegno, i tuoi dati,\ni tuoi risultati.';
			case 'login.google_button': return 'Accedi con Google';
			case 'login.terms_disclaimer': return 'Continuando, accetti i nostri Termini.';
			case 'dashboard.level_abbr': return 'liv.';
			case 'dashboard.greeting': return 'Ciao, ';
			case 'dashboard.greeting_generic': return 'Ciao!';
			case 'dashboard.subtitle': return 'Raggiungiamo insieme i tuoi obiettivi!';
			case 'dashboard.classification.title': return '⭐ Classifica';
			case 'dashboard.classification.remaining_prefix': return 'termina in ';
			case 'dashboard.classification.remaining_suffix': return ' giorni';
			case 'dashboard.classification.rank_suffix': return '° Posto';
			case 'dashboard.stats.title': return 'Statistiche';
			case 'dashboard.stats.empty': return 'Modifica per aggiungere statistiche.';
			case 'success.title': return 'Successo';
			case 'success.default_message': return 'Tutto pronto! I tuoi dati sono stati registrati!';
			case 'under_construction.title': return '404';
			case 'under_construction.message': return 'Questa pagina è ancora in costruzione!';
			case 'under_construction.subtitle': return 'Stavi facendo cardio e ti sei perso?';
			case 'edit_stats.title': return 'Modifica In Evidenza';
			case 'edit_stats.instruction': return 'Seleziona fino a 4 statistiche da mettere in evidenza';
			case 'add_food.title': return 'Aggiungi Cibo';
			case 'add_food.search_hint': return 'Cerca es: "Mela", "Whey"...';
			case 'add_food.not_found': return 'Nessun alimento trovato';
			case 'add_food.error_api': return 'Errore di connessione all\'API';
			case 'add_food.instruction': return 'Digita per cercare nel database globale';
			case 'add_food.macro_p': return 'P';
			case 'add_food.macro_c': return 'C';
			case 'add_food.macro_f': return 'G';
			case 'diet.title': return 'Dieta';
			case 'diet.water.edit_goal_title': return 'Obiettivo Acqua';
			case 'diet.water.liters_label': return 'Litri';
			case 'diet.water.edit_stepper_title': return 'Quantità per Click';
			case 'diet.water.ml_label': return 'Millilitri (ml)';
			case 'diet.water.goal_display': return ({required Object value}) => 'Obiettivo: ${value} L';
			case 'diet.macros.carbs': return 'Carboidrati';
			case 'diet.macros.protein': return 'Proteine';
			case 'diet.macros.fat': return 'Grassi';
			case 'diet.meal.more_items': return ({required Object count}) => '+ altri ${count} elementi';
			case 'diet.meal.total_calories': return ({required Object calories}) => 'Totale: ${calories} kcal';
			case 'diet.meal.empty': return 'Nessun alimento registrato';
			case 'diet.meal.not_found': return 'Pasto non trovato';
			case 'diet.meal_types.breakfast': return 'Colazione';
			case 'diet.meal_types.morning_snack': return 'Spuntino Mattina';
			case 'diet.meal_types.lunch': return 'Pranzo';
			case 'diet.meal_types.afternoon_snack': return 'Merenda';
			case 'diet.meal_types.dinner': return 'Cena';
			case 'diet.meal_types.supper': return 'Spuntino Serale';
			case 'diet.meal_types.pre_workout': return 'Pre-workout';
			case 'diet.meal_types.post_workout': return 'Post-workout';
			case 'diet.meal_types.snack': return 'Spuntino';
			case 'meal_detail.title': return 'Dettagli Pasto';
			case 'meal_detail.macro_summary': return ({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal • P ${protein}g • C ${carbs}g • G ${fat}g';
			case 'meal_detail.item_details': return ({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} kcal - P ${protein}g C ${carbs}g G ${fat}g';
			case 'explore.title': return 'Esplora';
			case 'explore.search_hint': return 'Cerca funzionalità';
			case 'explore.not_found': return 'Nessuna funzionalità trovata.';
			case 'explore.categories.activity': return 'Attività';
			case 'explore.categories.nutrition': return 'Nutrizione';
			case 'explore.categories.sleep': return 'Sonno';
			case 'explore.categories.medication': return 'Farmaci';
			case 'explore.categories.body_measurements': return 'Misure Corporee';
			case 'explore.categories.mobility': return 'Mobilità';
			case 'leaderboard.title': return 'Classifica';
			case 'leaderboard.error': return 'Errore caricamento classifica';
			case 'leaderboard.zones.promotion': return 'ZONA PROMOZIONE';
			case 'leaderboard.zones.demotion': return 'ZONA RETROCESSIONE';
			case 'leaderboard.entry.level': return ({required Object level}) => 'Livello ${level}';
			case 'leaderboard.entry.xp': return ({required Object value}) => '${value} XP';
			case 'leaderboard.leagues.wood': return 'LEGNO';
			case 'leaderboard.leagues.iron': return 'FERRO';
			case 'leaderboard.leagues.bronze': return 'BRONZO';
			case 'leaderboard.leagues.silver': return 'ARGENTO';
			case 'leaderboard.leagues.gold': return 'ORO';
			case 'leaderboard.leagues.platinum': return 'PLATINO';
			case 'leaderboard.leagues.diamond': return 'DIAMANTE';
			case 'leaderboard.leagues.obsidian': return 'OSSIDIANA';
			case 'leaderboard.leagues.master': return 'MAESTRO';
			case 'leaderboard.leagues.stellar': return 'STELLARE';
			case 'leaderboard.leagues.legend': return 'LEGGENDA';
			case 'profile_setup.title_edit': return 'Modifica Profilo';
			case 'profile_setup.title_create': return 'Crea Profilo';
			case 'profile_setup.welcome': return 'Benvenuto!';
			case 'profile_setup.subtitle': return 'Impostiamo il tuo profilo per personalizzare il tuo percorso.';
			case 'profile_setup.sections.about': return 'Su di te';
			case 'profile_setup.sections.measures': return 'Misure';
			case 'profile_setup.sections.goal': return 'Obiettivo Principale';
			case 'profile_setup.fields.name': return 'Nome Completo';
			case 'profile_setup.fields.name_error': return 'Inserisci il tuo nome';
			case 'profile_setup.fields.dob': return 'Data di Nascita';
			case 'profile_setup.fields.gender': return 'Genere';
			case 'profile_setup.fields.height': return 'Altezza (cm)';
			case 'profile_setup.fields.weight': return 'Peso (kg)';
			case 'profile_setup.fields.goal_select': return 'Seleziona il tuo obiettivo';
			case 'profile_setup.fields.required_error': return 'Obbligatorio';
			case 'profile_setup.actions.save': return 'Salva Modifiche';
			case 'profile_setup.actions.finish': return 'Termina Registrazione';
			case 'profile_setup.feedback.fill_all': return 'Per favore compila tutti i campi.';
			case 'profile_setup.feedback.success': return 'Profilo salvato con successo!';
			case 'profile_setup.feedback.error': return ({required Object error}) => 'Errore durante il salvataggio: ${error}';
			case 'profile_setup.goals.lose_weight': return 'Perdere Peso';
			case 'profile_setup.goals.gain_muscle': return 'Aumentare Massa';
			case 'profile_setup.goals.endurance': return 'Migliorare Resistenza';
			case 'profile_setup.goals.health': return 'Mantenere Salute';
			case 'profile_setup.genders.male': return 'Uomo';
			case 'profile_setup.genders.female': return 'Donna';
			case 'profile_setup.genders.other': return 'Altro';
			case 'profile.title': return 'Profilo';
			case 'profile.stats_format': return ({required Object age, required Object height, required Object weight}) => '${age} anni • ${height} cm • ${weight} kg';
			case 'profile.dark_mode': return 'Modalità Scura';
			case 'profile.edit_profile': return 'Aggiorna profilo';
			case 'profile.view_leaderboard': return 'Vedi Classifica';
			case 'profile.logout': return 'Esci';
			case 'profile.not_found': return 'Profilo non trovato';
			case 'profile.create_profile': return 'Crea profilo';
			case 'profile.default_user': return 'Atleta';
			case 'add_exercise.title': return 'Aggiungi Esercizio';
			case 'add_exercise.search_hint': return 'Cerca per gruppo muscolare (es: Petto, Schiena)';
			case 'add_exercise.error': return ({required Object error}) => 'Errore: ${error}';
			case 'add_exercise.empty_title': return ({required Object query}) => 'Nessun esercizio trovato per "${query}"';
			case 'add_exercise.empty_subtitle': return 'Prova: Petto, Schiena, Gambe, Bicipiti...';
			case 'add_exercise.added_feedback': return ({required Object name}) => '${name} aggiunto all\'allenamento!';
			case 'workout_create.title': return 'Nuovo Piano';
			case 'workout_create.subtitle': return 'Dai un nome alla tua nuova routine.';
			case 'workout_create.field_label': return 'Nome Allenamento';
			case 'workout_create.field_hint': return 'Es: Allenamento A';
			case 'workout_create.validator_error': return 'Per favore dai un nome all\'allenamento.';
			case 'workout_create.button_create': return 'Crea Allenamento';
			case 'workout_create.suggestions_label': return 'Suggerimenti rapidi:';
			case 'workout_create.success_feedback': return ({required Object name}) => 'Allenamento "${name}" creato!';
			case 'workout_create.error_feedback': return ({required Object error}) => 'Errore creazione: ${error}';
			case 'workout_create.suggestions.full_body': return 'Full Body';
			case 'workout_create.suggestions.upper_body': return 'Upper Body';
			case 'workout_create.suggestions.lower_body': return 'Lower Body';
			case 'workout_create.suggestions.push_day': return 'Push Day';
			case 'workout_create.suggestions.pull_day': return 'Pull Day';
			case 'workout_create.suggestions.leg_day': return 'Leg Day';
			case 'workout_create.suggestions.cardio_abs': return 'Cardio & Addome';
			case 'workout_create.suggestions.yoga_flow': return 'Yoga Flow';
			case 'workout_editor.title': return 'Modifica Allenamento';
			case 'workout_editor.add_button': return 'Aggiungi';
			case 'workout_editor.error': return ({required Object error}) => 'Errore: ${error}';
			case 'workout_editor.not_found': return 'Piano non trovato.';
			case 'workout_editor.empty_text': return 'Questo allenamento è vuoto.';
			case 'workout_editor.add_exercise_button': return 'Aggiungi Esercizio';
			case 'workout_editor.removed_snackbar': return ({required Object name}) => '${name} rimosso';
			case 'workout_editor.remove_dialog.title': return 'Rimuovere esercizio?';
			case 'workout_editor.remove_dialog.content': return ({required Object name}) => 'Vuoi rimuovere ${name}?';
			case 'workout_editor.remove_dialog.confirm': return 'Rimuovi';
			case 'workout.title': return 'Allenamento';
			case 'workout.create_tooltip': return 'Crea nuovo piano';
			case 'workout.empty_state.title': return 'Nessun piano di allenamento trovato.';
			case 'workout.empty_state.button': return 'Crea il mio primo allenamento';
			case 'workout.summary.today': return 'Oggi';
			case 'workout.options.rename': return 'Rinomina Piano';
			case 'workout.options.delete': return 'Elimina Piano';
			case 'workout.dialogs.rename_label': return 'Nome allenamento';
			case 'workout.dialogs.delete_title': return 'Eliminare Piano?';
			case 'workout.dialogs.delete_content': return ({required Object name}) => 'Sei sicuro di voler eliminare "${name}"? Questa azione non può essere annullata.';
			case 'workout.dialogs.delete_confirm': return 'Elimina';
			case 'workout.plan_empty': return 'Questo piano è vuoto.';
			case 'workout.add_exercise_short': return 'Esercizio';
			case 'workout.calendar.months.0': return '';
			case 'workout.calendar.months.1': return 'Gennaio';
			case 'workout.calendar.months.2': return 'Febbraio';
			case 'workout.calendar.months.3': return 'Marzo';
			case 'workout.calendar.months.4': return 'Aprile';
			case 'workout.calendar.months.5': return 'Maggio';
			case 'workout.calendar.months.6': return 'Giugno';
			case 'workout.calendar.months.7': return 'Luglio';
			case 'workout.calendar.months.8': return 'Agosto';
			case 'workout.calendar.months.9': return 'Settembre';
			case 'workout.calendar.months.10': return 'Ottobre';
			case 'workout.calendar.months.11': return 'Novembre';
			case 'workout.calendar.months.12': return 'Dicembre';
			case 'workout.calendar.weekdays.0': return 'D';
			case 'workout.calendar.weekdays.1': return 'L';
			case 'workout.calendar.weekdays.2': return 'M';
			case 'workout.calendar.weekdays.3': return 'M';
			case 'workout.calendar.weekdays.4': return 'G';
			case 'workout.calendar.weekdays.5': return 'V';
			case 'workout.calendar.weekdays.6': return 'S';
			case 'mock.explore.nutrition': return 'Nutrizione';
			case 'mock.explore.training': return 'Allenamento';
			case 'mock.explore.sleep': return 'Sonno';
			case 'mock.explore.mindfulness': return 'Mindfulness';
			case 'mock.explore.tags.macros': return 'macros';
			case 'mock.explore.tags.hydration': return 'idratazione';
			case 'mock.explore.tags.recipes': return 'ricette';
			case 'mock.explore.tags.hypertrophy': return 'ipertrofia';
			case 'mock.explore.tags.strength': return 'forza';
			case 'mock.explore.tags.mobility': return 'mobilità';
			case 'mock.explore.tags.hygiene': return 'igiene';
			case 'mock.explore.tags.cycle': return 'ciclo';
			case 'mock.explore.tags.breathing': return 'respirazione';
			case 'mock.explore.tags.focus': return 'focus';
			case 'mock.stats.calories': return 'Calorie';
			case 'mock.stats.protein': return 'Proteine';
			case 'mock.stats.carbs': return 'Carboidrati';
			case 'mock.stats.fat': return 'Grassi';
			case 'mock.stats.water': return 'Acqua';
			case 'mock.stats.steps': return 'Passi';
			case 'mock.stats.sleep': return 'Sonno';
			default: return null;
		}
	}
}

extension on _StringsZh {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.error': return '加载错误';
			case 'common.error_profile': return '加载个人资料错误';
			case 'common.error_stats': return '加载统计数据错误';
			case 'common.back': return '返回';
			case 'common.cancel': return '取消';
			case 'common.save': return '保存';
			case 'common.not_authenticated': return '用户未验证。';
			case 'common.xp_abbr': return 'XP';
			case 'common.league': return '联赛';
			case 'common.rank_pattern': return ({required Object rank}) => '排名 #${rank}';
			case 'common.empty_list': return '空列表';
			case 'login.tagline': return '您的努力，您的数据，\n您的成果。';
			case 'login.google_button': return '使用 Google 登录';
			case 'login.terms_disclaimer': return '继续即表示您同意我们的条款。';
			case 'dashboard.level_abbr': return '等级';
			case 'dashboard.greeting': return '你好，';
			case 'dashboard.greeting_generic': return '你好！';
			case 'dashboard.subtitle': return '让我们一起实现您的健康目标！';
			case 'dashboard.classification.title': return '⭐ 排名';
			case 'dashboard.classification.remaining_prefix': return '剩余 ';
			case 'dashboard.classification.remaining_suffix': return ' 天';
			case 'dashboard.classification.rank_suffix': return '名';
			case 'dashboard.stats.title': return '统计';
			case 'dashboard.stats.empty': return '编辑以添加统计数据。';
			case 'success.title': return '成功';
			case 'success.default_message': return '一切就绪！您的数据已注册！';
			case 'under_construction.title': return '404';
			case 'under_construction.message': return '此页面仍在建设中！';
			case 'under_construction.subtitle': return '是有氧运动做迷路了吗？';
			case 'edit_stats.title': return '编辑精选';
			case 'edit_stats.instruction': return '最多选择 4 个统计数据进行展示';
			case 'add_food.title': return '添加食物';
			case 'add_food.search_hint': return '搜索例如：“苹果”，“蛋白粉”...';
			case 'add_food.not_found': return '未找到食物';
			case 'add_food.error_api': return 'API 连接错误';
			case 'add_food.instruction': return '输入以在全​​球数据库中搜索';
			case 'add_food.macro_p': return '蛋';
			case 'add_food.macro_c': return '碳';
			case 'add_food.macro_f': return '脂';
			case 'diet.title': return '饮食';
			case 'diet.water.edit_goal_title': return '设定饮水目标';
			case 'diet.water.liters_label': return '升';
			case 'diet.water.edit_stepper_title': return '每次点击量';
			case 'diet.water.ml_label': return '毫升 (ml)';
			case 'diet.water.goal_display': return ({required Object value}) => '目标: ${value} L';
			case 'diet.macros.carbs': return '碳水化合物';
			case 'diet.macros.protein': return '蛋白质';
			case 'diet.macros.fat': return '脂肪';
			case 'diet.meal.more_items': return ({required Object count}) => '+ ${count} 其他项目';
			case 'diet.meal.total_calories': return ({required Object calories}) => '总计: ${calories} 千卡';
			case 'diet.meal.empty': return '未记录食物';
			case 'diet.meal.not_found': return '未找到餐点';
			case 'diet.meal_types.breakfast': return '早餐';
			case 'diet.meal_types.morning_snack': return '早间加餐';
			case 'diet.meal_types.lunch': return '午餐';
			case 'diet.meal_types.afternoon_snack': return '下午加餐';
			case 'diet.meal_types.dinner': return '晚餐';
			case 'diet.meal_types.supper': return '夜宵';
			case 'diet.meal_types.pre_workout': return '训练前';
			case 'diet.meal_types.post_workout': return '训练后';
			case 'diet.meal_types.snack': return '零食';
			case 'meal_detail.title': return '餐点详情';
			case 'meal_detail.macro_summary': return ({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} 千卡 • 蛋 ${protein}g • 碳 ${carbs}g • 脂 ${fat}g';
			case 'meal_detail.item_details': return ({required Object calories, required Object protein, required Object carbs, required Object fat}) => '${calories} 千卡 - 蛋 ${protein}g 碳 ${carbs}g 脂 ${fat}g';
			case 'explore.title': return '探索';
			case 'explore.search_hint': return '搜索功能';
			case 'explore.not_found': return '未找到功能。';
			case 'explore.categories.activity': return '活动';
			case 'explore.categories.nutrition': return '营养';
			case 'explore.categories.sleep': return '睡眠';
			case 'explore.categories.medication': return '药物';
			case 'explore.categories.body_measurements': return '身体测量';
			case 'explore.categories.mobility': return '灵活性';
			case 'leaderboard.title': return '排行榜';
			case 'leaderboard.error': return '加载排行榜错误';
			case 'leaderboard.zones.promotion': return '晋级区';
			case 'leaderboard.zones.demotion': return '降级区';
			case 'leaderboard.entry.level': return ({required Object level}) => '等级 ${level}';
			case 'leaderboard.entry.xp': return ({required Object value}) => '${value} XP';
			case 'leaderboard.leagues.wood': return '木头';
			case 'leaderboard.leagues.iron': return '铁';
			case 'leaderboard.leagues.bronze': return '青铜';
			case 'leaderboard.leagues.silver': return '白银';
			case 'leaderboard.leagues.gold': return '黄金';
			case 'leaderboard.leagues.platinum': return '白金';
			case 'leaderboard.leagues.diamond': return '钻石';
			case 'leaderboard.leagues.obsidian': return '黑曜石';
			case 'leaderboard.leagues.master': return '大师';
			case 'leaderboard.leagues.stellar': return '星耀';
			case 'leaderboard.leagues.legend': return '传奇';
			case 'profile_setup.title_edit': return '编辑资料';
			case 'profile_setup.title_create': return '创建资料';
			case 'profile_setup.welcome': return '欢迎！';
			case 'profile_setup.subtitle': return '让我们设置您的个人资料以个性化您的旅程。';
			case 'profile_setup.sections.about': return '关于您';
			case 'profile_setup.sections.measures': return '测量';
			case 'profile_setup.sections.goal': return '主要目标';
			case 'profile_setup.fields.name': return '全名';
			case 'profile_setup.fields.name_error': return '请输入您的名字';
			case 'profile_setup.fields.dob': return '出生日期';
			case 'profile_setup.fields.gender': return '性别';
			case 'profile_setup.fields.height': return '身高 (cm)';
			case 'profile_setup.fields.weight': return '体重 (kg)';
			case 'profile_setup.fields.goal_select': return '选择您的目标';
			case 'profile_setup.fields.required_error': return '必填';
			case 'profile_setup.actions.save': return '保存更改';
			case 'profile_setup.actions.finish': return '完成注册';
			case 'profile_setup.feedback.fill_all': return '请填写所有字段。';
			case 'profile_setup.feedback.success': return '个人资料保存成功！';
			case 'profile_setup.feedback.error': return ({required Object error}) => '保存错误: ${error}';
			case 'profile_setup.goals.lose_weight': return '减肥';
			case 'profile_setup.goals.gain_muscle': return '增肌';
			case 'profile_setup.goals.endurance': return '提高耐力';
			case 'profile_setup.goals.health': return '保持健康';
			case 'profile_setup.genders.male': return '男';
			case 'profile_setup.genders.female': return '女';
			case 'profile_setup.genders.other': return '其他';
			case 'profile.title': return '个人资料';
			case 'profile.stats_format': return ({required Object age, required Object height, required Object weight}) => '${age} 岁 • ${height} cm • ${weight} kg';
			case 'profile.dark_mode': return '深色模式';
			case 'profile.edit_profile': return '更新资料';
			case 'profile.view_leaderboard': return '查看排行榜';
			case 'profile.logout': return '退出 (Logout)';
			case 'profile.not_found': return '未找到个人资料';
			case 'profile.create_profile': return '创建资料';
			case 'profile.default_user': return '运动员';
			case 'add_exercise.title': return '添加运动';
			case 'add_exercise.search_hint': return '按肌肉群搜索 (如: 胸部, 背部)';
			case 'add_exercise.error': return ({required Object error}) => '错误: ${error}';
			case 'add_exercise.empty_title': return ({required Object query}) => '未找到关于 "${query}" 的运动';
			case 'add_exercise.empty_subtitle': return '尝试: 胸部, 背部, 腿部, 二头肌...';
			case 'add_exercise.added_feedback': return ({required Object name}) => '${name} 已添加到训练中！';
			case 'workout_create.title': return '新计划';
			case 'workout_create.subtitle': return '为您的新训练计划命名。';
			case 'workout_create.field_label': return '训练名称';
			case 'workout_create.field_hint': return '例如: 训练 A';
			case 'workout_create.validator_error': return '请给训练命名。';
			case 'workout_create.button_create': return '创建计划';
			case 'workout_create.suggestions_label': return '快速建议:';
			case 'workout_create.success_feedback': return ({required Object name}) => '训练 "${name}" 已创建！';
			case 'workout_create.error_feedback': return ({required Object error}) => '创建错误: ${error}';
			case 'workout_create.suggestions.full_body': return '全身';
			case 'workout_create.suggestions.upper_body': return '上半身';
			case 'workout_create.suggestions.lower_body': return '下半身';
			case 'workout_create.suggestions.push_day': return '推力日 (Push)';
			case 'workout_create.suggestions.pull_day': return '拉力日 (Pull)';
			case 'workout_create.suggestions.leg_day': return '腿部日';
			case 'workout_create.suggestions.cardio_abs': return '有氧 & 腹肌';
			case 'workout_create.suggestions.yoga_flow': return '瑜伽流';
			case 'workout_editor.title': return '编辑训练';
			case 'workout_editor.add_button': return '添加';
			case 'workout_editor.error': return ({required Object error}) => '错误: ${error}';
			case 'workout_editor.not_found': return '未找到计划。';
			case 'workout_editor.empty_text': return '此训练为空。';
			case 'workout_editor.add_exercise_button': return '添加运动';
			case 'workout_editor.removed_snackbar': return ({required Object name}) => '${name} 已移除';
			case 'workout_editor.remove_dialog.title': return '移除运动？';
			case 'workout_editor.remove_dialog.content': return ({required Object name}) => '您确定要移除 ${name} 吗？';
			case 'workout_editor.remove_dialog.confirm': return '移除';
			case 'workout.title': return '训练';
			case 'workout.create_tooltip': return '创建新计划';
			case 'workout.empty_state.title': return '未找到训练计划。';
			case 'workout.empty_state.button': return '创建我的第一个训练';
			case 'workout.summary.today': return '今天';
			case 'workout.options.rename': return '重命名计划';
			case 'workout.options.delete': return '删除计划';
			case 'workout.dialogs.rename_label': return '训练名称';
			case 'workout.dialogs.delete_title': return '删除计划？';
			case 'workout.dialogs.delete_content': return ({required Object name}) => '您确定要删除 "${name}" 吗？此操作无法撤销。';
			case 'workout.dialogs.delete_confirm': return '删除';
			case 'workout.plan_empty': return '此计划为空。';
			case 'workout.add_exercise_short': return '运动';
			case 'workout.calendar.months.0': return '';
			case 'workout.calendar.months.1': return '一月';
			case 'workout.calendar.months.2': return '二月';
			case 'workout.calendar.months.3': return '三月';
			case 'workout.calendar.months.4': return '四月';
			case 'workout.calendar.months.5': return '五月';
			case 'workout.calendar.months.6': return '六月';
			case 'workout.calendar.months.7': return '七月';
			case 'workout.calendar.months.8': return '八月';
			case 'workout.calendar.months.9': return '九月';
			case 'workout.calendar.months.10': return '十月';
			case 'workout.calendar.months.11': return '十一月';
			case 'workout.calendar.months.12': return '十二月';
			case 'workout.calendar.weekdays.0': return '日';
			case 'workout.calendar.weekdays.1': return '一';
			case 'workout.calendar.weekdays.2': return '二';
			case 'workout.calendar.weekdays.3': return '三';
			case 'workout.calendar.weekdays.4': return '四';
			case 'workout.calendar.weekdays.5': return '五';
			case 'workout.calendar.weekdays.6': return '六';
			case 'mock.explore.nutrition': return '营养';
			case 'mock.explore.training': return '训练';
			case 'mock.explore.sleep': return '睡眠';
			case 'mock.explore.mindfulness': return '正念';
			case 'mock.explore.tags.macros': return '宏量营养素';
			case 'mock.explore.tags.hydration': return '补水';
			case 'mock.explore.tags.recipes': return '食谱';
			case 'mock.explore.tags.hypertrophy': return '肥大';
			case 'mock.explore.tags.strength': return '力量';
			case 'mock.explore.tags.mobility': return '灵活性';
			case 'mock.explore.tags.hygiene': return '卫生';
			case 'mock.explore.tags.cycle': return '周期';
			case 'mock.explore.tags.breathing': return '呼吸';
			case 'mock.explore.tags.focus': return '专注';
			case 'mock.stats.calories': return '卡路里';
			case 'mock.stats.protein': return '蛋白质';
			case 'mock.stats.carbs': return '碳水';
			case 'mock.stats.fat': return '脂肪';
			case 'mock.stats.water': return '水';
			case 'mock.stats.steps': return '步数';
			case 'mock.stats.sleep': return '睡眠';
			default: return null;
		}
	}
}
