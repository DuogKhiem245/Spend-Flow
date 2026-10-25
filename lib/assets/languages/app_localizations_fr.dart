// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get app_name => 'SpendFlow';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuler';

  @override
  String get skip => 'Passer';

  @override
  String get next => 'Suivant';

  @override
  String get confirm => 'Confirmer';

  @override
  String get save => 'Enregistrer';

  @override
  String get edit => 'Modifier';

  @override
  String get delete => 'Supprimer';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get done => 'Terminé';

  @override
  String get close => 'Fermer';

  @override
  String get back => 'Retour';

  @override
  String get start => 'Commencer';

  @override
  String get continueAction => 'Continuer';

  @override
  String get view_all => 'Voir tout';

  @override
  String get see_all => 'Voir tout';

  @override
  String get amount => 'Montant';

  @override
  String get name => 'Nom';

  @override
  String get date => 'Date';

  @override
  String get month => 'Mois';

  @override
  String get life_time => 'À vie';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get other => 'Autre';

  @override
  String get home => 'Accueil';

  @override
  String get reports => 'Rapports';

  @override
  String get budgets => 'Budgets';

  @override
  String get all => 'Tout';

  @override
  String get error => 'Erreur';

  @override
  String get user => 'Utilisateur';

  @override
  String get success => 'Succès';

  @override
  String get loading => 'Chargement...';

  @override
  String get onboard_step1_title => 'Enregistrez en un clin d\'œil';

  @override
  String get onboard_step1_message =>
      'Détectez automatiquement les lieux de dépenses pour une saisie plus rapide. Ne vous demandez plus où est passé votre argent.';

  @override
  String get onboard_step2_title => 'Maîtrisez votre portefeuille';

  @override
  String get onboard_step2_message =>
      'Définissez des limites de dépenses pour chaque catégorie. Nous vous aiderons à atteindre vos objectifs financiers.';

  @override
  String get onboard_step3_title => 'Adoptez de bonnes habitudes';

  @override
  String get onboard_step3_message =>
      'Recevez des rappels quotidiens pour ne jamais manquer une transaction. La régularité est la clé de la liberté financière.';

  @override
  String get create_first_wallet => 'Créez votre premier portefeuille';

  @override
  String get welcome_create_wallet =>
      'Bienvenue sur Spend Flow !\nCréons votre premier portefeuille pour commencer.';

  @override
  String get enter_wallet_name => 'Entrez le nom du portefeuille';

  @override
  String get eg_my_wallet => 'ex. : Mon portefeuille, Espèces, Carte bancaire';

  @override
  String get currency_unit => 'Unité monétaire';

  @override
  String get create_wallet => 'Créer le portefeuille';

  @override
  String get please_enter_wallet_name =>
      'Veuillez entrer le nom du portefeuille.';

  @override
  String get add_wallet => 'Ajouter un nouveau portefeuille';

  @override
  String get wallet_name => 'Nom du portefeuille';

  @override
  String get add_wallet_description =>
      'Ajoutez d\'autres portefeuilles pour gérer et suivre vos finances plus efficacement.';

  @override
  String get cannot_delete_last_wallet =>
      'Vous ne pouvez pas supprimer le dernier portefeuille.';

  @override
  String get delete_wallet => 'Supprimer le portefeuille';

  @override
  String delete_wallet_confirmation(String walletName) {
    return 'Êtes-vous sûr de vouloir supprimer le portefeuille \'$walletName\' ? Cette action est irréversible.';
  }

  @override
  String get in_use => 'En cours d\'utilisation';

  @override
  String get incomplete_details => 'Détails incomplets';

  @override
  String get please_fill_required_fields =>
      'Veuillez remplir les champs obligatoires suivants pour continuer :';

  @override
  String get select_wallet => 'Sélectionner un portefeuille';

  @override
  String get please_create_wallet_first =>
      'Vous devez créer un portefeuille avant d\'ajouter une transaction.';

  @override
  String get create_now => 'Créer maintenant';

  @override
  String get no_wallets_yet => 'Aucun portefeuille pour le moment';

  @override
  String get login => 'Connexion';

  @override
  String get register => 'Inscription';

  @override
  String get logout => 'Déconnexion';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get new_password => 'Nouveau mot de passe';

  @override
  String get enter_email => 'Entrez votre e-mail';

  @override
  String get enter_your_password => 'Entrez votre mot de passe';

  @override
  String get confirm_password => 'Confirmer le mot de passe';

  @override
  String get confirm_your_password => 'Confirmez votre mot de passe';

  @override
  String get passwords_match => 'Les mots de passe correspondent.';

  @override
  String get passwords_mismatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get forgot_password => 'Mot de passe oublié ?';

  @override
  String get description_forgot_password =>
      'Entrez l\'e-mail associé à votre compte pour réinitialiser votre mot de passe.';

  @override
  String get send_otp => 'Envoyer le code OTP';

  @override
  String get enter_otp => 'Entrez le code OTP';

  @override
  String get resend => 'Renvoyer';

  @override
  String get verify => 'Vérifier';

  @override
  String get no_otp => 'Vous n\'avez pas reçu le code ?';

  @override
  String get verify_otp => 'Vérifier l\'OTP';

  @override
  String get we_sent_otp =>
      'Veuillez vérifier vos e-mails pour obtenir le code OTP. Pensez à vérifier vos courriers indésirables (Spam).';

  @override
  String get dont_receive_otp => 'Vous n\'avez pas reçu l\'OTP ?';

  @override
  String get plese_enter_valid_otp => 'Veuillez entrer un code OTP valide.';

  @override
  String get otp_resent => 'Code OTP renvoyé avec succès.';

  @override
  String get register_successful => 'Inscription réussie !';

  @override
  String get register_successful_description =>
      'Votre compte a été créé avec succès. Vous pouvez maintenant vous connecter.';

  @override
  String get no_account => 'Vous n\'avez pas de compte ?';

  @override
  String get have_account => 'Vous avez déjà un compte ?';

  @override
  String get login_error => 'E-mail ou mot de passe invalide';

  @override
  String get register_error => 'Échec de l\'inscription';

  @override
  String get create_account => 'Créer un compte';

  @override
  String get create_password => 'Créer un nouveau mot de passe';

  @override
  String get create_new_password =>
      'Presque terminé ! Créez votre nouveau mot de passe.';

  @override
  String get or_continue_with => 'Ou continuer avec';

  @override
  String sign_in_with(String provider) {
    return 'Se connecter avec $provider';
  }

  @override
  String get check_your_mail => 'Vérifiez votre boîte mail';

  @override
  String get we_have_sent_mail => 'Nous avons envoyé un e-mail à :';

  @override
  String get please_check_your_mail_to_verify_account =>
      'Veuillez vérifier votre e-mail pour activer votre compte avant de vous connecter.';

  @override
  String get register_failed => 'Échec de l\'inscription';

  @override
  String get please_fill_all_fields => 'Veuillez remplir tous les champs.';

  @override
  String get please_enter_email_and_password =>
      'Veuillez entrer l\'e-mail et le mot de passe.';

  @override
  String get incorrect_email_or_password => 'E-mail ou mot de passe incorrect.';

  @override
  String get invalid_email_format => 'Format d\'e-mail invalide.';

  @override
  String get this_account_has_been_disabled => 'Ce compte a été désactivé.';

  @override
  String get too_many_requests_please_try_later =>
      'Trop de requêtes. Veuillez réessayer plus tard.';

  @override
  String get email_not_verified => 'E-mail non vérifié';

  @override
  String get please_verify_your_email_to_continue =>
      'Veuillez vérifier votre e-mail pour continuer.';

  @override
  String get are_you_sure_logout =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get have_error_occurred =>
      'Une erreur est survenue. Veuillez réessayer.';

  @override
  String get user_not_found => 'Aucun compte trouvé avec cet e-mail.';

  @override
  String get enter_otp_reset_password =>
      'Nous avons envoyé un code OTP à votre e-mail. Veuillez le saisir pour réinitialiser votre mot de passe.';

  @override
  String get not_time_yet_to_resend_otp =>
      'Veuillez patienter un instant avant de renvoyer le code OTP.';

  @override
  String get reset_password_successful =>
      'Réinitialisation du mot de passe réussie';

  @override
  String get reset_password_successful_description =>
      'Votre mot de passe a été réinitialisé avec succès. Vous pouvez maintenant vous connecter avec votre nouveau mot de passe.';

  @override
  String get welcome_back => 'Bon retour parmi nous';

  @override
  String get back_login => 'Retour à la connexion';

  @override
  String get description_create_account =>
      'Prenez le contrôle de vos finances dès aujourd\'hui';

  @override
  String get label_weak => 'Faible';

  @override
  String get label_fair => 'Moyen';

  @override
  String get label_good => 'Bon';

  @override
  String get label_strong => 'Fort';

  @override
  String get low_pass =>
      'Doit comporter au moins 8 caractères, un chiffre et un symbole.';

  @override
  String get weak_pass => 'Trop court. Veuillez ajouter plus de caractères.';

  @override
  String get fair_pass =>
      'Mieux. Essayez d\'ajouter des chiffres et des symboles !';

  @override
  String get good_pass_char =>
      'Presque ! Ajoutez un caractère spécial pour le renforcer.';

  @override
  String get good_pass_num => 'Presque ! Ajoutez un chiffre pour le renforcer.';

  @override
  String get good_pass_special =>
      'Presque ! Ajoutez un caractère supplémentaire pour le renforcer.';

  @override
  String get strong_pass => 'Excellent ! Votre mot de passe est sécurisé.';

  @override
  String get password_reset_email_sent =>
      'Nous avons envoyé un lien de réinitialisation de mot de passe à votre e-mail.';

  @override
  String get forgot_password_description =>
      'Entrez l\'e-mail associé à votre compte pour réinitialiser votre mot de passe.';

  @override
  String get send_email_reset => 'Envoyer l\'e-mail de réinitialisation';

  @override
  String get password_weak_password =>
      'Le mot de passe fourni est trop faible.';

  @override
  String get please_edit_fields =>
      'Veuillez modifier les champs suivants pour continuer :';

  @override
  String get something_went_wrong =>
      'Un problème est survenu. Veuillez réessayer.';

  @override
  String get email_already_in_use =>
      'Cette adresse e-mail est déjà utilisée par un autre compte.';

  @override
  String get invalid_email => 'L\'adresse e-mail n\'est pas valide.';

  @override
  String get operation_not_allowed =>
      'Opération non autorisée. Veuillez contacter l\'assistance.';

  @override
  String get network_error =>
      'Erreur réseau. Veuillez vérifier votre connexion et réessayer.';

  @override
  String get reset_password => 'Réinitialiser le mot de passe';

  @override
  String get email_not_received => 'E-mail non reçu ?';

  @override
  String get verification_email_sent => 'E-mail de vérification envoyé';

  @override
  String get good_morning => 'Bonjour';

  @override
  String get good_afternoon => 'Bon après-midi';

  @override
  String get good_evening => 'Bonsoir';

  @override
  String get hello => 'Bonjour';

  @override
  String get income => 'Revenu';

  @override
  String get expenses => 'Dépenses';

  @override
  String get balance => 'Solde';

  @override
  String get total_balance => 'Solde total';

  @override
  String get spending_this_month => 'Dépenses ce mois-ci';

  @override
  String get total_spent => 'Total dépensé';

  @override
  String get recent_transactions => 'Transactions récentes';

  @override
  String get add_transaction => 'Ajouter une transaction';

  @override
  String get no_transactions => 'Aucune donnée disponible';

  @override
  String get enter_transaction_name => 'Entrez le nom de la transaction';

  @override
  String get suggested_category => 'Catégorie suggérée';

  @override
  String get category => 'Catégorie';

  @override
  String get categories => 'Catégories';

  @override
  String get select_category => 'Sélectionner une catégorie';

  @override
  String get edit_category => 'Modifier la catégorie';

  @override
  String are_you_sure_delete_category(String categoryName) {
    return 'Êtes-vous sûr de vouloir supprimer $categoryName ?';
  }

  @override
  String get system_category =>
      'Les catégories système ne peuvent pas être supprimées.';

  @override
  String get system_category_description =>
      'Vous ne pouvez ni modifier ni supprimer cette catégorie par défaut.';

  @override
  String get category_food => 'Alimentation';

  @override
  String get category_transport => 'Transport';

  @override
  String get category_salary => 'Salaire';

  @override
  String get category_shopping => 'Achats';

  @override
  String get category_game => 'Jeux';

  @override
  String get category_house => 'Logement';

  @override
  String get category_gift => 'Cadeaux';

  @override
  String get category_health => 'Santé';

  @override
  String get category_entertainment => 'Divertissement';

  @override
  String get category_bill => 'Factures';

  @override
  String get category_insurance => 'Assurance';

  @override
  String get category_education => 'Éducation';

  @override
  String get category_pet => 'Animaux';

  @override
  String get category_travel => 'Voyages';

  @override
  String get category_savings => 'Épargne';

  @override
  String get category_phone => 'Téléphone';

  @override
  String get category_internet => 'Internet';

  @override
  String get category_water => 'Eau';

  @override
  String get category_electricity => 'Électricité';

  @override
  String get category_gas => 'Gaz';

  @override
  String get category_cleaning => 'Ménage';

  @override
  String get category_beauty => 'Beauté';

  @override
  String get category_baby => 'Bébé';

  @override
  String get category_sport => 'Sport';

  @override
  String get category_music => 'Musique';

  @override
  String get category_repair => 'Réparations';

  @override
  String get category_tax => 'Impôts';

  @override
  String get note => 'Note (facultatif)';

  @override
  String get enter_note => 'Entrez une note';

  @override
  String get add_income => 'Ajouter un revenu';

  @override
  String get add_expense => 'Ajouter une dépense';

  @override
  String get search_category => 'Rechercher une catégorie';

  @override
  String get no_category_found => 'Aucune catégorie trouvée';

  @override
  String get most_used => 'Les plus utilisées';

  @override
  String get category_suggestions => 'Suggestions de catégories';

  @override
  String get all_categories => 'Toutes les catégories';

  @override
  String get new_category => 'Nouvelle catégorie';

  @override
  String get category_name => 'Nom de la catégorie';

  @override
  String get category_color => 'Couleur de la catégorie';

  @override
  String get category_icon => 'Icône de la catégorie';

  @override
  String get vs_last_month => 'par rapport au mois dernier';

  @override
  String get transaction => 'Transaction';

  @override
  String get delete_transaction => 'Supprimer la transaction';

  @override
  String get delete_transaction_confirmation =>
      'Êtes-vous sûr de vouloir supprimer cette transaction ?';

  @override
  String get transaction_details => 'Détails de la transaction';

  @override
  String get spending_trend => 'Tendance des dépenses';

  @override
  String get spending_last_7_days => 'Dépenses des 7 derniers jours';

  @override
  String get note_2 => 'Note';

  @override
  String get scan_receipt => 'Scanner un reçu';

  @override
  String get add_via_voice => 'Ajouter par la voix';

  @override
  String get add_manually => 'Ajouter manuellement';

  @override
  String get limit_reached => 'Limite atteinte';

  @override
  String limit_reached_description(String featureName, String limit) {
    return 'Vous avez utilisé $featureName $limit fois aujourd\'hui.\nVeuillez revenir demain ou passer à Premium.';
  }

  @override
  String get align_receipt => 'Alignez votre reçu';

  @override
  String get listening => 'Écoute en cours...';

  @override
  String get voice_example => 'ex. : J\'ai dépensé 50 euros pour les courses';

  @override
  String get tap_to_stop => 'Appuyez pour arrêter';

  @override
  String get tap_to_listen => 'Appuyez pour écouter';

  @override
  String get yesterday => 'Hier';

  @override
  String get your_monthly_budget => 'Votre budget mensuel';

  @override
  String get spent => 'Dépensé ';

  @override
  String get out_of => ' sur ';

  @override
  String get left_to_spend => 'restant à dépenser';

  @override
  String get add_budget => 'Ajouter un budget';

  @override
  String get no_budgets_yet => 'Aucun budget pour le moment';

  @override
  String get create_budget_description =>
      'Appuyez sur + pour créer une limite de dépenses';

  @override
  String get edit_budget => 'Modifier le budget';

  @override
  String are_you_sure_delete_budget(String budgetName) {
    return 'Êtes-vous sûr de vouloir supprimer \n $budgetName ?';
  }

  @override
  String get delete_budget => 'Supprimer le budget';

  @override
  String get settings => 'Paramètres';

  @override
  String get settings_description =>
      'Gardez vos données financières synchronisées sur tous vos appareils';

  @override
  String get sign_in_now => 'Se connecter maintenant';

  @override
  String get get_started => 'Commencer';

  @override
  String get welcome => 'Bienvenue !';

  @override
  String get general => 'Général';

  @override
  String get security => 'Sécurité';

  @override
  String get privacy_and_security => 'Confidentialité & Sécurité';

  @override
  String get support => 'Assistance';

  @override
  String get profile => 'Profil';

  @override
  String get language => 'Langue';

  @override
  String get dark_mode => 'Mode sombre';

  @override
  String get notifications => 'Notifications';

  @override
  String get appearance => 'Apparence';

  @override
  String get currency => 'Devise';

  @override
  String get about => 'À propos';

  @override
  String get terms_of_service => 'Conditions d\'utilisation';

  @override
  String get privacy_policy => 'Politique de confidentialité';

  @override
  String get version => 'Version';

  @override
  String get edit_profile => 'Modifier le profil';

  @override
  String get full_name => 'Nom complet';

  @override
  String get enter_full_name => 'Entrez votre nom complet';

  @override
  String get email_address => 'Adresse e-mail';

  @override
  String get enter_email_address => 'Entrez votre adresse e-mail';

  @override
  String get phone_number => 'Numéro de téléphone';

  @override
  String get enter_phone_number => 'Entrez votre numéro de téléphone';

  @override
  String get day_of_birth => 'Date de naissance';

  @override
  String get select_day_of_birth => 'Sélectionner la date de naissance';

  @override
  String get save_changes => 'Enregistrer les modifications';

  @override
  String get profile_updated_success => 'Profil mis à jour avec succès !';

  @override
  String get error_updating_profile =>
      'Erreur lors de la mise à jour du profil.';

  @override
  String get error_uploading_avatar =>
      'Erreur lors du téléchargement de l\'avatar.';

  @override
  String get require_premium_to_edit_avatar =>
      'Passez à Premium ou regardez une publicité pour modifier votre avatar.';

  @override
  String get edit_avatar => 'Modifier l\'avatar';

  @override
  String get upgrade_premium => 'Passer à Premium !';

  @override
  String get upgrade_premium_description =>
      'Débloquez des fonctionnalités exclusives et améliorez votre expérience.';

  @override
  String get upgrade_now => 'Passer à Premium';

  @override
  String get you_are_premium => 'Vous êtes membre Premium !';

  @override
  String get you_are_premium_description =>
      'Profitez de votre expérience améliorée.';

  @override
  String get import_export_data => 'Importer / Exporter des données';

  @override
  String get sync_data => 'Synchroniser les données';

  @override
  String continue_with(String price) {
    return 'Continuer avec $price';
  }

  @override
  String get biometric_authentication => 'Authentification biométrique';

  @override
  String get password_security => 'Sécurité du mot de passe';

  @override
  String get face_id_description =>
      'Déverrouillez votre application d\'un regard. Face ID offre un accès pratique et sécurisé.';

  @override
  String get touch_id_description =>
      'Déverrouillez votre application d\'un simple toucher grâce à votre empreinte digitale.';

  @override
  String get pass_code_description =>
      'Ajoutez une couche de protection. Un code garantit que vous seul pouvez accéder à vos données.';

  @override
  String get passcode => 'Code d\'accès';

  @override
  String get change_passcode => 'Changer le code d\'accès';

  @override
  String get old_passcode => 'Ancien code d\'accès';

  @override
  String get enter_old_passcode => 'Entrez l\'ancien code d\'accès';

  @override
  String get new_passcode => 'Nouveau code d\'accès';

  @override
  String get enter_new_passcode => 'Entrez le nouveau code d\'accès';

  @override
  String get confirm_new_passcode => 'Confirmer le nouveau code d\'accès';

  @override
  String get enter_confirm_new_passcode => 'Entrez la confirmation du code';

  @override
  String get turnOffPasscode => 'Désactiver le code d\'accès';

  @override
  String get createPasscode => 'Créer un code d\'accès';

  @override
  String get changePasscode => 'Modifier le code d\'accès';

  @override
  String get removePasscode => 'Supprimer le code d\'accès';

  @override
  String get updatePasscode => 'Mettre à jour le code d\'accès';

  @override
  String get description_create_passcode =>
      'Protégez votre compte en mettant régulièrement à jour votre code à 6 chiffres.';

  @override
  String get description_remove_passcode =>
      'Entrez votre code d\'accès actuel pour désactiver la sécurité.';

  @override
  String get currentPasscode => 'Code d\'accès actuel';

  @override
  String get enterCurrentPin => 'Entrez votre code PIN actuel';

  @override
  String get passcode_turn_off_success =>
      'Code d\'accès désactivé avec succès !';

  @override
  String get passcode_update_success =>
      'Code d\'accès mis à jour avec succès !';

  @override
  String get passcode_create_success => 'Code d\'accès créé avec succès !';

  @override
  String get currentPasscodeIncorrect =>
      'Le code d\'accès actuel est incorrect.';

  @override
  String get errorSavingData => 'Erreur lors de l\'enregistrement des données.';

  @override
  String get newPasscodeMustBe6Digits =>
      'Le nouveau code d\'accès doit comporter 6 chiffres.';

  @override
  String get passcodesDoNotMatch => 'Les codes d\'accès ne correspondent pas.';

  @override
  String get enter_passcode => 'Entrez le code d\'accès';

  @override
  String get incorrect_passcode => 'Code d\'accès incorrect.';

  @override
  String get face => 'Face ID';

  @override
  String get fingerprint => 'Empreinte digitale';

  @override
  String get report_locked => 'Contenu verrouillé';

  @override
  String get unlock => 'Déverrouiller';

  @override
  String get click_to_unlock => 'Cliquer pour déverrouiller';

  @override
  String get unlock_untilimited_access => 'Débloquer l\'accès illimité';

  @override
  String get unlock_untilimited_access_description =>
      'Passez à Premium pour supprimer toutes les limites et accéder aux fonctionnalités avancées.';

  @override
  String get daily_input_cap_reached => 'Limite quotidienne atteinte';

  @override
  String get daily_input_cap_reached_description =>
      'Vous avez atteint votre limite quotidienne de scans et de saisies vocales. Mettez à niveau pour continuer.';

  @override
  String get feature_comparison => 'Comparaison des fonctionnalités';

  @override
  String get feature => 'Fonctionnalité';

  @override
  String get free => 'Gratuit';

  @override
  String get premium => 'Premium';

  @override
  String get no_ads => 'Sans publicité';

  @override
  String get transaction_locking => 'Verrouillage des transactions';

  @override
  String get unlimited_scans => 'Scans de reçus illimités';

  @override
  String get unlimited_voice_entries => 'Saisies vocales illimitées';

  @override
  String get day => 'jour';

  @override
  String get year => 'an';

  @override
  String get subscription_auto_renews =>
      'L\'abonnement se renouvelle automatiquement.';

  @override
  String get accept_terms_conditions =>
      'L\'abonnement se renouvelle automatiquement. En continuant, vous acceptez nos Conditions d\'utilisation et notre Politique de confidentialité.';

  @override
  String get restore => 'Restaurer';

  @override
  String used_up_daily_limit(String value) {
    return 'Vous avez épuisé votre limite de saisie vocale pour aujourd\'hui. Regardez une pub pour obtenir $value utilisations ou passez à Premium.';
  }

  @override
  String get monthly_plan => 'Forfait mensuel';

  @override
  String get yearly_plan => 'Forfait annuel';

  @override
  String get lifetime_plan => 'Forfait à vie';

  @override
  String get pay_once_enjoy_forever => 'Payez une fois, profitez pour toujours';

  @override
  String get yearly_discount => 'Économisez 20 % avec le forfait annuel';

  @override
  String get best_value => 'MEILLEURE OFFRE';

  @override
  String get transaction_cancelled => 'Transaction annulée.';

  @override
  String get purchase_successful => 'Achat réussi !';

  @override
  String get purchase_successful_description =>
      'Merci d\'être passé à Premium ! Profitez de votre expérience améliorée.';

  @override
  String get restore_successful => 'Restauration réussie !';

  @override
  String get restore_successful_description =>
      'Vos achats précédents ont été restaurés. Profitez de vos fonctionnalités Premium !';

  @override
  String get nothing_to_restore => 'Rien à restaurer';

  @override
  String get nothing_to_restore_description =>
      'Aucun achat précédent n\'a été trouvé.';

  @override
  String get restore_failed => 'Échec de la restauration';

  @override
  String get restore_failed_description =>
      'Une erreur est survenue lors de la restauration. Veuillez réessayer.';

  @override
  String get purchase_failed => 'Échec de l\'achat';

  @override
  String get purchase_failed_description =>
      'Une erreur est survenue lors de la transaction. Veuillez réessayer.';

  @override
  String get purchase_canceled => 'Achat annulé';

  @override
  String get purchase_canceled_description =>
      'La transaction a été annulée. Aucun changement n\'a été apporté à votre compte.';

  @override
  String get premium_sync_account =>
      'Votre compte Premium sera synchronisé avec le compte auquel vous vous connectez. Connectez-vous avec le même compte sur tous vos appareils.';

  @override
  String get premium_sync_warning =>
      'Remarque : Si vous avez acheté Premium sur un autre compte, veuillez vous y connecter pour restaurer l\'accès. Si vous utilisez le même compte, restaurez vos achats.';

  @override
  String get select_language => 'Sélectionner la langue';

  @override
  String get suggested => 'Suggéré';

  @override
  String get all_languages => 'Toutes les langues';

  @override
  String get apply_changes => 'Appliquer les modifications';

  @override
  String get select_currency => 'Sélectionner la devise';

  @override
  String get search_currency => 'Rechercher une devise ou un pays...';

  @override
  String get popular => 'Populaire';

  @override
  String get all_currencies => 'Toutes les devises';

  @override
  String get currency_change_warning =>
      'Changer de devise ne fera que mettre à jour le symbole affiché. Les taux des transactions passées ne seront pas recalculés.';

  @override
  String see_ads(String additionalUses) {
    return 'Regarder des pubs (+$additionalUses utilisations)';
  }

  @override
  String get ads_loading => 'Chargement de la pub...';

  @override
  String get data_management => 'Gestion des données';

  @override
  String get select_format => 'Sélectionner le format';

  @override
  String get export_data => 'Exporter les données';

  @override
  String get export_data_description =>
      'Exportez vos données financières pour sauvegarde ou analyse.';

  @override
  String get confirm_export => 'Confirmer l\'exportation';

  @override
  String get import_data => 'Importer des données';

  @override
  String get import_data_title => 'Importons vos \n';

  @override
  String get data => 'données';

  @override
  String get import_data_title_2 => ' ici.';

  @override
  String get import_data_description =>
      'Importez des données financières depuis des sources externes pour les synchroniser avec l\'application.';

  @override
  String get confirm_import => 'Confirmer l\'importation';

  @override
  String get csv_format => 'Format CSV';

  @override
  String get csv_description =>
      'Exporter les données au format CSV, compatible avec la plupart des tableurs.';

  @override
  String get json_format => 'Format JSON';

  @override
  String get json_description =>
      'Exporter les données au format JSON, adapté aux développeurs et utilisateurs avancés.';

  @override
  String get excel_format => 'Format Excel';

  @override
  String get excel_description =>
      'Exporter les données au format Excel, idéal pour une analyse financière détaillée.';

  @override
  String get select_file => 'Sélectionner un fichier';

  @override
  String get no_file_selected => 'Aucun fichier sélectionné.';

  @override
  String get import_successful => 'Importation réussie';

  @override
  String get error_importing_data =>
      'Erreur lors de l\'importation des données. Veuillez vous assurer que le format du fichier est correct.';

  @override
  String get sync_data_now => 'Synchroniser maintenant';

  @override
  String last_synced(String time) {
    return 'Dernière synchronisation :\n$time';
  }

  @override
  String get syncing => 'Synchronisation en cours...';

  @override
  String get never_synced => 'Jamais synchronisé';

  @override
  String get unauthenticated =>
      'Veuillez vous connecter pour synchroniser vos données sur plusieurs appareils.';

  @override
  String sync_error(String error) {
    return 'Erreur de synchronisation : $error';
  }

  @override
  String get premium_required_to_sync =>
      'Passez à Premium ou regardez des publicités pour synchroniser vos données.';

  @override
  String get sync_in_progress =>
      'Synchronisation en cours, veuillez patienter.';

  @override
  String cooldown(String time) {
    return 'Vous agissez trop vite. Veuillez attendre $time avant de synchroniser à nouveau.';
  }

  @override
  String get logout_delete_local_data_message =>
      'Voulez-vous supprimer les données locales sur cet appareil ? Les données synchronisées sur le cloud resteront en sécurité.';

  @override
  String get keep_local_data => 'Non, juste se déconnecter';

  @override
  String get delete_local_data => 'Supprimer les données';

  @override
  String get accepted_formats => 'Formats acceptés';

  @override
  String get select_file_to_import => 'Sélectionnez un fichier à importer';

  @override
  String get tap_to_browse =>
      'Appuyez pour parcourir les fichiers de votre appareil ou du cloud.';

  @override
  String get protected => 'Protégé';

  @override
  String get protected_description =>
      'Vos données ne quittent jamais votre appareil et sont traitées localement.';

  @override
  String get recent_imports => 'Importations récentes';

  @override
  String get no_recent_imports => 'Aucune importation de données récente';

  @override
  String get invalid_format => 'Format de fichier invalide.';

  @override
  String get import_success => 'Importation réussie !';

  @override
  String import_success_description(String count) {
    return '$count transactions ont été importées avec succès à partir du fichier.';
  }

  @override
  String get file_format_template => 'Modèle de fichier';

  @override
  String download_sample_file(String format) {
    return 'Télécharger le modèle de fichier $format';
  }

  @override
  String get card => 'Carte';

  @override
  String get font_selection => 'Sélection de la police';

  @override
  String get select_font => 'Sélectionner la police';

  @override
  String get font => 'Police';

  @override
  String get font_description =>
      'Une transaction notée par jour éloigne les soucis financiers.';

  @override
  String get reminder_title => 'Rappel de dépenses quotidiennes';

  @override
  String get reminder_body =>
      'Avez-vous enregistré vos dépenses aujourd\'hui ? 💸';

  @override
  String get defaultTransactionTitle => 'Nouvelle transaction';

  @override
  String get invoice_analysis => 'Analyse des factures...';

  @override
  String get mapbox_error =>
      'Erreur de chargement de la carte. Veuillez vérifier la configuration de votre jeton Mapbox.';

  @override
  String get location => 'Emplacement';

  @override
  String get current_location => 'Emplacement actuel';

  @override
  String get select_location => 'Sélectionner un emplacement';

  @override
  String get no_location_selected => 'Aucun emplacement sélectionné';

  @override
  String get search_location => 'Rechercher un lieu...';

  @override
  String get tap_to_change_location => 'Appuyez pour modifier le lieu';

  @override
  String get search_results => 'Résultats de recherche';

  @override
  String get no_location_found => 'Aucun lieu trouvé';

  @override
  String get recent_locations => 'Lieux récents';

  @override
  String get location_access_error => 'Erreur d\'accès à la localisation';

  @override
  String get location_permission_denied => 'Accès à la localisation refusé.';

  @override
  String get location_permission_denied_description =>
      'Veuillez activer l\'accès à la localisation dans les paramètres.';

  @override
  String get notification_permission_denied =>
      'Accès aux notifications refusé.';

  @override
  String get notification_permission_denied_description =>
      'Veuillez activer les notifications dans les paramètres pour recevoir des rappels.';

  @override
  String get permission_required_camera => 'Accès à l\'appareil photo refusé';

  @override
  String get permission_required_camera_description =>
      'Veuillez activer l\'appareil photo dans les paramètres pour scanner les reçus.';

  @override
  String get voice_input_error =>
      'Erreur de saisie vocale. Veuillez réessayer.';

  @override
  String get voice_input_not_recognized =>
      'Saisie vocale non reconnue. Veuillez réessayer.';

  @override
  String get voice_input_permission_denied =>
      'Accès au micro refusé. Veuillez activer l\'accès au microphone dans les paramètres.';

  @override
  String get error_ai_request =>
      'L\'IA ne reconnaît pas cette demande. Veuillez essayer d\'être plus précis.';

  @override
  String get voice_analysis => 'Analyse de la saisie vocale...';

  @override
  String get scan_receipt_error =>
      'Erreur lors du scan du reçu. Veuillez réessayer.';

  @override
  String get requires_premium =>
      'Cette fonctionnalité nécessite de regarder une pub ou de passer à Premium.';

  @override
  String get watch_ad_continue => 'Regarder une pub pour continuer';

  @override
  String get permission_required_voice_input => 'Accès au microphone refusé';

  @override
  String get permission_required_voice_input_description =>
      'Veuillez activer le microphone dans les paramètres pour utiliser la saisie vocale.';

  @override
  String get permission_required_location => 'Accès à la localisation refusé';

  @override
  String get permission_required_location_description =>
      'Veuillez activer la localisation dans les paramètres pour utiliser cette fonctionnalité.';

  @override
  String get congratulations => 'Félicitations !';

  @override
  String get successfully_purchased =>
      'Vous avez activé Premium avec succès. Profitez de votre expérience améliorée !';

  @override
  String get cancel_purchase => 'Annuler l\'achat';

  @override
  String get restore_no_purchase_description =>
      'Aucun achat précédent n\'a été trouvé à restaurer.';

  @override
  String get ai_powered => 'Alimenté par l\'IA';

  @override
  String get entries_pending => 'Entrées en attente';

  @override
  String get confirm_selected_entries => 'Ajouter les entrées sélectionnées';

  @override
  String get preview_results => 'Aperçu des résultats';

  @override
  String get clear_all => 'Tout effacer';

  @override
  String get select_all => 'Tout sélectionner';

  @override
  String get fail_to_save_transactions =>
      'Échec de l\'enregistrement des transactions. Veuillez réessayer.';

  @override
  String get tap_to_check_in => 'Appuyez pour valider votre présence';

  @override
  String get keep_your_streak => 'Gardez votre série !';

  @override
  String keep_your_streak_day(String streak) {
    return 'Conservez votre série de $streak jours !';
  }

  @override
  String get streak => 'Série';

  @override
  String streak_days(String days) {
    return '$days jours';
  }

  @override
  String get not_logined => 'Non connecté';

  @override
  String get please_login_to_sync_data =>
      'Veuillez vous connecter pour synchroniser vos données sur plusieurs appareils.';

  @override
  String get require_premium_to_sync =>
      'Passez à Premium ou regardez des publicités pour synchroniser vos données.';

  @override
  String get information_and_support => 'Informations & Support';

  @override
  String get contact_support => 'Contacter le support';

  @override
  String get send_email => 'Envoyer un e-mail';

  @override
  String get describe_issue =>
      'Décrivez votre problème ou question en détail. Notre équipe vous répondra dans les plus brefs délais.';

  @override
  String get feedback => 'Commentaires';

  @override
  String get feedback_description =>
      'Nous serions ravis de connaître vos avis et suggestions pour améliorer SpendFlow. Partagez vos retours !';

  @override
  String get thank_you_feedback => 'Merci pour vos retours !';

  @override
  String get submit_feedback => 'Envoyer les commentaires';

  @override
  String get report_issue => 'Signaler un problème';

  @override
  String get submit_issue => 'Envoyer le signalement';

  @override
  String get report_issue_description =>
      'Si vous rencontrez des bugs ou des problèmes, signalez-les ici. Votre aide est précieuse pour tout le monde.';

  @override
  String get thank_you_issue =>
      'Merci d\'avoir signalé ce problème ! Nous allons l\'examiner dès que possible.';

  @override
  String get request_delete_account => 'Demander la suppression du compte';

  @override
  String get delete_account_description =>
      'Si vous souhaitez supprimer votre compte, indiquez-nous pourquoi. Nous traiterons votre demande rapidement.';

  @override
  String get submit_delete_request => 'Envoyer la demande';

  @override
  String get select_subject => 'Sélectionner un sujet';

  @override
  String get please_enter_content => 'Veuillez entrer le contenu';

  @override
  String get subject => 'Sujet';

  @override
  String get content => 'Contenu';

  @override
  String get send_contact_success =>
      'Votre message a été envoyé avec succès ! Nous vous répondrons dès que possible.';

  @override
  String get send_contact_error =>
      'Une erreur est survenue lors de l\'envoi de votre message. Veuillez réessayer.';

  @override
  String get contact_info => 'Informations de contact';

  @override
  String get email_placeholder => 'Entrez votre e-mail';

  @override
  String get name_placeholder => 'Entrez votre nom';

  @override
  String get invalid_name => 'Veuillez entrer un nom valide.';

  @override
  String get mrs => 'Mme';

  @override
  String get mr => 'M.';

  @override
  String get ms => 'Mlle';

  @override
  String get salutation => 'Civilité';

  @override
  String get delete_account => 'Supprimer le compte';

  @override
  String get delete_account_confirmation =>
      'Êtes-vous sûr de vouloir supprimer votre compte ? Cette action est irréversible et supprimera toutes vos données.';

  @override
  String get failed_to_send_deletion_request =>
      'Échec de l\'envoi de la demande de suppression de compte. Veuillez réessayer.';

  @override
  String get requires_recent_login_description =>
      'Pour des raisons de sécurité, veuillez vous déconnecter et vous reconnecter avant de supprimer votre compte.';

  @override
  String get delete_account_failed =>
      'Une erreur est survenue lors de la suppression de votre compte. Veuillez réessayer.';

  @override
  String get left => 'restant';

  @override
  String get edit_transaction => 'Modifier la transaction';

  @override
  String get save_expense_change => 'Mettre à jour la dépense';

  @override
  String get save_income_change => 'Mettre à jour le revenu';

  @override
  String get transaction_updated => 'Transaction mise à jour avec succès';

  @override
  String get bank_sync => 'Synchronisation bancaire';

  @override
  String get bank_sync_description =>
      'Connectez et synchronisez automatiquement les transactions de vos comptes bancaires';

  @override
  String get coming_soon => 'Bientôt disponible';

  @override
  String get feature_under_development =>
      'Cette fonctionnalité est en cours de développement et sera disponible dans les prochaines mises à jour !';

  @override
  String get remaining_budget => 'Budget restant';

  @override
  String get monthly_spending => 'Graphique des dépenses mensuelles';

  @override
  String get quick_add_voice => 'Appuyez pour parler';
}
