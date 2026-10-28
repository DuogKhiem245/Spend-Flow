// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get app_name => 'SpendFlow';

  @override
  String get ok => 'Aceptar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get skip => 'Saltar';

  @override
  String get next => 'Siguiente';

  @override
  String get confirm => 'Confirmar';

  @override
  String get save => 'Guardar';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get done => 'Listo';

  @override
  String get close => 'Cerrar';

  @override
  String get back => 'Atrás';

  @override
  String get start => 'Comenzar';

  @override
  String get continueAction => 'Continuar';

  @override
  String get view_all => 'Ver todo';

  @override
  String get see_all => 'Ver todo';

  @override
  String get amount => 'Cantidad';

  @override
  String get name => 'Nombre';

  @override
  String get date => 'Fecha';

  @override
  String get month => 'Mes';

  @override
  String get life_time => 'De por vida';

  @override
  String get today => 'Hoy';

  @override
  String get other => 'Otro';

  @override
  String get home => 'Inicio';

  @override
  String get reports => 'Informes';

  @override
  String get budgets => 'Presupuestos';

  @override
  String get all => 'Todo';

  @override
  String get error => 'Error';

  @override
  String get user => 'Usuario';

  @override
  String get success => 'Éxito';

  @override
  String get loading => 'Cargando...';

  @override
  String get onboard_step1_title => 'Graba en un instante';

  @override
  String get onboard_step1_message =>
      'Detecte automáticamente ubicaciones de gasto para un registro más rápido. Nunca más te preguntes adónde fue a parar tu dinero.';

  @override
  String get onboard_step2_title => 'Domina tu billetera';

  @override
  String get onboard_step2_message =>
      'Establezca límites de gasto para cada categoría. Lo mantendremos al día con sus objetivos financieros';

  @override
  String get onboard_step3_title => 'Construya hábitos saludables';

  @override
  String get onboard_step3_message =>
      'Recibe recordatorios diarios para que nunca te pierdas una transacción. La coherencia es la clave para la libertad financiera.';

  @override
  String get create_first_wallet => 'Crea tu primera billetera';

  @override
  String get welcome_create_wallet =>
      '¡Bienvenido a Spend Flow!\nCreemos su primera billetera para comenzar.';

  @override
  String get enter_wallet_name => 'Ingrese el nombre de la billetera';

  @override
  String get eg_my_wallet =>
      'por ejemplo, Mi billetera, Efectivo, Tarjeta de crédito';

  @override
  String get currency_unit => 'Unidad monetaria';

  @override
  String get create_wallet => 'Crear billetera';

  @override
  String get please_enter_wallet_name =>
      'Por favor ingrese el nombre de la billetera.';

  @override
  String get add_wallet => 'Agregar nueva billetera';

  @override
  String get wallet_name => 'Nombre de la billetera';

  @override
  String get add_wallet_description =>
      'Agregue más billeteras para administrar y realizar un seguimiento de sus finanzas de manera más efectiva.';

  @override
  String get cannot_delete_last_wallet =>
      'No puede eliminar la última billetera.';

  @override
  String get delete_wallet => 'Eliminar billetera';

  @override
  String delete_wallet_confirmation(String walletName) {
    return '¿Está seguro de que desea eliminar la billetera \'$walletName\'? Esta acción no se puede deshacer.';
  }

  @override
  String get in_use => 'En uso';

  @override
  String get incomplete_details => 'Detalles incompletos';

  @override
  String get please_fill_required_fields =>
      'Por favor complete los siguientes campos obligatorios para continuar:';

  @override
  String get select_wallet => 'Seleccionar billetera';

  @override
  String get please_create_wallet_first =>
      'Debes crear una billetera antes de agregar una transacción.';

  @override
  String get create_now => 'Crear ahora';

  @override
  String get no_wallets_yet => 'Aún no hay billeteras';

  @override
  String get login => 'Acceso';

  @override
  String get register => 'Registro';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get new_password => 'Nueva contraseña';

  @override
  String get enter_email => 'Introduce tu correo electrónico';

  @override
  String get enter_your_password => 'Introduce tu contraseña';

  @override
  String get confirm_password => 'confirmar Contraseña';

  @override
  String get confirm_your_password => 'Confirma tu contraseña';

  @override
  String get passwords_match => 'Las contraseñas coinciden.';

  @override
  String get passwords_mismatch => 'Las contraseñas no coinciden.';

  @override
  String get forgot_password => '¿Has olvidado tu contraseña?';

  @override
  String get description_forgot_password =>
      'Ingrese el correo electrónico asociado con su cuenta para restablecer su contraseña.';

  @override
  String get send_otp => 'Enviar OTP';

  @override
  String get enter_otp => 'Ingrese la OTP';

  @override
  String get resend => 'Reenviar';

  @override
  String get verify => 'Verificar';

  @override
  String get no_otp => '¿No recibes el código?';

  @override
  String get verify_otp => 'Verificar OTP';

  @override
  String get we_sent_otp =>
      'Por favor revise su correo electrónico para ver el código OTP. No olvides revisar tu carpeta de Spam o Basura si no la ves en tu bandeja de entrada.';

  @override
  String get dont_receive_otp => '¿No recibiste la OTP?';

  @override
  String get plese_enter_valid_otp => 'Ingrese un código OTP válido.';

  @override
  String get otp_resent => 'El código OTP se reenvía correctamente.';

  @override
  String get register_successful => '¡Registro exitoso!';

  @override
  String get register_successful_description =>
      'Su cuenta ha sido creada exitosamente. Ahora puede iniciar sesión con sus credenciales.';

  @override
  String get no_account => '¿No tienes una cuenta?';

  @override
  String get have_account => '¿Ya tienes una cuenta?';

  @override
  String get login_error => 'Correo electrónico o contraseña no válidos';

  @override
  String get register_error => 'Registro fallido';

  @override
  String get create_account => 'Crear una cuenta';

  @override
  String get create_password => 'Crear nueva contraseña';

  @override
  String get create_new_password => '¡Casi llegamos! Crea tu nueva contraseña.';

  @override
  String get or_continue_with => 'O continuar con';

  @override
  String sign_in_with(String provider) {
    return 'Iniciar sesión con$provider';
  }

  @override
  String get check_your_mail => 'revisa tu correo';

  @override
  String get we_have_sent_mail => 'Hemos enviado un correo electrónico a:';

  @override
  String get please_check_your_mail_to_verify_account =>
      'Por favor revise su correo electrónico para verificar su cuenta antes de iniciar sesión.';

  @override
  String get register_failed => 'Registro fallido';

  @override
  String get please_fill_all_fields => 'Por favor complete todos los campos.';

  @override
  String get please_enter_email_and_password =>
      'Por favor ingrese el correo electrónico y la contraseña.';

  @override
  String get incorrect_email_or_password =>
      'Correo electrónico o contraseña incorrectos.';

  @override
  String get invalid_email_format => 'Formato de correo electrónico no válido.';

  @override
  String get this_account_has_been_disabled =>
      'Esta cuenta ha sido deshabilitada.';

  @override
  String get too_many_requests_please_try_later =>
      'Demasiadas solicitudes. Inténtelo de nuevo más tarde.';

  @override
  String get email_not_verified => 'Correo electrónico no verificado';

  @override
  String get please_verify_your_email_to_continue =>
      'Por favor verifique su correo electrónico para continuar.';

  @override
  String get are_you_sure_logout => '¿Está seguro de que desea cerrar sesión?';

  @override
  String get have_error_occurred =>
      'Ha ocurrido un error. Por favor inténtalo de nuevo.';

  @override
  String get user_not_found =>
      'No se encontró ninguna cuenta con este correo electrónico.';

  @override
  String get enter_otp_reset_password =>
      'Hemos enviado un código OTP a su correo electrónico. Ingrese la OTP para restablecer su contraseña.';

  @override
  String get not_time_yet_to_resend_otp =>
      'Espere un momento mientras reenviamos el código OTP.';

  @override
  String get reset_password_successful =>
      'Restablecimiento de contraseña exitoso';

  @override
  String get reset_password_successful_description =>
      'Su contraseña se ha restablecido correctamente. Ahora puedes iniciar sesión con tu nueva contraseña.';

  @override
  String get welcome_back => 'Bienvenido de nuevo';

  @override
  String get back_login => 'Volver a iniciar sesión';

  @override
  String get description_create_account =>
      'Toma el control de tus finanzas hoy';

  @override
  String get label_weak => 'Débil';

  @override
  String get label_fair => 'Justo';

  @override
  String get label_good => 'Bien';

  @override
  String get label_strong => 'Fuerte';

  @override
  String get low_pass =>
      'Debe tener al menos 8 caracteres, con un número y un símbolo.';

  @override
  String get weak_pass => 'Demasiado corto. Por favor agregue más caracteres.';

  @override
  String get fair_pass => 'Mejor. ¡Intenta sumar números y símbolos!';

  @override
  String get good_pass_char =>
      '¡Casi llegamos! Agrega un personaje especial para hacerlo más fuerte.';

  @override
  String get good_pass_num =>
      '¡Casi llegamos! Agrega un número para hacerlo más fuerte.';

  @override
  String get good_pass_special =>
      '¡Casi llegamos! Agrega cualquier personaje para hacerlo más fuerte.';

  @override
  String get strong_pass => '¡Excelente! Tu contraseña es segura.';

  @override
  String get password_reset_email_sent =>
      'Hemos enviado un enlace para restablecer la contraseña a su correo electrónico.';

  @override
  String get forgot_password_description =>
      'Ingrese el correo electrónico asociado con su cuenta para restablecer su contraseña.';

  @override
  String get send_email_reset => 'Enviar correo electrónico Restablecer';

  @override
  String get password_weak_password =>
      'La contraseña proporcionada es demasiado débil.';

  @override
  String get please_edit_fields =>
      'Edite los siguientes campos para continuar:';

  @override
  String get something_went_wrong =>
      'Algo salió mal. Por favor inténtalo de nuevo.';

  @override
  String get email_already_in_use =>
      'La dirección de correo electrónico ya está en uso en otra cuenta.';

  @override
  String get invalid_email =>
      'La dirección de correo electrónico no es válida.';

  @override
  String get operation_not_allowed =>
      'Operación no permitida. Por favor contacte al soporte.';

  @override
  String get network_error =>
      'Error de red. Por favor verifique su conexión e inténtelo nuevamente.';

  @override
  String get reset_password => 'Restablecer contraseña';

  @override
  String get email_not_received => '¿No se recibió el correo electrónico?';

  @override
  String get verification_email_sent =>
      'Correo electrónico de verificación enviado';

  @override
  String get good_morning => 'Buen día';

  @override
  String get good_afternoon => 'Buenas tardes';

  @override
  String get good_evening => 'Buenas noches';

  @override
  String get hello => 'Hola';

  @override
  String get income => 'Ingreso';

  @override
  String get expenses => 'Gastos';

  @override
  String get balance => 'Balance';

  @override
  String get total_balance => 'Saldo Total';

  @override
  String get spending_this_month => 'Gastar este mes';

  @override
  String get total_spent => 'Total gastado';

  @override
  String get recent_transactions => 'Transacciones recientes';

  @override
  String get add_transaction => 'Agregar transacción';

  @override
  String get no_transactions => 'No hay datos disponibles';

  @override
  String get enter_transaction_name => 'Introduzca el nombre de la transacción';

  @override
  String get suggested_category => 'Categoría sugerida';

  @override
  String get category => 'Categoría';

  @override
  String get categories => 'Categorías';

  @override
  String get select_category => 'Seleccionar categoría';

  @override
  String get edit_category => 'Editar categoría';

  @override
  String are_you_sure_delete_category(String categoryName) {
    return '¿Está seguro de que desea eliminar$categoryName?';
  }

  @override
  String get system_category =>
      'Las categorías del sistema no se pueden eliminar.';

  @override
  String get system_category_description =>
      'No puede editar ni eliminar esta categoría predeterminada.';

  @override
  String get category_food => 'Alimento';

  @override
  String get category_transport => 'Transporte';

  @override
  String get category_salary => 'Salario';

  @override
  String get category_shopping => 'Compras';

  @override
  String get category_game => 'Juego';

  @override
  String get category_house => 'Casa';

  @override
  String get category_gift => 'Regalo';

  @override
  String get category_health => 'Salud';

  @override
  String get category_entertainment => 'Entretenimiento';

  @override
  String get category_bill => 'Facturas';

  @override
  String get category_insurance => 'Seguro';

  @override
  String get category_education => 'Educación';

  @override
  String get category_pet => 'Mascota';

  @override
  String get category_travel => 'Viajar';

  @override
  String get category_savings => 'Ahorros';

  @override
  String get category_phone => 'Teléfono';

  @override
  String get category_internet => 'Internet';

  @override
  String get category_water => 'Agua';

  @override
  String get category_electricity => 'Electricidad';

  @override
  String get category_gas => 'Gas';

  @override
  String get category_cleaning => 'Limpieza';

  @override
  String get category_beauty => 'Belleza';

  @override
  String get category_baby => 'Bebé';

  @override
  String get category_sport => 'Deporte';

  @override
  String get category_music => 'Música';

  @override
  String get category_repair => 'Reparar';

  @override
  String get category_tax => 'Impuesto';

  @override
  String get note => 'Nota (opcional)';

  @override
  String get enter_note => 'Introducir nota';

  @override
  String get add_income => 'Agregar ingresos';

  @override
  String get add_expense => 'Agregar gastos';

  @override
  String get search_category => 'Categoría de búsqueda';

  @override
  String get no_category_found => 'No se encontró ninguna categoría';

  @override
  String get most_used => 'Más utilizado';

  @override
  String get category_suggestions => 'Sugerencias de categorías';

  @override
  String get all_categories => 'Todas las categorías';

  @override
  String get new_category => 'Nueva categoría';

  @override
  String get category_name => 'Nombre de categoría';

  @override
  String get category_color => 'Categoría Color';

  @override
  String get category_icon => 'Icono de categoría';

  @override
  String get vs_last_month => 'vs el mes pasado';

  @override
  String get transaction => 'Transacción';

  @override
  String get delete_transaction => 'Eliminar transacción';

  @override
  String get delete_transaction_confirmation =>
      '¿Está seguro de que desea eliminar esta transacción?';

  @override
  String get transaction_details => 'Detalles de la transacción';

  @override
  String get spending_trend => 'Tendencia del gasto';

  @override
  String get spending_last_7_days => 'Gasto en los últimos 7 días';

  @override
  String get note_2 => 'Nota';

  @override
  String get scan_receipt => 'Escanear recibo';

  @override
  String get add_via_voice => 'Agregar por voz';

  @override
  String get add_manually => 'Agregar manualmente';

  @override
  String get limit_reached => 'Límite alcanzado';

  @override
  String limit_reached_description(String featureName, String limit) {
    return 'Has usado$featureName${limit}veces hoy.\nVuelve mañana o actualiza a Premium.';
  }

  @override
  String get align_receipt => 'Alinea tu recibo';

  @override
  String get listening => 'Escuchando...';

  @override
  String get voice_example => 'por ejemplo, gasté 50 dólares en comestibles';

  @override
  String get tap_to_stop => 'Toque para detener';

  @override
  String get tap_to_listen => 'Toca para escuchar';

  @override
  String get yesterday => 'Ayer';

  @override
  String get your_monthly_budget => 'Tu presupuesto mensual';

  @override
  String get spent => 'Gastado';

  @override
  String get out_of => 'fuera de';

  @override
  String get left_to_spend => 'queda para gastar';

  @override
  String get add_budget => 'Agregar presupuesto';

  @override
  String get no_budgets_yet => 'Aún no hay presupuestos';

  @override
  String get create_budget_description =>
      'Toca + para crear un límite de gasto';

  @override
  String get edit_budget => 'Editar presupuesto';

  @override
  String are_you_sure_delete_budget(String budgetName) {
    return '¿Estás seguro de que quieres eliminar?$budgetName?';
  }

  @override
  String get delete_budget => 'Eliminar presupuesto';

  @override
  String get settings => 'Ajustes';

  @override
  String get settings_description =>
      'Mantenga sus datos financieros sincronizados en todos sus dispositivos';

  @override
  String get sign_in_now => 'Iniciar sesión ahora';

  @override
  String get get_started => 'Empezar';

  @override
  String get welcome => 'Bienvenido !';

  @override
  String get general => 'General';

  @override
  String get security => 'Seguridad';

  @override
  String get privacy_and_security => 'Privacidad y seguridad';

  @override
  String get support => 'Apoyo';

  @override
  String get profile => 'Perfil';

  @override
  String get language => 'Idioma';

  @override
  String get dark_mode => 'Modo oscuro';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get appearance => 'Apariencia';

  @override
  String get currency => 'Divisa';

  @override
  String get about => 'Acerca de';

  @override
  String get terms_of_service => 'Términos de servicio';

  @override
  String get privacy_policy => 'política de privacidad';

  @override
  String get version => 'Versión';

  @override
  String get edit_profile => 'Editar perfil';

  @override
  String get full_name => 'Nombre completo';

  @override
  String get enter_full_name => 'Introduce el nombre completo';

  @override
  String get email_address => 'Dirección de correo electrónico';

  @override
  String get enter_email_address =>
      'Introduzca la dirección de correo electrónico';

  @override
  String get phone_number => 'Número de teléfono';

  @override
  String get enter_phone_number => 'Introduce el número de teléfono';

  @override
  String get day_of_birth => 'Fecha de nacimiento';

  @override
  String get select_day_of_birth => 'Selecciona fecha de nacimiento';

  @override
  String get save_changes => 'Guardar cambios';

  @override
  String get profile_updated_success => '¡Perfil actualizado exitosamente!';

  @override
  String get error_updating_profile => 'Error al actualizar el perfil.';

  @override
  String get error_uploading_avatar => 'Error al cargar avatar.';

  @override
  String get require_premium_to_edit_avatar =>
      'Debes actualizar a Premium o ver anuncios para editar tu avatar.';

  @override
  String get edit_avatar => 'Editar avatar';

  @override
  String get upgrade_premium => '¡Actualízate a Premium!';

  @override
  String get upgrade_premium_description =>
      'Desbloquea funciones exclusivas y mejora tu experiencia.';

  @override
  String get upgrade_now => 'Actualiza ahora';

  @override
  String get you_are_premium => '¡Ya está todo listo, usuario Premium!';

  @override
  String get you_are_premium_description =>
      'Disfrute de su experiencia mejorada.';

  @override
  String get import_export_data => 'Importar/exportar datos';

  @override
  String get sync_data => 'Sincronizar datos';

  @override
  String continue_with(String price) {
    return 'Continuar con$price';
  }

  @override
  String get biometric_authentication => 'Autenticación biométrica';

  @override
  String get password_security => 'Seguridad de contraseña';

  @override
  String get face_id_description =>
      'Desbloquea tu aplicación con un vistazo. Face ID ofrece un acceso cómodo y seguro utilizando sus rasgos faciales únicos.';

  @override
  String get touch_id_description =>
      'Desbloquea tu aplicación con un toque. Touch ID proporciona acceso rápido y seguro mediante su huella digital.';

  @override
  String get pass_code_description =>
      'Añade una capa extra de protección. Un código de acceso garantiza que solo usted pueda acceder a sus datos financieros, incluso si su dispositivo está comprometido.';

  @override
  String get passcode => 'Código de acceso';

  @override
  String get change_passcode => 'Cambiar contraseña';

  @override
  String get old_passcode => 'Código de acceso antiguo';

  @override
  String get enter_old_passcode => 'Ingrese la contraseña anterior';

  @override
  String get new_passcode => 'Nueva contraseña';

  @override
  String get enter_new_passcode => 'Ingrese una nueva contraseña';

  @override
  String get confirm_new_passcode => 'Confirmar nueva contraseña';

  @override
  String get enter_confirm_new_passcode => 'Ingrese confirmar nueva contraseña';

  @override
  String get turnOffPasscode => 'Desactivar contraseña';

  @override
  String get createPasscode => 'Crear contraseña';

  @override
  String get changePasscode => 'Cambiar contraseña';

  @override
  String get removePasscode => 'Eliminar contraseña';

  @override
  String get updatePasscode => 'Actualizar contraseña';

  @override
  String get description_create_passcode =>
      'Proteja su cuenta actualizando periódicamente su contraseña de 6 dígitos.';

  @override
  String get description_remove_passcode =>
      'Ingrese su contraseña actual para desactivar la seguridad.';

  @override
  String get currentPasscode => 'Código de acceso actual';

  @override
  String get enterCurrentPin => 'Ingrese el PIN actual';

  @override
  String get passcode_turn_off_success =>
      '¡La contraseña se desactivó correctamente!';

  @override
  String get passcode_update_success =>
      '¡Código de acceso actualizado exitosamente!';

  @override
  String get passcode_create_success =>
      '¡Código de acceso creado exitosamente!';

  @override
  String get currentPasscodeIncorrect => 'La contraseña actual es incorrecta.';

  @override
  String get errorSavingData => 'Error al guardar datos.';

  @override
  String get newPasscodeMustBe6Digits =>
      'La nueva contraseña debe tener 6 dígitos.';

  @override
  String get passcodesDoNotMatch => 'Las contraseñas no coinciden.';

  @override
  String get enter_passcode => 'Ingrese la contraseña';

  @override
  String get incorrect_passcode => 'Código de acceso incorrecto.';

  @override
  String get face => 'identificación facial';

  @override
  String get fingerprint => 'Huella dactilar';

  @override
  String get report_locked => 'Contenido bloqueado';

  @override
  String get unlock => 'Descubrir';

  @override
  String get click_to_unlock => 'Haga clic para desbloquear';

  @override
  String get unlock_untilimited_access => 'Desbloquear acceso ilimitado';

  @override
  String get unlock_untilimited_access_description =>
      'Actualice a Premium para eliminar todos los límites y acceder a funciones avanzadas.';

  @override
  String get daily_input_cap_reached => 'Límite de entrada diario alcanzado';

  @override
  String get daily_input_cap_reached_description =>
      'Has alcanzado tu límite diario de escaneos de facturas y entradas de voz. Actualice ahora para continuar.';

  @override
  String get feature_comparison => 'Comparación de características';

  @override
  String get feature => 'Característica';

  @override
  String get free => 'Gratis';

  @override
  String get premium => 'De primera calidad';

  @override
  String get no_ads => 'Sin anuncios';

  @override
  String get transaction_locking => 'Bloqueo de transacciones';

  @override
  String get unlimited_scans => 'Escaneos de facturas ilimitados';

  @override
  String get unlimited_voice_entries => 'Entradas de voz ilimitadas';

  @override
  String get day => 'día';

  @override
  String get year => 'Año';

  @override
  String get subscription_auto_renews =>
      'La suscripción se renueva automáticamente.';

  @override
  String get accept_terms_conditions =>
      'La suscripción se renueva automáticamente. Al continuar, aceptas nuestros Términos de servicio y Política de privacidad.';

  @override
  String get restore => 'Restaurar';

  @override
  String used_up_daily_limit(String value) {
    return 'Has agotado tu límite de entrada de voz para hoy. Mire un anuncio para obtener${value}usos más o actualice a Premium.';
  }

  @override
  String get monthly_plan => 'Plan Mensual';

  @override
  String get yearly_plan => 'Plan Anual';

  @override
  String get lifetime_plan => 'Plan de por vida';

  @override
  String get pay_once_enjoy_forever => 'Paga una vez, disfruta para siempre';

  @override
  String get yearly_discount => 'Ahorre 20% con el plan anual';

  @override
  String get best_value => 'MEJOR VALOR';

  @override
  String get transaction_cancelled => 'Transacción cancelada.';

  @override
  String get purchase_successful => '¡Compra exitosa!';

  @override
  String get purchase_successful_description =>
      '¡Gracias por actualizar a Premium! Disfrute de su experiencia mejorada.';

  @override
  String get restore_successful => '¡Restauración exitosa!';

  @override
  String get restore_successful_description =>
      'Su compra anterior ha sido restaurada. ¡Disfruta de tus funciones Premium!';

  @override
  String get nothing_to_restore => 'Nada que restaurar';

  @override
  String get nothing_to_restore_description =>
      'No se encontraron compras anteriores para restaurar.';

  @override
  String get restore_failed => 'Restauración fallida';

  @override
  String get restore_failed_description =>
      'Se produjo un error al restaurar su compra. Por favor inténtalo de nuevo.';

  @override
  String get purchase_failed => 'Compra fallida';

  @override
  String get purchase_failed_description =>
      'Se produjo un error durante la transacción. Por favor inténtalo de nuevo.';

  @override
  String get purchase_canceled => 'Compra cancelada';

  @override
  String get purchase_canceled_description =>
      'La transacción fue cancelada. No se realizaron cambios en su cuenta.';

  @override
  String get premium_sync_account =>
      'Su cuenta Premium se sincronizará con la cuenta en la que inicie sesión. Asegúrese de iniciar sesión con la misma cuenta en todos sus dispositivos para disfrutar de una experiencia Premium perfecta.';

  @override
  String get premium_sync_warning =>
      'Nota: Si compró un paquete Premium en una cuenta diferente, inicie sesión en esa cuenta para restaurar su acceso Premium. Si está utilizando la misma cuenta, intente restaurar su compra para sincronizar su acceso Premium.';

  @override
  String get select_language => 'Seleccionar idioma';

  @override
  String get suggested => 'sugerido';

  @override
  String get all_languages => 'Todos los idiomas';

  @override
  String get apply_changes => 'Aplicar cambios';

  @override
  String get select_currency => 'Seleccionar moneda';

  @override
  String get search_currency => 'Buscar moneda o país...';

  @override
  String get popular => 'Popular';

  @override
  String get all_currencies => 'Todas las monedas';

  @override
  String get currency_change_warning =>
      'Cambiar la moneda solo actualizará el símbolo de visualización. Las tasas de transacciones anteriores no se volverán a calcular.';

  @override
  String see_ads(String additionalUses) {
    return 'Ver Anuncios (+${additionalUses}usos)';
  }

  @override
  String get ads_loading => 'Anuncios Cargando...';

  @override
  String get data_management => 'Gestión de datos';

  @override
  String get select_format => 'Seleccionar formato';

  @override
  String get export_data => 'Exportar datos';

  @override
  String get export_data_description =>
      'Exporte sus datos financieros para realizar copias de seguridad o análisis.';

  @override
  String get confirm_export => 'Confirmar exportación';

  @override
  String get import_data => 'Importar datos';

  @override
  String get import_data_title => 'Consigamos tu';

  @override
  String get data => 'datos';

  @override
  String get import_data_title_2 => 'en.';

  @override
  String get import_data_description =>
      'Importe datos financieros de fuentes externas para sincronizarlos con la aplicación.';

  @override
  String get confirm_import => 'Confirmar importación';

  @override
  String get csv_format => 'Formato CSV';

  @override
  String get csv_description =>
      'Exporte datos en formato CSV, compatible con la mayoría de aplicaciones de hojas de cálculo.';

  @override
  String get json_format => 'Formato JSON';

  @override
  String get json_description =>
      'Exporte datos en formato JSON, adecuado para desarrolladores y usuarios avanzados.';

  @override
  String get excel_format => 'Formato Excel';

  @override
  String get excel_description =>
      'Exporte datos en formato Excel, ideal para análisis financieros detallados.';

  @override
  String get select_file => 'Seleccionar archivo';

  @override
  String get no_file_selected => 'Ningún archivo seleccionado.';

  @override
  String get import_successful => 'Importación exitosa';

  @override
  String get error_importing_data =>
      'Error al importar datos. Asegúrese de que el formato del archivo sea correcto.';

  @override
  String get sync_data_now => 'Sincronizar ahora';

  @override
  String last_synced(String time) {
    return 'Última sincronización:$time';
  }

  @override
  String get syncing => 'Sincronizando...';

  @override
  String get never_synced => 'Nunca sincronizado';

  @override
  String get unauthenticated =>
      'Inicie sesión para sincronizar sus datos entre dispositivos.';

  @override
  String sync_error(String error) {
    return 'Error de sincronización:$error';
  }

  @override
  String get premium_required_to_sync =>
      'Debe actualizar a Premium o ver anuncios para sincronizar datos.';

  @override
  String get sync_in_progress => 'Sincronización en progreso, espera.';

  @override
  String cooldown(String time) {
    return 'Estás actuando demasiado rápido. Espere${time}antes de volver a sincronizar.';
  }

  @override
  String get logout_delete_local_data_message =>
      '¿Quieres eliminar datos de este dispositivo? Los datos sincronizados en la nube permanecerán seguros.';

  @override
  String get keep_local_data => 'No, solo cierra sesión';

  @override
  String get delete_local_data => 'Eliminar datos';

  @override
  String get accepted_formats => 'Formatos aceptados';

  @override
  String get select_file_to_import => 'Seleccione un archivo para importar';

  @override
  String get tap_to_browse =>
      'Toque para explorar su dispositivo o nube\nalmacenamiento de archivos.';

  @override
  String get protected => 'Protegido';

  @override
  String get protected_description =>
      'Sus datos nunca salen de su dispositivo y se procesan localmente.';

  @override
  String get recent_imports => 'Importaciones recientes';

  @override
  String get no_recent_imports => 'No hay importaciones de datos recientes';

  @override
  String get invalid_format => 'Formato de archivo no válido.';

  @override
  String get import_success => '¡Importado exitosamente!';

  @override
  String import_success_description(String count) {
    return 'Se importaron correctamente${count}transacciones del archivo.';
  }

  @override
  String get file_format_template => 'Plantilla de formato de archivo';

  @override
  String download_sample_file(String format) {
    return 'Descargar archivo de muestra$format';
  }

  @override
  String get card => 'Tarjeta';

  @override
  String get font_selection => 'Selección de fuente';

  @override
  String get select_font => 'Seleccionar fuente';

  @override
  String get font => 'Fuente';

  @override
  String get font_description =>
      'Una transacción al día mantiene alejado el \"mes de la quiebra\".';

  @override
  String get reminder_title => 'Recordatorio de gastos diarios';

  @override
  String get reminder_body => '¿Ha registrado sus gastos de hoy? 💸';

  @override
  String get defaultTransactionTitle => 'Nueva transacción';

  @override
  String get invoice_analysis => 'Analizando facturas...';

  @override
  String get mapbox_error =>
      'Error al cargar el mapa. Verifique la configuración de su token Mapbox.';

  @override
  String get location => 'Ubicación';

  @override
  String get current_location => 'Ubicación actual';

  @override
  String get select_location => 'Seleccionar Ubicación';

  @override
  String get no_location_selected => 'Ninguna ubicación seleccionada';

  @override
  String get search_location => 'Buscar ubicación...';

  @override
  String get tap_to_change_location => 'Toca para cambiar de ubicación';

  @override
  String get search_results => 'Resultados de la búsqueda';

  @override
  String get no_location_found => 'No se encontró ninguna ubicación';

  @override
  String get recent_locations => 'Ubicaciones recientes';

  @override
  String get location_access_error => 'Error de acceso a la ubicación';

  @override
  String get location_permission_denied => 'Permiso de ubicación denegado.';

  @override
  String get location_permission_denied_description =>
      'Habilite el acceso a la ubicación en la configuración.';

  @override
  String get notification_permission_denied =>
      'Permiso de notificación denegado.';

  @override
  String get notification_permission_denied_description =>
      'Habilite el acceso a notificaciones en la configuración para recibir recordatorios.';

  @override
  String get permission_required_camera => 'Acceso a la cámara denegado';

  @override
  String get permission_required_camera_description =>
      'Habilite el acceso a la cámara en la configuración para usar la función de escaneo de recibos.';

  @override
  String get voice_input_error =>
      'Error de entrada de voz. Por favor inténtalo de nuevo.';

  @override
  String get voice_input_not_recognized =>
      'Entrada de voz no reconocida. Por favor inténtalo de nuevo.';

  @override
  String get voice_input_permission_denied =>
      'Permiso de entrada de voz denegado. Habilite el acceso al micrófono en la configuración.';

  @override
  String get error_ai_request =>
      'La IA no puede reconocer esta solicitud. Por favor intenta ser más específico.';

  @override
  String get voice_analysis => 'Analizando la entrada de voz...';

  @override
  String get scan_receipt_error =>
      'Error al escanear recibos. Por favor inténtalo de nuevo.';

  @override
  String get requires_premium =>
      'Esta función requiere ver anuncios para usarla o actualizarla a Premium.';

  @override
  String get watch_ad_continue => 'Ver anuncio para continuar';

  @override
  String get permission_required_voice_input => 'Acceso al micrófono denegado';

  @override
  String get permission_required_voice_input_description =>
      'Habilite el acceso al micrófono en la configuración para usar la entrada de voz.';

  @override
  String get permission_required_location => 'Acceso a la ubicación denegado';

  @override
  String get permission_required_location_description =>
      'Habilite el acceso a la ubicación en la configuración para usar las funciones de ubicación.';

  @override
  String get congratulations => '¡Felicidades!';

  @override
  String get successfully_purchased =>
      'Has comprado Premium con éxito. ¡Disfruta de tu experiencia mejorada!';

  @override
  String get cancel_purchase => 'Cancelar compra';

  @override
  String get restore_no_purchase_description =>
      'No se encontraron compras anteriores para restaurar.';

  @override
  String get ai_powered => 'Impulsado por IA';

  @override
  String get entries_pending => 'Entradas pendientes';

  @override
  String get confirm_selected_entries => 'Agregar entradas seleccionadas';

  @override
  String get preview_results => 'Vista previa de resultados';

  @override
  String get clear_all => 'Borrar todo';

  @override
  String get select_all => 'Seleccionar todo';

  @override
  String get fail_to_save_transactions =>
      'No se pudieron guardar las transacciones. Por favor inténtalo de nuevo.';

  @override
  String get tap_to_check_in => 'Toca para registrarte';

  @override
  String get keep_your_streak => '¡Mantén tu racha!';

  @override
  String keep_your_streak_day(String streak) {
    return '¡Mantén tu racha de${streak}días!';
  }

  @override
  String get streak => 'Racha';

  @override
  String streak_days(String days) {
    return '${days}días';
  }

  @override
  String get not_logined => 'No iniciado sesión';

  @override
  String get please_login_to_sync_data =>
      'Inicie sesión para sincronizar sus datos entre dispositivos.';

  @override
  String get require_premium_to_sync =>
      'Debe actualizar a Premium o ver anuncios para sincronizar datos.';

  @override
  String get information_and_support => 'Información y soporte';

  @override
  String get contact_support => 'Contactar con soporte';

  @override
  String get send_email => 'Enviar correo electrónico';

  @override
  String get describe_issue =>
      'Describe tu problema o pregunta en detalle. Nuestro equipo de soporte se comunicará con usted lo antes posible.';

  @override
  String get feedback => 'Comentario';

  @override
  String get feedback_description =>
      'Nos encantaría escuchar sus opiniones y sugerencias para ayudarnos a mejorar SpendFlow. ¡Por favor comparte tus comentarios con nosotros!';

  @override
  String get thank_you_feedback => '¡Gracias por tus comentarios!';

  @override
  String get submit_feedback => 'Enviar comentarios';

  @override
  String get report_issue => 'Informar problema';

  @override
  String get submit_issue => 'Enviar problema';

  @override
  String get report_issue_description =>
      'Si encuentra algún error o problema, infórmelo aquí. Sus comentarios nos ayudan a mejorar la aplicación para todos.';

  @override
  String get thank_you_issue =>
      '¡Gracias por informar el problema! Lo investigaremos lo antes posible.';

  @override
  String get request_delete_account => 'Solicitar eliminación de cuenta';

  @override
  String get delete_account_description =>
      'Si desea eliminar su cuenta, háganos saber por qué desea eliminarla. Procesaremos su solicitud lo antes posible.';

  @override
  String get submit_delete_request => 'Enviar solicitud';

  @override
  String get select_subject => 'Seleccionar Asunto';

  @override
  String get please_enter_content => 'Por favor ingresa el contenido';

  @override
  String get subject => 'Sujeto';

  @override
  String get content => 'Contenido';

  @override
  String get send_contact_success =>
      '¡Tu mensaje ha sido enviado exitosamente! Nos comunicaremos con usted lo antes posible.';

  @override
  String get send_contact_error =>
      'Se produjo un error al enviar su mensaje. Por favor inténtalo de nuevo.';

  @override
  String get contact_info => 'Información del contacto';

  @override
  String get email_placeholder => 'Introduce tu correo electrónico';

  @override
  String get name_placeholder => 'Introduce tu nombre';

  @override
  String get invalid_name => 'Por favor ingrese un nombre válido.';

  @override
  String get mrs => 'Señora.';

  @override
  String get mr => 'Señor.';

  @override
  String get ms => 'EM.';

  @override
  String get salutation => 'Saludo';

  @override
  String get delete_account => 'Eliminar cuenta';

  @override
  String get delete_account_confirmation =>
      '¿Estás seguro de que quieres eliminar tu cuenta? Esta acción no se puede deshacer y eliminará todos sus datos.';

  @override
  String get failed_to_send_deletion_request =>
      'No se pudo enviar la solicitud de eliminación de cuenta. Por favor inténtalo de nuevo.';

  @override
  String get requires_recent_login_description =>
      'Por razones de seguridad, cierre sesión y vuelva a iniciar sesión antes de intentar eliminar su cuenta.';

  @override
  String get delete_account_failed =>
      'Se produjo un error al eliminar su cuenta. Por favor inténtalo de nuevo.';

  @override
  String get left => 'izquierda';

  @override
  String get edit_transaction => 'Editar transacción';

  @override
  String get save_expense_change => 'Gasto de actualización';

  @override
  String get save_income_change => 'Actualizar ingresos';

  @override
  String get transaction_updated => 'Transacción actualizada exitosamente';

  @override
  String get bank_sync => 'Sincronización bancaria';

  @override
  String get bank_sync_description =>
      'Conecte y sincronice automáticamente los feeds de transacciones de cuentas bancarias';

  @override
  String get coming_soon => 'Muy pronto';

  @override
  String get feature_under_development =>
      '¡Esta característica está actualmente en desarrollo y estará disponible en próximas actualizaciones!';

  @override
  String get remaining_budget => 'Presupuesto restante';

  @override
  String get monthly_spending => 'Cuadro de gastos mensuales';

  @override
  String get quick_add_voice => 'Toca para hablar';

  @override
  String get ad_no_fill_title => 'No hay anuncios disponibles';

  @override
  String get ad_no_fill_message =>
      'Actualmente no hay anuncios disponibles. Inténtalo de nuevo más tarde o actualiza a Premium.';

  @override
  String get ad_network_error_title => 'Error de conexión';

  @override
  String get ad_network_error_message =>
      'No se pudo conectar para cargar anuncios. Verifica tu conexión de red e intenta nuevamente.';

  @override
  String get ad_load_failed_title => 'Error al cargar anuncio';

  @override
  String get ad_load_failed_message =>
      'Ocurrió un error al cargar el anuncio. Inténtalo de nuevo más tarde.';

  @override
  String get ad_show_failed_title => 'Error de visualización';

  @override
  String get ad_show_failed_message =>
      'No se pudo mostrar el anuncio. Inténtalo de nuevo más tarde.';

  @override
  String get ad_loading_timeout_message =>
      'El anuncio tardó demasiado en cargarse. Inténtalo de nuevo más tarde.';

  @override
  String get ad_preparing => 'Preparando anuncio...';
}
