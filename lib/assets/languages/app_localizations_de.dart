// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get app_name => 'SpendFlow';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get skip => 'Überspringen';

  @override
  String get next => 'Weiter';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get save => 'Speichern';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get delete => 'Löschen';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get done => 'Fertig';

  @override
  String get close => 'Schließen';

  @override
  String get back => 'Zurück';

  @override
  String get start => 'Starten';

  @override
  String get continueAction => 'Fortfahren';

  @override
  String get view_all => 'Alle anzeigen';

  @override
  String get see_all => 'Alle ansehen';

  @override
  String get amount => 'Betrag';

  @override
  String get name => 'Name';

  @override
  String get date => 'Datum';

  @override
  String get month => 'Monat';

  @override
  String get life_time => 'Lebenslang';

  @override
  String get today => 'Heute';

  @override
  String get other => 'Sonstiges';

  @override
  String get home => 'Startseite';

  @override
  String get reports => 'Berichte';

  @override
  String get budgets => 'Budgets';

  @override
  String get all => 'Alle';

  @override
  String get error => 'Fehler';

  @override
  String get user => 'Benutzer';

  @override
  String get success => 'Erfolg';

  @override
  String get loading => 'Wird geladen...';

  @override
  String get onboard_step1_title => 'Im Handumdrehen erfassen';

  @override
  String get onboard_step1_message =>
      'Erkennen Sie Ausgabenstandorte automatisch für eine schnellere Erfassung. Nie wieder fragen, wohin Ihr Geld geflossen ist.';

  @override
  String get onboard_step2_title => 'Beherrschen Sie Ihre Finanzen';

  @override
  String get onboard_step2_message =>
      'Legen Sie Ausgabenlimits für jede Kategorie fest. Wir helfen Ihnen, Ihre finanziellen Ziele zu erreichen.';

  @override
  String get onboard_step3_title => 'Gesunde Gewohnheiten aufbauen';

  @override
  String get onboard_step3_message =>
      'Erhalten Sie tägliche Erinnerungen, um keine Transaktion zu verpassen. Beständigkeit ist der Schlüssel zur finanziellen Freiheit.';

  @override
  String get create_first_wallet => 'Erstes Wallet erstellen';

  @override
  String get welcome_create_wallet =>
      'Willkommen bei Spend Flow!\nErstellen wir Ihr erstes Wallet, um loszulegen.';

  @override
  String get enter_wallet_name => 'Wallet-Namen eingeben';

  @override
  String get eg_my_wallet => 'z. B. Mein Wallet, Bargeld, Kreditkarte';

  @override
  String get currency_unit => 'Währungseinheit';

  @override
  String get create_wallet => 'Wallet erstellen';

  @override
  String get please_enter_wallet_name =>
      'Bitte geben Sie den Wallet-Namen ein.';

  @override
  String get add_wallet => 'Neues Wallet hinzufügen';

  @override
  String get wallet_name => 'Wallet-Name';

  @override
  String get add_wallet_description =>
      'Fügen Sie weitere Wallets hinzu, um Ihre Finanzen noch effektiver zu verwalten.';

  @override
  String get cannot_delete_last_wallet =>
      'Sie können das letzte Wallet nicht löschen.';

  @override
  String get delete_wallet => 'Wallet löschen';

  @override
  String delete_wallet_confirmation(String walletName) {
    return 'Möchten Sie das Wallet \'$walletName\' wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String get in_use => 'In Verwendung';

  @override
  String get incomplete_details => 'Unvollständige Angaben';

  @override
  String get please_fill_required_fields =>
      'Bitte füllen Sie die folgenden Pflichtfelder aus, um fortzufahren:';

  @override
  String get select_wallet => 'Wallet auswählen';

  @override
  String get please_create_wallet_first =>
      'Sie müssen ein Wallet erstellen, bevor Sie eine Transaktion hinzufügen können.';

  @override
  String get create_now => 'Jetzt erstellen';

  @override
  String get no_wallets_yet => 'Noch keine Wallets vorhanden';

  @override
  String get login => 'Anmelden';

  @override
  String get register => 'Registrieren';

  @override
  String get logout => 'Abmelden';

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Passwort';

  @override
  String get new_password => 'Neues Passwort';

  @override
  String get enter_email => 'Geben Sie Ihre E-Mail-Adresse ein';

  @override
  String get enter_your_password => 'Geben Sie Ihr Passwort ein';

  @override
  String get confirm_password => 'Passwort bestätigen';

  @override
  String get confirm_your_password => 'Bestätigen Sie Ihr Passwort';

  @override
  String get passwords_match => 'Passwörter stimmen überein.';

  @override
  String get passwords_mismatch => 'Passwörter stimmen nicht überein.';

  @override
  String get forgot_password => 'Passwort vergessen?';

  @override
  String get description_forgot_password =>
      'Geben Sie die mit Ihrem Konto verknüpfte E-Mail-Adresse ein, um Ihr Passwort zurückzusetzen.';

  @override
  String get send_otp => 'OTP senden';

  @override
  String get enter_otp => 'OTP eingeben';

  @override
  String get resend => 'Erneut senden';

  @override
  String get verify => 'Bestätigen';

  @override
  String get no_otp => 'Keinen Code erhalten?';

  @override
  String get verify_otp => 'OTP bestätigen';

  @override
  String get we_sent_otp =>
      'Bitte überprüfen Sie Ihre E-Mails auf den OTP-Code. Prüfen Sie auch Ihren Spam-Ordner.';

  @override
  String get dont_receive_otp => 'Haben Sie das OTP nicht erhalten?';

  @override
  String get plese_enter_valid_otp =>
      'Bitte geben Sie einen gültigen OTP-Code ein.';

  @override
  String get otp_resent => 'OTP-Code erfolgreich erneut gesendet.';

  @override
  String get register_successful => 'Registrierung erfolgreich!';

  @override
  String get register_successful_description =>
      'Ihr Konto wurde erfolgreich erstellt. Sie können sich jetzt anmelden.';

  @override
  String get no_account => 'Sie haben noch kein Konto?';

  @override
  String get have_account => 'Haben Sie bereits ein Konto?';

  @override
  String get login_error => 'Ungültige E-Mail-Adresse oder falsches Passwort';

  @override
  String get register_error => 'Registrierung fehlgeschlagen';

  @override
  String get create_account => 'Konto erstellen';

  @override
  String get create_password => 'Neues Passwort erstellen';

  @override
  String get create_new_password =>
      'Fast geschafft! Erstellen Sie Ihr neues Passwort.';

  @override
  String get or_continue_with => 'Oder fortfahren mit';

  @override
  String sign_in_with(String provider) {
    return 'Mit $provider anmelden';
  }

  @override
  String get check_your_mail => 'Überprüfen Sie Ihre E-Mails';

  @override
  String get we_have_sent_mail => 'Wir haben eine E-Mail gesendet an:';

  @override
  String get please_check_your_mail_to_verify_account =>
      'Bitte bestätigen Sie Ihr Konto per E-Mail, bevor Sie sich anmelden.';

  @override
  String get register_failed => 'Registrierung fehlgeschlagen';

  @override
  String get please_fill_all_fields => 'Bitte füllen Sie alle Felder aus.';

  @override
  String get please_enter_email_and_password =>
      'Bitte geben Sie sowohl E-Mail als auch Passwort ein.';

  @override
  String get incorrect_email_or_password =>
      'Falsche E-Mail-Adresse oder falsches Passwort.';

  @override
  String get invalid_email_format => 'Ungültiges E-Mail-Format.';

  @override
  String get this_account_has_been_disabled =>
      'Dieses Konto wurde deaktiviert.';

  @override
  String get too_many_requests_please_try_later =>
      'Zu viele Anfragen. Bitte versuchen Sie es später noch einmal.';

  @override
  String get email_not_verified => 'E-Mail nicht bestätigt';

  @override
  String get please_verify_your_email_to_continue =>
      'Bitte bestätigen Sie Ihre E-Mail-Adresse, um fortzufahren.';

  @override
  String get are_you_sure_logout => 'Möchten Sie sich wirklich abmelden?';

  @override
  String get have_error_occurred =>
      'Ein Fehler ist aufgetreten. Bitte versuchen Sie es erneut.';

  @override
  String get user_not_found => 'Kein Konto mit dieser E-Mail-Adresse gefunden.';

  @override
  String get enter_otp_reset_password =>
      'Wir haben einen OTP-Code an Ihre E-Mail gesendet. Bitte geben Sie ihn ein, um Ihr Passwort zurückzusetzen.';

  @override
  String get not_time_yet_to_resend_otp =>
      'Bitte warten Sie einen Moment, bevor Sie den Code erneut anfordern.';

  @override
  String get reset_password_successful => 'Passwort erfolgreich zurückgesetzt';

  @override
  String get reset_password_successful_description =>
      'Ihr Passwort wurde erfolgreich geändert. Sie können sich nun mit dem neuen Passwort anmelden.';

  @override
  String get welcome_back => 'Willkommen zurück';

  @override
  String get back_login => 'Zurück zur Anmeldung';

  @override
  String get description_create_account =>
      'Übernehmen Sie noch heute die Kontrolle über Ihre Finanzen';

  @override
  String get label_weak => 'Schwach';

  @override
  String get label_fair => 'Mäßig';

  @override
  String get label_good => 'Gut';

  @override
  String get label_strong => 'Stark';

  @override
  String get low_pass =>
      'Muss mindestens 8 Zeichen, eine Zahl und ein Symbol enthalten.';

  @override
  String get weak_pass => 'Zu kurz. Bitte fügen Sie mehr Zeichen hinzu.';

  @override
  String get fair_pass => 'Besser. Fügen Sie Zahlen und Symbole hinzu!';

  @override
  String get good_pass_char =>
      'Fast fertig! Fügen Sie ein Sonderzeichen hinzu.';

  @override
  String get good_pass_num => 'Fast fertig! Fügen Sie eine Zahl hinzu.';

  @override
  String get good_pass_special =>
      'Fast fertig! Fügen Sie ein beliebiges Zeichen hinzu.';

  @override
  String get strong_pass => 'Großartig! Ihr Passwort ist sicher.';

  @override
  String get password_reset_email_sent =>
      'Wir haben einen Link zum Zurücksetzen des Passworts an Ihre E-Mail gesendet.';

  @override
  String get forgot_password_description =>
      'Geben Sie die E-Mail-Adresse Ihres Kontos ein, um das Passwort zurückzusetzen.';

  @override
  String get send_email_reset => 'E-Mail zum Zurücksetzen senden';

  @override
  String get password_weak_password =>
      'Das eingegebene Passwort ist zu schwach.';

  @override
  String get please_edit_fields =>
      'Bitte bearbeiten Sie die folgenden Felder, um fortzufahren:';

  @override
  String get something_went_wrong =>
      'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';

  @override
  String get email_already_in_use =>
      'Diese E-Mail-Adresse wird bereits verwendet.';

  @override
  String get invalid_email => 'Die E-Mail-Adresse ist ungültig.';

  @override
  String get operation_not_allowed =>
      'Vorgang nicht zulässig. Bitte wenden Sie sich an den Support.';

  @override
  String get network_error =>
      'Netzwerkfehler. Bitte überprüfen Sie Ihre Verbindung und versuchen Sie es erneut.';

  @override
  String get reset_password => 'Passwort zurücksetzen';

  @override
  String get email_not_received => 'Keine E-Mail erhalten?';

  @override
  String get verification_email_sent => 'Bestätigungs-E-Mail gesendet';

  @override
  String get good_morning => 'Guten Morgen';

  @override
  String get good_afternoon => 'Guten Tag';

  @override
  String get good_evening => 'Guten Abend';

  @override
  String get hello => 'Hallo';

  @override
  String get income => 'Einnahmen';

  @override
  String get expenses => 'Ausgaben';

  @override
  String get balance => 'Saldo';

  @override
  String get total_balance => 'Gesamtsaldo';

  @override
  String get spending_this_month => 'Ausgaben diesen Monat';

  @override
  String get total_spent => 'Gesamtausgaben';

  @override
  String get recent_transactions => 'Aktuelle Transaktionen';

  @override
  String get add_transaction => 'Transaktion hinzufügen';

  @override
  String get no_transactions => 'Keine Daten verfügbar';

  @override
  String get enter_transaction_name => 'Transaktionsnamen eingeben';

  @override
  String get suggested_category => 'Vorgeschlagene Kategorie';

  @override
  String get category => 'Kategorie';

  @override
  String get categories => 'Kategorien';

  @override
  String get select_category => 'Kategorie auswählen';

  @override
  String get edit_category => 'Kategorie bearbeiten';

  @override
  String are_you_sure_delete_category(String categoryName) {
    return 'Möchten Sie $categoryName wirklich löschen?';
  }

  @override
  String get system_category =>
      'Systemkategorien können nicht gelöscht werden.';

  @override
  String get system_category_description =>
      'Sie können diese Standardkategorie weder bearbeiten noch löschen.';

  @override
  String get category_food => 'Essen & Trinken';

  @override
  String get category_transport => 'Transport';

  @override
  String get category_salary => 'Gehalt';

  @override
  String get category_shopping => 'Einkaufen';

  @override
  String get category_game => 'Spiele';

  @override
  String get category_house => 'Wohnen';

  @override
  String get category_gift => 'Geschenke';

  @override
  String get category_health => 'Gesundheit';

  @override
  String get category_entertainment => 'Unterhaltung';

  @override
  String get category_bill => 'Rechnungen';

  @override
  String get category_insurance => 'Versicherung';

  @override
  String get category_education => 'Bildung';

  @override
  String get category_pet => 'Haustiere';

  @override
  String get category_travel => 'Reisen';

  @override
  String get category_savings => 'Sparen';

  @override
  String get category_phone => 'Telefon';

  @override
  String get category_internet => 'Internet';

  @override
  String get category_water => 'Wasser';

  @override
  String get category_electricity => 'Strom';

  @override
  String get category_gas => 'Gas';

  @override
  String get category_cleaning => 'Reinigung';

  @override
  String get category_beauty => 'Kosmetik';

  @override
  String get category_baby => 'Baby';

  @override
  String get category_sport => 'Sport';

  @override
  String get category_music => 'Musik';

  @override
  String get category_repair => 'Reparatur';

  @override
  String get category_tax => 'Steuern';

  @override
  String get note => 'Notiz (optional)';

  @override
  String get enter_note => 'Notiz eingeben';

  @override
  String get add_income => 'Einnahme hinzufügen';

  @override
  String get add_expense => 'Ausgabe hinzufügen';

  @override
  String get search_category => 'Kategorie suchen';

  @override
  String get no_category_found => 'Keine Kategorie gefunden';

  @override
  String get most_used => 'Am häufigsten verwendet';

  @override
  String get category_suggestions => 'Kategorievorschläge';

  @override
  String get all_categories => 'Alle Kategorien';

  @override
  String get new_category => 'Neue Kategorie';

  @override
  String get category_name => 'Kategoriename';

  @override
  String get category_color => 'Kategoriefarbe';

  @override
  String get category_icon => 'Kategoriesymbol';

  @override
  String get vs_last_month => 'im Vgl. zum Vormonat';

  @override
  String get transaction => 'Transaktion';

  @override
  String get delete_transaction => 'Transaktion löschen';

  @override
  String get delete_transaction_confirmation =>
      'Möchten Sie diese Transaktion wirklich löschen?';

  @override
  String get transaction_details => 'Transaktionsdetails';

  @override
  String get spending_trend => 'Ausgabentrend';

  @override
  String get spending_last_7_days => 'Ausgaben der letzten 7 Tage';

  @override
  String get note_2 => 'Notiz';

  @override
  String get scan_receipt => 'Beleg scannen';

  @override
  String get add_via_voice => 'Per Sprache hinzufügen';

  @override
  String get add_manually => 'Manuell hinzufügen';

  @override
  String get limit_reached => 'Limit erreicht';

  @override
  String limit_reached_description(String featureName, String limit) {
    return 'Sie haben $featureName heute $limit Mal verwendet.\nBitte kommen Sie morgen wieder oder wechseln Sie zu Premium.';
  }

  @override
  String get align_receipt => 'Richten Sie Ihren Beleg aus';

  @override
  String get listening => 'Zuhören...';

  @override
  String get voice_example =>
      'z. B.: Ich habe 50 Euro für Lebensmittel ausgegeben';

  @override
  String get tap_to_stop => 'Tippen zum Stoppen';

  @override
  String get tap_to_listen => 'Tippen zum Zuhören';

  @override
  String get yesterday => 'Gestern';

  @override
  String get your_monthly_budget => 'Ihr Monatsbudget';

  @override
  String get spent => 'Ausgegeben: ';

  @override
  String get out_of => ' von ';

  @override
  String get left_to_spend => 'übrig zum Ausgeben';

  @override
  String get add_budget => 'Budget hinzufügen';

  @override
  String get no_budgets_yet => 'Noch keine Budgets vorhanden';

  @override
  String get create_budget_description =>
      'Tippen Sie auf +, um ein Ausgabenlimit festzulegen';

  @override
  String get edit_budget => 'Budget bearbeiten';

  @override
  String are_you_sure_delete_budget(String budgetName) {
    return 'Möchten Sie \n $budgetName wirklich löschen?';
  }

  @override
  String get delete_budget => 'Budget löschen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get settings_description =>
      'Halten Sie Ihre Finanzdaten auf all Ihren Geräten synchron';

  @override
  String get sign_in_now => 'Jetzt anmelden';

  @override
  String get get_started => 'Loslegen';

  @override
  String get welcome => 'Willkommen!';

  @override
  String get general => 'Allgemein';

  @override
  String get security => 'Sicherheit';

  @override
  String get privacy_and_security => 'Datenschutz & Sicherheit';

  @override
  String get support => 'Support';

  @override
  String get profile => 'Profil';

  @override
  String get language => 'Sprache';

  @override
  String get dark_mode => 'Dunkelmodus';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get currency => 'Währung';

  @override
  String get about => 'Über die App';

  @override
  String get terms_of_service => 'Nutzungsbedingungen';

  @override
  String get privacy_policy => 'Datenschutzerklärung';

  @override
  String get version => 'Version';

  @override
  String get edit_profile => 'Profil bearbeiten';

  @override
  String get full_name => 'Vollständiger Name';

  @override
  String get enter_full_name => 'Vollständigen Namen eingeben';

  @override
  String get email_address => 'E-Mail-Adresse';

  @override
  String get enter_email_address => 'E-Mail-Adresse eingeben';

  @override
  String get phone_number => 'Telefonnummer';

  @override
  String get enter_phone_number => 'Telefonnummer eingeben';

  @override
  String get day_of_birth => 'Geburtsdatum';

  @override
  String get select_day_of_birth => 'Geburtsdatum auswählen';

  @override
  String get save_changes => 'Änderungen speichern';

  @override
  String get profile_updated_success => 'Profil erfolgreich aktualisiert!';

  @override
  String get error_updating_profile => 'Fehler beim Aktualisieren des Profils.';

  @override
  String get error_uploading_avatar => 'Fehler beim Hochladen des Profilbilds.';

  @override
  String get require_premium_to_edit_avatar =>
      'Wechseln Sie zu Premium oder sehen Sie sich Werbung an, um Ihr Profilbild zu bearbeiten.';

  @override
  String get edit_avatar => 'Profilbild bearbeiten';

  @override
  String get upgrade_premium => 'Auf Premium upgraden!';

  @override
  String get upgrade_premium_description =>
      'Schalten Sie exklusive Funktionen frei und verbessern Sie Ihr Erlebnis.';

  @override
  String get upgrade_now => 'Jetzt upgraden';

  @override
  String get you_are_premium => 'Alles bereit, Premium-Nutzer!';

  @override
  String get you_are_premium_description =>
      'Genießen Sie Ihr erweitertes Erlebnis.';

  @override
  String get import_export_data => 'Daten importieren / exportieren';

  @override
  String get sync_data => 'Daten synchronisieren';

  @override
  String continue_with(String price) {
    return 'Weiter mit $price';
  }

  @override
  String get biometric_authentication => 'Biometrische Authentifizierung';

  @override
  String get password_security => 'Passwortsicherheit';

  @override
  String get face_id_description =>
      'Entsperren Sie Ihre App mit einem Blick. Face ID bietet bequemen und sicheren Zugriff.';

  @override
  String get touch_id_description =>
      'Entsperren Sie Ihre App mit einer Berührung per Fingerabdruck.';

  @override
  String get pass_code_description =>
      'Zusätzlicher Schutz. Ein Sperrcode stellt sicher, dass nur Sie Zugriff auf Ihre Finanzdaten haben.';

  @override
  String get passcode => 'Sperrcode';

  @override
  String get change_passcode => 'Sperrcode ändern';

  @override
  String get old_passcode => 'Alter Sperrcode';

  @override
  String get enter_old_passcode => 'Alten Sperrcode eingeben';

  @override
  String get new_passcode => 'Neuer Sperrcode';

  @override
  String get enter_new_passcode => 'Neuen Sperrcode eingeben';

  @override
  String get confirm_new_passcode => 'Neuen Sperrcode bestätigen';

  @override
  String get enter_confirm_new_passcode => 'Neuen Sperrcode erneut eingeben';

  @override
  String get turnOffPasscode => 'Sperrcode deaktivieren';

  @override
  String get createPasscode => 'Sperrcode erstellen';

  @override
  String get changePasscode => 'Sperrcode ändern';

  @override
  String get removePasscode => 'Sperrcode entfernen';

  @override
  String get updatePasscode => 'Sperrcode aktualisieren';

  @override
  String get description_create_passcode =>
      'Schützen Sie Ihr Konto, indem Sie Ihren 6-stelligen Code regelmäßig aktualisieren.';

  @override
  String get description_remove_passcode =>
      'Geben Sie Ihren aktuellen Sperrcode ein, um die Sicherheit zu deaktivieren.';

  @override
  String get currentPasscode => 'Aktueller Sperrcode';

  @override
  String get enterCurrentPin => 'Aktuelle PIN eingeben';

  @override
  String get passcode_turn_off_success => 'Sperrcode erfolgreich deaktiviert!';

  @override
  String get passcode_update_success => 'Sperrcode erfolgreich aktualisiert!';

  @override
  String get passcode_create_success => 'Sperrcode erfolgreich erstellt!';

  @override
  String get currentPasscodeIncorrect => 'Aktueller Sperrcode ist falsch.';

  @override
  String get errorSavingData => 'Fehler beim Speichern der Daten.';

  @override
  String get newPasscodeMustBe6Digits =>
      'Der neue Sperrcode muss 6 Ziffern lang sein.';

  @override
  String get passcodesDoNotMatch => 'Sperrcodes stimmen nicht überein.';

  @override
  String get enter_passcode => 'Sperrcode eingeben';

  @override
  String get incorrect_passcode => 'Falscher Sperrcode.';

  @override
  String get face => 'Face ID';

  @override
  String get fingerprint => 'Fingerabdruck';

  @override
  String get report_locked => 'Gesperrter Inhalt';

  @override
  String get unlock => 'Entsperren';

  @override
  String get click_to_unlock => 'Zum Entsperren tippen';

  @override
  String get unlock_untilimited_access => 'Unbegrenzten Zugang freischalten';

  @override
  String get unlock_untilimited_access_description =>
      'Holen Sie sich Premium für unbegrenzten Zugriff auf alle erweiterten Funktionen.';

  @override
  String get daily_input_cap_reached => 'Tägliches Limit erreicht';

  @override
  String get daily_input_cap_reached_description =>
      'Sie haben Ihr tägliches Limit für Belegscans und Spracheingaben erreicht. Jetzt upgraden.';

  @override
  String get feature_comparison => 'Funktionsvergleich';

  @override
  String get feature => 'Funktion';

  @override
  String get free => 'Kostenlos';

  @override
  String get premium => 'Premium';

  @override
  String get no_ads => 'Keine Werbung';

  @override
  String get transaction_locking => 'Transaktionssperre';

  @override
  String get unlimited_scans => 'Unbegrenzte Belegscans';

  @override
  String get unlimited_voice_entries => 'Unbegrenzte Spracheingaben';

  @override
  String get day => 'Tag';

  @override
  String get year => 'Jahr';

  @override
  String get subscription_auto_renews =>
      'Abonnement verlängert sich automatisch.';

  @override
  String get accept_terms_conditions =>
      'Abonnement verlängert sich automatisch. Durch Fortfahren stimmen Sie den AGB und Datenschutzbestimmungen zu.';

  @override
  String get restore => 'Wiederherstellen';

  @override
  String used_up_daily_limit(String value) {
    return 'Sie haben Ihr Limit für Spracheingaben heute aufgebraucht. Werbung ansehen für $value weitere Nutzungen oder zu Premium wechseln.';
  }

  @override
  String get monthly_plan => 'Monatsplan';

  @override
  String get yearly_plan => 'Jahresplan';

  @override
  String get lifetime_plan => 'Lebenslanger Plan';

  @override
  String get pay_once_enjoy_forever => 'Einmal zahlen, für immer nutzen';

  @override
  String get yearly_discount => 'Sparen Sie 20 % mit dem Jahresplan';

  @override
  String get best_value => 'BESTES ANGEBOT';

  @override
  String get transaction_cancelled => 'Transaktion abgebrochen.';

  @override
  String get purchase_successful => 'Kauf erfolgreich!';

  @override
  String get purchase_successful_description =>
      'Vielen Dank für das Upgrade auf Premium! Genießen Sie Ihr verbessertes Erlebnis.';

  @override
  String get restore_successful => 'Wiederherstellung erfolgreich!';

  @override
  String get restore_successful_description =>
      'Ihr vorheriger Kauf wurde wiederhergestellt. Viel Spaß mit Premium!';

  @override
  String get nothing_to_restore => 'Nichts wiederherzustellen';

  @override
  String get nothing_to_restore_description =>
      'Es wurden keine vorherigen Käufe gefunden.';

  @override
  String get restore_failed => 'Wiederherstellung fehlgeschlagen';

  @override
  String get restore_failed_description =>
      'Beim Wiederherstellen ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.';

  @override
  String get purchase_failed => 'Kauf fehlgeschlagen';

  @override
  String get purchase_failed_description =>
      'Während der Transaktion ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.';

  @override
  String get purchase_canceled => 'Kauf abgebrochen';

  @override
  String get purchase_canceled_description =>
      'Die Transaktion wurde abgebrochen. Es wurden keine Änderungen vorgenommen.';

  @override
  String get premium_sync_account =>
      'Ihr Premium-Konto wird mit dem Konto synchronisiert, mit dem Sie angemeldet sind. Bitte nutzen Sie dasselbe Konto auf all Ihren Geräten.';

  @override
  String get premium_sync_warning =>
      'Hinweis: Wenn Sie Premium auf einem anderen Konto erworben haben, melden Sie sich bitte dort an. Andernfalls versuchen Sie, Käufe wiederherzustellen.';

  @override
  String get select_language => 'Sprache auswählen';

  @override
  String get suggested => 'Vorgeschlagen';

  @override
  String get all_languages => 'Alle Sprachen';

  @override
  String get apply_changes => 'Änderungen anwenden';

  @override
  String get select_currency => 'Währung auswählen';

  @override
  String get search_currency => 'Währung oder Land suchen...';

  @override
  String get popular => 'Beliebt';

  @override
  String get all_currencies => 'Alle Währungen';

  @override
  String get currency_change_warning =>
      'Das Ändern der Währung aktualisiert nur das angezeigte Symbol. Vergangene Kurse werden nicht neu berechnet.';

  @override
  String see_ads(String additionalUses) {
    return 'Werbung ansehen (+$additionalUses Nutzungen)';
  }

  @override
  String get ads_loading => 'Werbung wird geladen...';

  @override
  String get data_management => 'Datenverwaltung';

  @override
  String get select_format => 'Format auswählen';

  @override
  String get export_data => 'Daten exportieren';

  @override
  String get export_data_description =>
      'Exportieren Sie Ihre Finanzdaten zur Sicherung oder Analyse.';

  @override
  String get confirm_export => 'Export bestätigen';

  @override
  String get import_data => 'Daten importieren';

  @override
  String get import_data_title => 'Bringen wir Ihre \n';

  @override
  String get data => 'Daten';

  @override
  String get import_data_title_2 => ' hierher.';

  @override
  String get import_data_description =>
      'Importieren Sie Finanzdaten aus externen Quellen zur Synchronisierung.';

  @override
  String get confirm_import => 'Import bestätigen';

  @override
  String get csv_format => 'CSV-Format';

  @override
  String get csv_description =>
      'Daten im CSV-Format exportieren, kompatibel mit Tabellenkalkulationen.';

  @override
  String get json_format => 'JSON-Format';

  @override
  String get json_description =>
      'Daten im JSON-Format exportieren, ideal für Entwickler.';

  @override
  String get excel_format => 'Excel-Format';

  @override
  String get excel_description =>
      'Daten im Excel-Format exportieren, perfekt für detaillierte Finanzanalysen.';

  @override
  String get select_file => 'Datei auswählen';

  @override
  String get no_file_selected => 'Keine Datei ausgewählt.';

  @override
  String get import_successful => 'Import erfolgreich';

  @override
  String get error_importing_data =>
      'Fehler beim Importieren der Daten. Bitte Dateiformat überprüfen.';

  @override
  String get sync_data_now => 'Jetzt synchronisieren';

  @override
  String last_synced(String time) {
    return 'Zuletzt synchronisiert:\n$time';
  }

  @override
  String get syncing => 'Synchronisierung läuft...';

  @override
  String get never_synced => 'Nie synchronisiert';

  @override
  String get unauthenticated =>
      'Bitte melden Sie sich an, um Daten geräteübergreifend zu synchronisieren.';

  @override
  String sync_error(String error) {
    return 'Synchronisierungsfehler: $error';
  }

  @override
  String get premium_required_to_sync =>
      'Wechseln Sie zu Premium oder sehen Sie sich Werbung an, um Daten zu synchronisieren.';

  @override
  String get sync_in_progress => 'Synchronisierung läuft, bitte warten.';

  @override
  String cooldown(String time) {
    return 'Zu viele Aktionen. Bitte warten Sie $time, bevor Sie erneut synchronisieren.';
  }

  @override
  String get logout_delete_local_data_message =>
      'Möchten Sie lokale Daten auf diesem Gerät löschen? Synchronisierte Cloud-Daten bleiben sicher.';

  @override
  String get keep_local_data => 'Nein, nur abmelden';

  @override
  String get delete_local_data => 'Daten löschen';

  @override
  String get accepted_formats => 'Unterstützte Formate';

  @override
  String get select_file_to_import =>
      'Wählen Sie eine Datei zum Importieren aus';

  @override
  String get tap_to_browse =>
      'Tippen Sie hier, um Dateien auf dem Gerät oder in der Cloud auszuwählen.';

  @override
  String get protected => 'Geschützt';

  @override
  String get protected_description =>
      'Ihre Daten verlassen Ihr Gerät nie und werden lokal verarbeitet.';

  @override
  String get recent_imports => 'Letzte Importe';

  @override
  String get no_recent_imports => 'Keine aktuellen Datenimporte';

  @override
  String get invalid_format => 'Ungültiges Dateiformat.';

  @override
  String get import_success => 'Erfolgreich importiert!';

  @override
  String import_success_description(String count) {
    return '$count Transaktionen wurden erfolgreich aus der Datei importiert.';
  }

  @override
  String get file_format_template => 'Dateiformat-Vorlage';

  @override
  String download_sample_file(String format) {
    return 'Beispieldatei herunterladen $format';
  }

  @override
  String get card => 'Karte';

  @override
  String get font_selection => 'Schriftauswahl';

  @override
  String get select_font => 'Schriftart auswählen';

  @override
  String get font => 'Schriftart';

  @override
  String get font_description =>
      'Eine Transaktion am Tag hält Geldsorgen fern.';

  @override
  String get reminder_title => 'Tägliche Ausgabenerinnerung';

  @override
  String get reminder_body =>
      'Haben Sie heute schon Ihre Ausgaben eingetragen? 💸';

  @override
  String get defaultTransactionTitle => 'Neue Transaktion';

  @override
  String get invoice_analysis => 'Belege werden analysiert...';

  @override
  String get mapbox_error =>
      'Kartenladefehler. Bitte überprüfen Sie Ihre Mapbox-Konfiguration.';

  @override
  String get location => 'Standort';

  @override
  String get current_location => 'Aktueller Standort';

  @override
  String get select_location => 'Standort auswählen';

  @override
  String get no_location_selected => 'Kein Standort ausgewählt';

  @override
  String get search_location => 'Standort suchen...';

  @override
  String get tap_to_change_location => 'Tippen, um den Standort zu ändern';

  @override
  String get search_results => 'Suchergebnisse';

  @override
  String get no_location_found => 'Kein Standort gefunden';

  @override
  String get recent_locations => 'Letzte Standorte';

  @override
  String get location_access_error => 'Standortzugriffsfehler';

  @override
  String get location_permission_denied => 'Standortzugriff verweigert.';

  @override
  String get location_permission_denied_description =>
      'Bitte aktivieren Sie den Standortzugriff in den Einstellungen.';

  @override
  String get notification_permission_denied =>
      'Benachrichtigungszugriff verweigert.';

  @override
  String get notification_permission_denied_description =>
      'Bitte aktivieren Sie Benachrichtigungen in den Einstellungen.';

  @override
  String get permission_required_camera => 'Kamerazugriff verweigert';

  @override
  String get permission_required_camera_description =>
      'Bitte aktivieren Sie den Kamerazugriff zum Scannen von Belegen.';

  @override
  String get voice_input_error =>
      'Spracheingabefehler. Bitte versuchen Sie es erneut.';

  @override
  String get voice_input_not_recognized =>
      'Sprache nicht erkannt. Bitte versuchen Sie es erneut.';

  @override
  String get voice_input_permission_denied =>
      'Mikrofonzugriff verweigert. Bitte aktivieren Sie ihn in den Einstellungen.';

  @override
  String get error_ai_request =>
      'Die KI kann diese Anfrage nicht erkennen. Bitte formulieren Sie genauer.';

  @override
  String get voice_analysis => 'Spracheingabe wird analysiert...';

  @override
  String get scan_receipt_error =>
      'Fehler beim Belegscan. Bitte versuchen Sie es erneut.';

  @override
  String get requires_premium =>
      'Diese Funktion erfordert das Ansehen von Werbung oder ein Premium-Upgrade.';

  @override
  String get watch_ad_continue => 'Werbung ansehen zum Fortfahren';

  @override
  String get permission_required_voice_input => 'Mikrofonzugriff verweigert';

  @override
  String get permission_required_voice_input_description =>
      'Bitte aktivieren Sie den Mikrofonzugriff für die Spracheingabe.';

  @override
  String get permission_required_location => 'Standortzugriff verweigert';

  @override
  String get permission_required_location_description =>
      'Bitte aktivieren Sie den Standortzugriff in den Einstellungen.';

  @override
  String get congratulations => 'Herzlichen Glückwunsch!';

  @override
  String get successfully_purchased =>
      'Sie haben Premium erfolgreich erworben. Genießen Sie alle Vorteile!';

  @override
  String get cancel_purchase => 'Kauf abbrechen';

  @override
  String get restore_no_purchase_description =>
      'Es wurden keine früheren Käufe zum Wiederherstellen gefunden.';

  @override
  String get ai_powered => 'KI-gestützt';

  @override
  String get entries_pending => 'Ausstehende Einträge';

  @override
  String get confirm_selected_entries => 'Ausgewählte Einträge hinzufügen';

  @override
  String get preview_results => 'Ergebnisvorschau';

  @override
  String get clear_all => 'Alle löschen';

  @override
  String get select_all => 'Alle auswählen';

  @override
  String get fail_to_save_transactions =>
      'Transaktionen konnten nicht gespeichert werden. Bitte erneut versuchen.';

  @override
  String get tap_to_check_in => 'Tippen zum Einchecken';

  @override
  String get keep_your_streak => 'Halten Sie Ihre Serie aufrecht!';

  @override
  String keep_your_streak_day(String streak) {
    return 'Halten Sie Ihre Serie von $streak Tagen aufrecht!';
  }

  @override
  String get streak => 'Serie';

  @override
  String streak_days(String days) {
    return '$days Tage';
  }

  @override
  String get not_logined => 'Nicht angemeldet';

  @override
  String get please_login_to_sync_data =>
      'Bitte melden Sie sich an, um Daten zu synchronisieren.';

  @override
  String get require_premium_to_sync =>
      'Wechseln Sie zu Premium oder sehen Sie sich Werbung an, um Daten zu synchronisieren.';

  @override
  String get information_and_support => 'Information & Support';

  @override
  String get contact_support => 'Support kontaktieren';

  @override
  String get send_email => 'E-Mail senden';

  @override
  String get describe_issue =>
      'Beschreiben Sie Ihr Anliegen im Detail. Unser Support-Team antwortet schnellstmöglich.';

  @override
  String get feedback => 'Feedback';

  @override
  String get feedback_description =>
      'Wir freuen uns über Ihre Gedanken und Vorschläge zur Verbesserung von SpendFlow!';

  @override
  String get thank_you_feedback => 'Vielen Dank für Ihr Feedback!';

  @override
  String get submit_feedback => 'Feedback senden';

  @override
  String get report_issue => 'Problem melden';

  @override
  String get submit_issue => 'Problem einreichen';

  @override
  String get report_issue_description =>
      'Wenn Sie auf Fehler stoßen, melden Sie diese bitte hier. Ihr Feedback hilft allen.';

  @override
  String get thank_you_issue =>
      'Vielen Dank für Ihre Meldung! Wir werden uns so schnell wie möglich darum kümmern.';

  @override
  String get request_delete_account => 'Kontolöschung anfordern';

  @override
  String get delete_account_description =>
      'Wenn Sie Ihr Konto löschen möchten, teilen Sie uns bitte den Grund mit.';

  @override
  String get submit_delete_request => 'Anfrage absenden';

  @override
  String get select_subject => 'Betreff auswählen';

  @override
  String get please_enter_content => 'Bitte Inhalt eingeben';

  @override
  String get subject => 'Betreff';

  @override
  String get content => 'Inhalt';

  @override
  String get send_contact_success =>
      'Ihre Nachricht wurde erfolgreich gesendet! Wir antworten so schnell wie möglich.';

  @override
  String get send_contact_error =>
      'Beim Senden ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.';

  @override
  String get contact_info => 'Kontaktinformationen';

  @override
  String get email_placeholder => 'Geben Sie Ihre E-Mail-Adresse ein';

  @override
  String get name_placeholder => 'Geben Sie Ihren Namen ein';

  @override
  String get invalid_name => 'Bitte geben Sie einen gültigen Namen ein.';

  @override
  String get mrs => 'Frau';

  @override
  String get mr => 'Herr';

  @override
  String get ms => 'Frau';

  @override
  String get salutation => 'Anrede';

  @override
  String get delete_account => 'Konto löschen';

  @override
  String get delete_account_confirmation =>
      'Möchten Sie Ihr Konto wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden und löscht alle Daten.';

  @override
  String get failed_to_send_deletion_request =>
      'Anfrage zur Kontolöschung konnte nicht gesendet werden. Bitte erneut versuchen.';

  @override
  String get requires_recent_login_description =>
      'Bitte melden Sie sich aus Sicherheitsgründen erneut an, bevor Sie Ihr Konto löschen.';

  @override
  String get delete_account_failed =>
      'Beim Löschen des Kontos ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.';

  @override
  String get left => 'übrig';

  @override
  String get edit_transaction => 'Transaktion bearbeiten';

  @override
  String get save_expense_change => 'Ausgabe aktualisieren';

  @override
  String get save_income_change => 'Einnahme aktualisieren';

  @override
  String get transaction_updated => 'Transaktion erfolgreich aktualisiert';

  @override
  String get bank_sync => 'Banksynchronisierung';

  @override
  String get bank_sync_description =>
      'Automatisch Bankkontotransaktionen verbinden und synchronisieren';

  @override
  String get coming_soon => 'Demnächst verfügbar';

  @override
  String get feature_under_development =>
      'Diese Funktion befindet sich in Entwicklung und wird bald verfügbar sein!';

  @override
  String get remaining_budget => 'Restbudget';

  @override
  String get monthly_spending => 'Monatliche Ausgabenübersicht';

  @override
  String get quick_add_voice => 'Tippen zum Sprechen';

  @override
  String get ad_no_fill_title => 'Keine Werbung verfügbar';

  @override
  String get ad_no_fill_message =>
      'Derzeit ist keine Werbung verfügbar. Bitte versuchen Sie es später erneut oder upgraden Sie auf Premium.';

  @override
  String get ad_network_error_title => 'Verbindungsfehler';

  @override
  String get ad_network_error_message =>
      'Verbindung zum Laden der Werbung fehlgeschlagen. Bitte überprüfen Sie Ihre Internetverbindung.';

  @override
  String get ad_load_failed_title => 'Ladefehler';

  @override
  String get ad_load_failed_message =>
      'Beim Laden der Werbung ist ein Fehler aufgetreten. Bitte versuchen Sie es später erneut.';

  @override
  String get ad_show_failed_title => 'Anzeigefehler';

  @override
  String get ad_show_failed_message =>
      'Die Werbung konnte nicht angezeigt werden. Bitte versuchen Sie es später erneut.';

  @override
  String get ad_loading_timeout_message =>
      'Das Laden der Werbung dauert zu lange. Bitte versuchen Sie es später erneut.';

  @override
  String get ad_preparing => 'Werbung wird vorbereitet...';
}
