// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get app_name => 'SpendFlow';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancelar';

  @override
  String get skip => 'Pular';

  @override
  String get next => 'Próximo';

  @override
  String get confirm => 'Confirmar';

  @override
  String get save => 'Salvar';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Excluir';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get done => 'Concluído';

  @override
  String get close => 'Fechar';

  @override
  String get back => 'Voltar';

  @override
  String get start => 'Começar';

  @override
  String get continueAction => 'Continuar';

  @override
  String get view_all => 'Ver tudo';

  @override
  String get see_all => 'Ver tudo';

  @override
  String get amount => 'Valor';

  @override
  String get name => 'Nome';

  @override
  String get date => 'Data';

  @override
  String get month => 'Mês';

  @override
  String get life_time => 'Vitalício';

  @override
  String get today => 'Hoje';

  @override
  String get other => 'Outro';

  @override
  String get home => 'Início';

  @override
  String get reports => 'Relatórios';

  @override
  String get budgets => 'Orçamentos';

  @override
  String get all => 'Tudo';

  @override
  String get error => 'Erro';

  @override
  String get user => 'Usuário';

  @override
  String get success => 'Sucesso';

  @override
  String get loading => 'Carregando...';

  @override
  String get onboard_step1_title => 'Registre num piscar de olhos';

  @override
  String get onboard_step1_message =>
      'Detecte locais de gastos automaticamente para um registro mais rápido. Nunca mais se pergunte para onde foi o seu dinheiro.';

  @override
  String get onboard_step2_title => 'Domine sua carteira';

  @override
  String get onboard_step2_message =>
      'Defina limites de gastos para cada categoria. Nós ajudaremos você a alcançar suas metas financeiras.';

  @override
  String get onboard_step3_title => 'Crie hábitos saudáveis';

  @override
  String get onboard_step3_message =>
      'Receba lembretes diários para nunca esquecer uma transação. A consistência é a chave para a liberdade financeira.';

  @override
  String get create_first_wallet => 'Crie sua primeira carteira';

  @override
  String get welcome_create_wallet =>
      'Bem-vindo ao Spend Flow!\nVamos criar sua primeira carteira para começar.';

  @override
  String get enter_wallet_name => 'Digite o nome da carteira';

  @override
  String get eg_my_wallet => 'ex.: Minha Carteira, Dinheiro, Cartão de Crédito';

  @override
  String get currency_unit => 'Moeda';

  @override
  String get create_wallet => 'Criar Carteira';

  @override
  String get please_enter_wallet_name =>
      'Por favor, digite o nome da carteira.';

  @override
  String get add_wallet => 'Adicionar Nova Carteira';

  @override
  String get wallet_name => 'Nome da Carteira';

  @override
  String get add_wallet_description =>
      'Adicione mais carteiras para gerenciar e acompanhar suas finanças com mais eficiência.';

  @override
  String get cannot_delete_last_wallet =>
      'Você não pode excluir a última carteira.';

  @override
  String get delete_wallet => 'Excluir Carteira';

  @override
  String delete_wallet_confirmation(String walletName) {
    return 'Tem certeza de que deseja excluir a carteira \'$walletName\'? Esta ação não pode ser desfeita.';
  }

  @override
  String get in_use => 'Em uso';

  @override
  String get incomplete_details => 'Detalhes incompletos';

  @override
  String get please_fill_required_fields =>
      'Por favor, preencha os seguintes campos obrigatórios para continuar:';

  @override
  String get select_wallet => 'Selecionar Carteira';

  @override
  String get please_create_wallet_first =>
      'Você precisa criar uma carteira antes de adicionar uma transação.';

  @override
  String get create_now => 'Criar Agora';

  @override
  String get no_wallets_yet => 'Nenhuma carteira ainda';

  @override
  String get login => 'Entrar';

  @override
  String get register => 'Cadastrar';

  @override
  String get logout => 'Sair';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Senha';

  @override
  String get new_password => 'Nova senha';

  @override
  String get enter_email => 'Digite seu e-mail';

  @override
  String get enter_your_password => 'Digite sua senha';

  @override
  String get confirm_password => 'Confirmar Senha';

  @override
  String get confirm_your_password => 'Confirme sua senha';

  @override
  String get passwords_match => 'As senhas coincidem.';

  @override
  String get passwords_mismatch => 'As senhas não coincidem.';

  @override
  String get forgot_password => 'Esqueceu a senha?';

  @override
  String get description_forgot_password =>
      'Digite o e-mail associado à sua conta para redefinir sua senha.';

  @override
  String get send_otp => 'Enviar OTP';

  @override
  String get enter_otp => 'Digite o OTP';

  @override
  String get resend => 'Reenviar';

  @override
  String get verify => 'Verificar';

  @override
  String get no_otp => 'Não recebeu o código?';

  @override
  String get verify_otp => 'Verificar OTP';

  @override
  String get we_sent_otp =>
      'Verifique seu e-mail para obter o código OTP. Não se esqueça de checar a pasta de Spam.';

  @override
  String get dont_receive_otp => 'Não recebeu o OTP?';

  @override
  String get plese_enter_valid_otp => 'Por favor, insira um código OTP válido.';

  @override
  String get otp_resent => 'Código OTP reenviado com sucesso.';

  @override
  String get register_successful => 'Cadastro realizado com sucesso!';

  @override
  String get register_successful_description =>
      'Sua conta foi criada com sucesso. Agora você pode entrar com suas credenciais.';

  @override
  String get no_account => 'Não tem uma conta?';

  @override
  String get have_account => 'Já tem uma conta?';

  @override
  String get login_error => 'E-mail ou senha inválidos';

  @override
  String get register_error => 'Falha no cadastro';

  @override
  String get create_account => 'Criar uma Conta';

  @override
  String get create_password => 'Criar Nova Senha';

  @override
  String get create_new_password => 'Quase lá! Crie sua nova senha.';

  @override
  String get or_continue_with => 'Ou continue com';

  @override
  String sign_in_with(String provider) {
    return 'Entrar com $provider';
  }

  @override
  String get check_your_mail => 'Verifique seu e-mail';

  @override
  String get we_have_sent_mail => 'Enviamos um e-mail para:';

  @override
  String get please_check_your_mail_to_verify_account =>
      'Verifique seu e-mail para confirmar sua conta antes de fazer login.';

  @override
  String get register_failed => 'Falha no cadastro';

  @override
  String get please_fill_all_fields => 'Por favor, preencha todos os campos.';

  @override
  String get please_enter_email_and_password =>
      'Por favor, insira o e-mail e a senha.';

  @override
  String get incorrect_email_or_password => 'E-mail ou senha incorretos.';

  @override
  String get invalid_email_format => 'Formato de e-mail inválido.';

  @override
  String get this_account_has_been_disabled => 'Esta conta foi desativada.';

  @override
  String get too_many_requests_please_try_later =>
      'Muitas solicitações. Tente novamente mais tarde.';

  @override
  String get email_not_verified => 'E-mail não verificado';

  @override
  String get please_verify_your_email_to_continue =>
      'Verifique seu e-mail para continuar.';

  @override
  String get are_you_sure_logout => 'Tem certeza de que deseja sair?';

  @override
  String get have_error_occurred => 'Ocorreu um erro. Tente novamente.';

  @override
  String get user_not_found => 'Nenhuma conta encontrada com este e-mail.';

  @override
  String get enter_otp_reset_password =>
      'Enviamos um código OTP para seu e-mail. Digite o OTP para redefinir sua senha.';

  @override
  String get not_time_yet_to_resend_otp =>
      'Aguarde um momento antes de solicitar um novo código OTP.';

  @override
  String get reset_password_successful => 'Senha redefinida com sucesso';

  @override
  String get reset_password_successful_description =>
      'Sua senha foi redefinida com sucesso. Você já pode fazer login com sua nova senha.';

  @override
  String get welcome_back => 'Bem-vindo de volta';

  @override
  String get back_login => 'Voltar para o Login';

  @override
  String get description_create_account =>
      'Assuma o controle de suas finanças hoje mesmo';

  @override
  String get label_weak => 'Fraca';

  @override
  String get label_fair => 'Razoável';

  @override
  String get label_good => 'Boa';

  @override
  String get label_strong => 'Forte';

  @override
  String get low_pass =>
      'Deve ter pelo menos 8 caracteres, com um número e um símbolo.';

  @override
  String get weak_pass => 'Muito curta. Adicione mais caracteres.';

  @override
  String get fair_pass => 'Melhor. Tente adicionar números e símbolos!';

  @override
  String get good_pass_char =>
      'Quase lá! Adicione um caractere especial para torná-la mais forte.';

  @override
  String get good_pass_num =>
      'Quase lá! Adicione um número para torná-la mais forte.';

  @override
  String get good_pass_special =>
      'Quase lá! Adicione qualquer caractere para torná-la mais forte.';

  @override
  String get strong_pass => 'Ótimo! Sua senha está segura.';

  @override
  String get password_reset_email_sent =>
      'Enviamos um link de redefinição de senha para seu e-mail.';

  @override
  String get forgot_password_description =>
      'Digite o e-mail associado à sua conta para redefinir sua senha.';

  @override
  String get send_email_reset => 'Enviar E-mail de Redefinição';

  @override
  String get password_weak_password => 'A senha fornecida é muito fraca.';

  @override
  String get please_edit_fields =>
      'Por favor, edite os seguintes campos para prosseguir:';

  @override
  String get something_went_wrong => 'Algo deu errado. Tente novamente.';

  @override
  String get email_already_in_use =>
      'O endereço de e-mail já está em uso por outra conta.';

  @override
  String get invalid_email => 'O endereço de e-mail não é válido.';

  @override
  String get operation_not_allowed =>
      'Operação não permitida. Entre em contato com o suporte.';

  @override
  String get network_error =>
      'Erro de rede. Verifique sua conexão e tente novamente.';

  @override
  String get reset_password => 'Redefinir Senha';

  @override
  String get email_not_received => 'Não recebeu o e-mail?';

  @override
  String get verification_email_sent => 'E-mail de verificação enviado';

  @override
  String get good_morning => 'Bom dia';

  @override
  String get good_afternoon => 'Boa tarde';

  @override
  String get good_evening => 'Boa noite';

  @override
  String get hello => 'Olá';

  @override
  String get income => 'Receita';

  @override
  String get expenses => 'Despesas';

  @override
  String get balance => 'Saldo';

  @override
  String get total_balance => 'Saldo Total';

  @override
  String get spending_this_month => 'Gastos deste mês';

  @override
  String get total_spent => 'Total Gasto';

  @override
  String get recent_transactions => 'Transações Recentes';

  @override
  String get add_transaction => 'Adicionar Transação';

  @override
  String get no_transactions => 'Nenhum dado disponível';

  @override
  String get enter_transaction_name => 'Digite o nome da transação';

  @override
  String get suggested_category => 'Categoria Sugerida';

  @override
  String get category => 'Categoria';

  @override
  String get categories => 'Categorias';

  @override
  String get select_category => 'Selecionar Categoria';

  @override
  String get edit_category => 'Editar Categoria';

  @override
  String are_you_sure_delete_category(String categoryName) {
    return 'Tem certeza de que deseja excluir $categoryName?';
  }

  @override
  String get system_category =>
      'Categorias do sistema não podem ser excluídas.';

  @override
  String get system_category_description =>
      'Você não pode editar nem excluir esta categoria padrão.';

  @override
  String get category_food => 'Alimentação';

  @override
  String get category_transport => 'Transporte';

  @override
  String get category_salary => 'Salário';

  @override
  String get category_shopping => 'Compras';

  @override
  String get category_game => 'Jogos';

  @override
  String get category_house => 'Moradia';

  @override
  String get category_gift => 'Presentes';

  @override
  String get category_health => 'Saúde';

  @override
  String get category_entertainment => 'Entretenimento';

  @override
  String get category_bill => 'Contas';

  @override
  String get category_insurance => 'Seguro';

  @override
  String get category_education => 'Educação';

  @override
  String get category_pet => 'Animais';

  @override
  String get category_travel => 'Viagens';

  @override
  String get category_savings => 'Poupança';

  @override
  String get category_phone => 'Telefone';

  @override
  String get category_internet => 'Internet';

  @override
  String get category_water => 'Água';

  @override
  String get category_electricity => 'Energia';

  @override
  String get category_gas => 'Gás';

  @override
  String get category_cleaning => 'Limpeza';

  @override
  String get category_beauty => 'Beleza';

  @override
  String get category_baby => 'Bebê';

  @override
  String get category_sport => 'Esporte';

  @override
  String get category_music => 'Música';

  @override
  String get category_repair => 'Reparos';

  @override
  String get category_tax => 'Impostos';

  @override
  String get note => 'Nota (opcional)';

  @override
  String get enter_note => 'Digite uma nota';

  @override
  String get add_income => 'Adicionar Receita';

  @override
  String get add_expense => 'Adicionar Despesa';

  @override
  String get search_category => 'Pesquisar Categoria';

  @override
  String get no_category_found => 'Nenhuma categoria encontrada';

  @override
  String get most_used => 'Mais Usadas';

  @override
  String get category_suggestions => 'Sugestões de Categorias';

  @override
  String get all_categories => 'Todas as Categorias';

  @override
  String get new_category => 'Nova Categoria';

  @override
  String get category_name => 'Nome da Categoria';

  @override
  String get category_color => 'Cor da Categoria';

  @override
  String get category_icon => 'Ícone da Categoria';

  @override
  String get vs_last_month => 'em relação ao mês passado';

  @override
  String get transaction => 'Transação';

  @override
  String get delete_transaction => 'Excluir Transação';

  @override
  String get delete_transaction_confirmation =>
      'Tem certeza de que deseja excluir esta transação?';

  @override
  String get transaction_details => 'Detalhes da Transação';

  @override
  String get spending_trend => 'Tendência de Gastos';

  @override
  String get spending_last_7_days => 'Gastos nos Últimos 7 Dias';

  @override
  String get note_2 => 'Nota';

  @override
  String get scan_receipt => 'Escanear Recibo';

  @override
  String get add_via_voice => 'Adicionar por Voz';

  @override
  String get add_manually => 'Adicionar Manualmente';

  @override
  String get limit_reached => 'Limite Atingido';

  @override
  String limit_reached_description(String featureName, String limit) {
    return 'Você usou $featureName $limit vezes hoje.\nVolte amanhã ou faça upgrade para o Premium.';
  }

  @override
  String get align_receipt => 'Alinhe seu recibo';

  @override
  String get listening => 'Ouvindo...';

  @override
  String get voice_example => 'ex.: Gastei 50 reais no supermercado';

  @override
  String get tap_to_stop => 'Toque para Parar';

  @override
  String get tap_to_listen => 'Toque para Falar';

  @override
  String get yesterday => 'Ontem';

  @override
  String get your_monthly_budget => 'Seu Orçamento Mensal';

  @override
  String get spent => 'Gasto ';

  @override
  String get out_of => ' de ';

  @override
  String get left_to_spend => 'restante para gastar';

  @override
  String get add_budget => 'Adicionar Orçamento';

  @override
  String get no_budgets_yet => 'Nenhum orçamento ainda';

  @override
  String get create_budget_description =>
      'Toque em + para definir um limite de gastos';

  @override
  String get edit_budget => 'Editar Orçamento';

  @override
  String are_you_sure_delete_budget(String budgetName) {
    return 'Tem certeza de que deseja excluir \n $budgetName?';
  }

  @override
  String get delete_budget => 'Excluir Orçamento';

  @override
  String get settings => 'Configurações';

  @override
  String get settings_description =>
      'Mantenha seus dados financeiros sincronizados em todos os seus dispositivos';

  @override
  String get sign_in_now => 'Entrar agora';

  @override
  String get get_started => 'Começar';

  @override
  String get welcome => 'Bem-vindo!';

  @override
  String get general => 'Geral';

  @override
  String get security => 'Segurança';

  @override
  String get privacy_and_security => 'Privacidade e Segurança';

  @override
  String get support => 'Suporte';

  @override
  String get profile => 'Perfil';

  @override
  String get language => 'Idioma';

  @override
  String get dark_mode => 'Modo Escuro';

  @override
  String get notifications => 'Notificações';

  @override
  String get appearance => 'Aparência';

  @override
  String get currency => 'Moeda';

  @override
  String get about => 'Sobre';

  @override
  String get terms_of_service => 'Termos de Serviço';

  @override
  String get privacy_policy => 'Política de Privacidade';

  @override
  String get version => 'Versão';

  @override
  String get edit_profile => 'Editar Perfil';

  @override
  String get full_name => 'Nome Completo';

  @override
  String get enter_full_name => 'Digite seu nome completo';

  @override
  String get email_address => 'Endereço de E-mail';

  @override
  String get enter_email_address => 'Digite seu e-mail';

  @override
  String get phone_number => 'Número de Telefone';

  @override
  String get enter_phone_number => 'Digite seu telefone';

  @override
  String get day_of_birth => 'Data de Nascimento';

  @override
  String get select_day_of_birth => 'Selecione a data de nascimento';

  @override
  String get save_changes => 'Salvar Alterações';

  @override
  String get profile_updated_success => 'Perfil atualizado com sucesso!';

  @override
  String get error_updating_profile => 'Erro ao atualizar o perfil.';

  @override
  String get error_uploading_avatar => 'Erro ao carregar avatar.';

  @override
  String get require_premium_to_edit_avatar =>
      'Faça upgrade para o Premium ou assista a um anúncio para editar seu avatar.';

  @override
  String get edit_avatar => 'Editar Avatar';

  @override
  String get upgrade_premium => 'Upgrade para o Premium!';

  @override
  String get upgrade_premium_description =>
      'Desbloqueie recursos exclusivos e aprimore sua experiência.';

  @override
  String get upgrade_now => 'Assinar Agora';

  @override
  String get you_are_premium => 'Tudo pronto, Usuário Premium!';

  @override
  String get you_are_premium_description =>
      'Aproveite sua experiência avançada.';

  @override
  String get import_export_data => 'Importar / Exportar Dados';

  @override
  String get sync_data => 'Sincronizar Dados';

  @override
  String continue_with(String price) {
    return 'Continuar com $price';
  }

  @override
  String get biometric_authentication => 'Autenticação Biométrica';

  @override
  String get password_security => 'Segurança por Senha';

  @override
  String get face_id_description =>
      'Desbloqueie seu app com um olhar. O Face ID oferece acesso rápido e seguro.';

  @override
  String get touch_id_description =>
      'Desbloqueie seu app com um toque usando sua impressão digital.';

  @override
  String get pass_code_description =>
      'Camada extra de proteção. Um código garante que apenas você acesse seus dados financeiros.';

  @override
  String get passcode => 'Código de Acesso';

  @override
  String get change_passcode => 'Alterar Código de Acesso';

  @override
  String get old_passcode => 'Código Antigo';

  @override
  String get enter_old_passcode => 'Digite o código antigo';

  @override
  String get new_passcode => 'Novo Código';

  @override
  String get enter_new_passcode => 'Digite o novo código';

  @override
  String get confirm_new_passcode => 'Confirmar Novo Código';

  @override
  String get enter_confirm_new_passcode => 'Digite a confirmação do código';

  @override
  String get turnOffPasscode => 'Desativar Código de Acesso';

  @override
  String get createPasscode => 'Criar Código de Acesso';

  @override
  String get changePasscode => 'Alterar Código de Acesso';

  @override
  String get removePasscode => 'Remover Código de Acesso';

  @override
  String get updatePasscode => 'Atualizar Código de Acesso';

  @override
  String get description_create_passcode =>
      'Proteja sua conta atualizando seu código de 6 dígitos regularmente.';

  @override
  String get description_remove_passcode =>
      'Digite seu código atual para desativar a segurança.';

  @override
  String get currentPasscode => 'Código Atual';

  @override
  String get enterCurrentPin => 'Digite o PIN atual';

  @override
  String get passcode_turn_off_success =>
      'Código de acesso desativado com sucesso!';

  @override
  String get passcode_update_success =>
      'Código de acesso atualizado com sucesso!';

  @override
  String get passcode_create_success => 'Código de acesso criado com sucesso!';

  @override
  String get currentPasscodeIncorrect => 'O código atual está incorreto.';

  @override
  String get errorSavingData => 'Erro ao salvar dados.';

  @override
  String get newPasscodeMustBe6Digits => 'O novo código deve ter 6 dígitos.';

  @override
  String get passcodesDoNotMatch => 'Os códigos não coincidem.';

  @override
  String get enter_passcode => 'Digite o Código de Acesso';

  @override
  String get incorrect_passcode => 'Código de acesso incorreto.';

  @override
  String get face => 'Face ID';

  @override
  String get fingerprint => 'Impressão Digital';

  @override
  String get report_locked => 'Conteúdo Bloqueado';

  @override
  String get unlock => 'Desbloquear';

  @override
  String get click_to_unlock => 'Clique para Desbloquear';

  @override
  String get unlock_untilimited_access => 'Desbloqueie Acesso Ilimitado';

  @override
  String get unlock_untilimited_access_description =>
      'Faça upgrade para o Premium para remover todos os limites e acessar recursos avançados.';

  @override
  String get daily_input_cap_reached => 'Limite Diário Atingido';

  @override
  String get daily_input_cap_reached_description =>
      'Você atingiu o limite diário de leitura de notas e entrada por voz. Faça upgrade para continuar.';

  @override
  String get feature_comparison => 'Comparação de Recursos';

  @override
  String get feature => 'Recurso';

  @override
  String get free => 'Gratuito';

  @override
  String get premium => 'Premium';

  @override
  String get no_ads => 'Sem Anúncios';

  @override
  String get transaction_locking => 'Bloqueio de Transações';

  @override
  String get unlimited_scans => 'Leitura de Recibos Ilimitada';

  @override
  String get unlimited_voice_entries => 'Entradas por Voz Ilimitadas';

  @override
  String get day => 'dia';

  @override
  String get year => 'ano';

  @override
  String get subscription_auto_renews =>
      'A assinatura é renovada automaticamente.';

  @override
  String get accept_terms_conditions =>
      'A assinatura é renovada automaticamente. Ao continuar, você concorda com nossos Termos de Serviço e Política de Privacidade.';

  @override
  String get restore => 'Restaurar';

  @override
  String used_up_daily_limit(String value) {
    return 'Você atingiu o limite de entrada por voz hoje. Assista a um anúncio para ganhar $value usos adicionais ou assine o Premium.';
  }

  @override
  String get monthly_plan => 'Plano Mensal';

  @override
  String get yearly_plan => 'Plano Anual';

  @override
  String get lifetime_plan => 'Plano Vitalício';

  @override
  String get pay_once_enjoy_forever => 'Pague uma vez, aproveite para sempre';

  @override
  String get yearly_discount => 'Economize 20% com o Plano Anual';

  @override
  String get best_value => 'MELHOR VALOR';

  @override
  String get transaction_cancelled => 'Transação cancelada.';

  @override
  String get purchase_successful => 'Compra realizada com sucesso!';

  @override
  String get purchase_successful_description =>
      'Obrigado por assinar o Premium! Aproveite sua experiência aprimorada.';

  @override
  String get restore_successful => 'Restauração bem-sucedida!';

  @override
  String get restore_successful_description =>
      'Suas compras anteriores foram restauradas. Aproveite os recursos Premium!';

  @override
  String get nothing_to_restore => 'Nada para Restaurar';

  @override
  String get nothing_to_restore_description =>
      'Nenhuma compra anterior foi encontrada.';

  @override
  String get restore_failed => 'Falha na Restauração';

  @override
  String get restore_failed_description =>
      'Ocorreu um erro ao restaurar sua compra. Tente novamente.';

  @override
  String get purchase_failed => 'Falha na Compra';

  @override
  String get purchase_failed_description =>
      'Ocorreu um erro durante a transação. Tente novamente.';

  @override
  String get purchase_canceled => 'Compra Cancelada';

  @override
  String get purchase_canceled_description =>
      'A transação foi cancelada. Nenhuma alteração foi feita na sua conta.';

  @override
  String get premium_sync_account =>
      'Sua conta Premium será sincronizada com a conta conectada. Conecte-se com a mesma conta em todos os dispositivos.';

  @override
  String get premium_sync_warning =>
      'Nota: Se você comprou o Premium em outra conta, entre nela para restaurar o acesso. Se for a mesma conta, tente restaurar compras.';

  @override
  String get select_language => 'Selecionar Idioma';

  @override
  String get suggested => 'Sugerido';

  @override
  String get all_languages => 'Todos os Idiomas';

  @override
  String get apply_changes => 'Aplicar Alterações';

  @override
  String get select_currency => 'Selecionar Moeda';

  @override
  String get search_currency => 'Pesquisar moeda ou país...';

  @override
  String get popular => 'Popular';

  @override
  String get all_currencies => 'Todas as Moedas';

  @override
  String get currency_change_warning =>
      'Alterar a moeda atualizará apenas o símbolo de exibição. As taxas de transações anteriores não serão recalculadas.';

  @override
  String see_ads(String additionalUses) {
    return 'Ver Anúncios (+$additionalUses usos)';
  }

  @override
  String get ads_loading => 'Carregando Anúncio...';

  @override
  String get data_management => 'Gerenciamento de Dados';

  @override
  String get select_format => 'Selecionar Formato';

  @override
  String get export_data => 'Exportar Dados';

  @override
  String get export_data_description =>
      'Exporte seus dados financeiros para backup ou análise.';

  @override
  String get confirm_export => 'Confirmar Exportação';

  @override
  String get import_data => 'Importar Dados';

  @override
  String get import_data_title => 'Vamos trazer seus \n';

  @override
  String get data => 'dados';

  @override
  String get import_data_title_2 => ' para cá.';

  @override
  String get import_data_description =>
      'Importe dados financeiros de fontes externas para sincronizar com o aplicativo.';

  @override
  String get confirm_import => 'Confirmar Importação';

  @override
  String get csv_format => 'Formato CSV';

  @override
  String get csv_description =>
      'Exporte dados em formato CSV, compatível com a maioria das planilhas.';

  @override
  String get json_format => 'Formato JSON';

  @override
  String get json_description =>
      'Exporte dados em formato JSON, ideal para desenvolvedores.';

  @override
  String get excel_format => 'Formato Excel';

  @override
  String get excel_description =>
      'Exporte dados em formato Excel, ideal para análises detalhadas.';

  @override
  String get select_file => 'Selecionar Arquivo';

  @override
  String get no_file_selected => 'Nenhum arquivo selecionado.';

  @override
  String get import_successful => 'Importação bem-sucedida';

  @override
  String get error_importing_data =>
      'Erro ao importar dados. Verifique se o formato do arquivo está correto.';

  @override
  String get sync_data_now => 'Sincronizar Agora';

  @override
  String last_synced(String time) {
    return 'Última sincronização:\n$time';
  }

  @override
  String get syncing => 'Sincronizando...';

  @override
  String get never_synced => 'Nunca Sincronizado';

  @override
  String get unauthenticated =>
      'Faça login para sincronizar seus dados entre dispositivos.';

  @override
  String sync_error(String error) {
    return 'Erro de sincronização: $error';
  }

  @override
  String get premium_required_to_sync =>
      'Faça upgrade para o Premium ou assista a anúncios para sincronizar dados.';

  @override
  String get sync_in_progress => 'Sincronização em andamento, aguarde.';

  @override
  String cooldown(String time) {
    return 'Você está agindo rápido demais. Aguarde $time antes de sincronizar novamente.';
  }

  @override
  String get logout_delete_local_data_message =>
      'Deseja excluir os dados locais neste dispositivo? Os dados na nuvem permanecerão seguros.';

  @override
  String get keep_local_data => 'Não, apenas sair';

  @override
  String get delete_local_data => 'Excluir dados';

  @override
  String get accepted_formats => 'Formatos Aceitos';

  @override
  String get select_file_to_import => 'Selecione um arquivo para importar';

  @override
  String get tap_to_browse =>
      'Toque para procurar arquivos no dispositivo ou na nuvem.';

  @override
  String get protected => 'Protegido';

  @override
  String get protected_description =>
      'Seus dados nunca saem do seu dispositivo e são processados localmente.';

  @override
  String get recent_imports => 'Importações Recentes';

  @override
  String get no_recent_imports => 'Nenhuma importação recente';

  @override
  String get invalid_format => 'Formato de arquivo inválido.';

  @override
  String get import_success => 'Importado com sucesso!';

  @override
  String import_success_description(String count) {
    return '$count transações foram importadas com sucesso do arquivo.';
  }

  @override
  String get file_format_template => 'Modelo de Formato de Arquivo';

  @override
  String download_sample_file(String format) {
    return 'Baixar Arquivo de Exemplo $format';
  }

  @override
  String get card => 'Cartão';

  @override
  String get font_selection => 'Seleção de Fonte';

  @override
  String get select_font => 'Selecionar fonte';

  @override
  String get font => 'Fonte';

  @override
  String get font_description =>
      'Uma transação anotada por dia mantém as dívidas longe.';

  @override
  String get reminder_title => 'Lembrete Diário de Gastos';

  @override
  String get reminder_body => 'Você já registrou suas despesas de hoje? 💸';

  @override
  String get defaultTransactionTitle => 'Nova Transação';

  @override
  String get invoice_analysis => 'Analisando notas fiscais...';

  @override
  String get mapbox_error =>
      'Erro ao carregar mapa. Verifique a configuração do seu token Mapbox.';

  @override
  String get location => 'Localização';

  @override
  String get current_location => 'Localização Atual';

  @override
  String get select_location => 'Selecionar Localização';

  @override
  String get no_location_selected => 'Nenhuma localização selecionada';

  @override
  String get search_location => 'Pesquisar local...';

  @override
  String get tap_to_change_location => 'Toque para alterar a localização';

  @override
  String get search_results => 'Resultados da Pesquisa';

  @override
  String get no_location_found => 'Nenhum local encontrado';

  @override
  String get recent_locations => 'Locais Recentes';

  @override
  String get location_access_error => 'Erro de acesso à localização';

  @override
  String get location_permission_denied => 'Acesso à localização negado.';

  @override
  String get location_permission_denied_description =>
      'Ative o acesso à localização nas configurações.';

  @override
  String get notification_permission_denied =>
      'Permissão de notificação negada.';

  @override
  String get notification_permission_denied_description =>
      'Ative as notificações nas configurações para receber lembretes.';

  @override
  String get permission_required_camera => 'Acesso à câmera negado';

  @override
  String get permission_required_camera_description =>
      'Ative o acesso à câmera nas configurações para escanear recibos.';

  @override
  String get voice_input_error => 'Erro na entrada por voz. Tente novamente.';

  @override
  String get voice_input_not_recognized =>
      'Voz não reconhecida. Tente novamente.';

  @override
  String get voice_input_permission_denied =>
      'Acesso ao microfone negado. Ative o acesso nas configurações.';

  @override
  String get error_ai_request =>
      'A IA não conseguiu reconhecer esta solicitação. Tente ser mais específico.';

  @override
  String get voice_analysis => 'Analisando entrada por voz...';

  @override
  String get scan_receipt_error => 'Erro ao escanear recibo. Tente novamente.';

  @override
  String get requires_premium =>
      'Este recurso requer assistir a anúncios ou fazer upgrade para o Premium.';

  @override
  String get watch_ad_continue => 'Assistir Anúncio para Continuar';

  @override
  String get permission_required_voice_input => 'Acesso ao microfone negado';

  @override
  String get permission_required_voice_input_description =>
      'Ative o acesso ao microfone nas configurações para usar a entrada por voz.';

  @override
  String get permission_required_location => 'Acesso à localização negado';

  @override
  String get permission_required_location_description =>
      'Ative a localização nas configurações para usar recursos de mapa.';

  @override
  String get congratulations => 'Parabéns!';

  @override
  String get successfully_purchased =>
      'Você adquiriu o Premium com sucesso. Aproveite todos os recursos!';

  @override
  String get cancel_purchase => 'Cancelar Compra';

  @override
  String get restore_no_purchase_description =>
      'Nenhuma compra anterior foi encontrada para restaurar.';

  @override
  String get ai_powered => 'Com Tecnologia de IA';

  @override
  String get entries_pending => 'Entradas Pendentes';

  @override
  String get confirm_selected_entries => 'Adicionar entradas selecionadas';

  @override
  String get preview_results => 'Prévia dos resultados';

  @override
  String get clear_all => 'Limpar tudo';

  @override
  String get select_all => 'Selecionar tudo';

  @override
  String get fail_to_save_transactions =>
      'Falha ao salvar transações. Tente novamente.';

  @override
  String get tap_to_check_in => 'Toque para fazer check-in';

  @override
  String get keep_your_streak => 'Mantenha sua sequência!';

  @override
  String keep_your_streak_day(String streak) {
    return 'Mantenha sua sequência de $streak dias!';
  }

  @override
  String get streak => 'Sequência';

  @override
  String streak_days(String days) {
    return '$days dias';
  }

  @override
  String get not_logined => 'Não Conectado';

  @override
  String get please_login_to_sync_data =>
      'Faça login para sincronizar seus dados entre dispositivos.';

  @override
  String get require_premium_to_sync =>
      'Faça upgrade para o Premium ou assista a anúncios para sincronizar dados.';

  @override
  String get information_and_support => 'Informações e Suporte';

  @override
  String get contact_support => 'Fale com o Suporte';

  @override
  String get send_email => 'Enviar E-mail';

  @override
  String get describe_issue =>
      'Descreva seu problema ou dúvida em detalhes. Nossa equipe responderá o mais breve possível.';

  @override
  String get feedback => 'Feedback';

  @override
  String get feedback_description =>
      'Adoraríamos ouvir suas opiniões e sugestões para melhorar o SpendFlow. Compartilhe sua opinião!';

  @override
  String get thank_you_feedback => 'Obrigado pelo seu feedback!';

  @override
  String get submit_feedback => 'Enviar Feedback';

  @override
  String get report_issue => 'Relatar Problema';

  @override
  String get submit_issue => 'Enviar Relato';

  @override
  String get report_issue_description =>
      'Se encontrar algum bug ou erro, relate-o aqui. Sua ajuda melhora o app para todos.';

  @override
  String get thank_you_issue =>
      'Obrigado por relatar o problema! Vamos analisá-lo o quanto antes.';

  @override
  String get request_delete_account => 'Solicitar Exclusão da Conta';

  @override
  String get delete_account_description =>
      'Se deseja excluir sua conta, informe-nos o motivo. Processaremos sua solicitação o mais rápido possível.';

  @override
  String get submit_delete_request => 'Enviar Solicitação';

  @override
  String get select_subject => 'Selecionar Assunto';

  @override
  String get please_enter_content => 'Por favor, digite o conteúdo';

  @override
  String get subject => 'Assunto';

  @override
  String get content => 'Conteúdo';

  @override
  String get send_contact_success =>
      'Sua mensagem foi enviada com sucesso! Responderemos o mais breve possível.';

  @override
  String get send_contact_error =>
      'Ocorreu um erro ao enviar sua mensagem. Tente novamente.';

  @override
  String get contact_info => 'Informações de Contato';

  @override
  String get email_placeholder => 'Digite seu e-mail';

  @override
  String get name_placeholder => 'Digite seu nome';

  @override
  String get invalid_name => 'Por favor, digite um nome válido.';

  @override
  String get mrs => 'Sra.';

  @override
  String get mr => 'Sr.';

  @override
  String get ms => 'Srta.';

  @override
  String get salutation => 'Pronome de Tratamento';

  @override
  String get delete_account => 'Excluir Conta';

  @override
  String get delete_account_confirmation =>
      'Tem certeza de que deseja excluir sua conta? Esta ação não pode ser desfeita e apagará todos os seus dados.';

  @override
  String get failed_to_send_deletion_request =>
      'Falha ao enviar a solicitação de exclusão. Tente novamente.';

  @override
  String get requires_recent_login_description =>
      'Por motivos de segurança, saia e entre novamente antes de excluir sua conta.';

  @override
  String get delete_account_failed =>
      'Ocorreu um erro ao excluir sua conta. Tente novamente.';

  @override
  String get left => 'restante';

  @override
  String get edit_transaction => 'Editar Transação';

  @override
  String get save_expense_change => 'Atualizar Despesa';

  @override
  String get save_income_change => 'Atualizar Receita';

  @override
  String get transaction_updated => 'Transação atualizada com sucesso';

  @override
  String get bank_sync => 'Sincronização Bancária';

  @override
  String get bank_sync_description =>
      'Conecte e sincronize automaticamente os lançamentos de suas contas bancárias';

  @override
  String get coming_soon => 'Em Breve';

  @override
  String get feature_under_development =>
      'Este recurso está em desenvolvimento e estará disponível em atualizações futuras!';

  @override
  String get remaining_budget => 'Orçamento Restante';

  @override
  String get monthly_spending => 'Gráfico de Gastos Mensais';

  @override
  String get quick_add_voice => 'Toque para falar';

  @override
  String get ad_no_fill_title => 'Nenhum anúncio disponível';

  @override
  String get ad_no_fill_message =>
      'No momento não há anúncios disponíveis. Tente novamente mais tarde ou faça upgrade para o Premium.';

  @override
  String get ad_network_error_title => 'Erro de conexão';

  @override
  String get ad_network_error_message =>
      'Não foi possível conectar para carregar anúncios. Verifique sua rede e tente novamente.';

  @override
  String get ad_load_failed_title => 'Falha ao carregar anúncio';

  @override
  String get ad_load_failed_message =>
      'Ocorreu um erro ao carregar o anúncio. Tente novamente mais tarde.';

  @override
  String get ad_show_failed_title => 'Erro de exibição';

  @override
  String get ad_show_failed_message =>
      'Não foi possível exibir o anúncio. Tente novamente mais tarde.';

  @override
  String get ad_loading_timeout_message =>
      'O anúncio demorou muito para carregar. Tente novamente mais tarde.';

  @override
  String get ad_preparing => 'Preparando anúncio...';
}
