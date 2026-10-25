import WidgetKit
import SwiftUI

// MARK: - Widget Localization Manager
struct WidgetStrings {
    static let en: [String: String] = [
        "remaining_balance": "Remaining Balance",
        "no_transactions": "No transactions",
        "no_recent_transactions": "No recent transactions",
        "monthly_chart": "Monthly Chart",
        "overview_income_expense": "Income & Expense",
        "total_income": "Total Income",
        "total_expense": "Total Expense",
        "remaining_budget": "Remaining Budget",
        "budget_remaining_short": "Remaining",
        "spent_label": "Used",
        "spent_format": "Spent: %@",
        "total_format": "Total: %@",
        "used_percent_format": "Used %@",
        "no_budget_title": "No budget",
        "no_budget_desc": "No budget set this month",
        "category": "Category",
        "remaining_prefix": "Left",
        "daily_spending": "Daily Spending",
        "by_category": "By Category",
        "no_category_budget": "No category budgets"
    ]

    static let vi: [String: String] = [
        "remaining_balance": "Số dư còn lại",
        "no_transactions": "Chưa có giao dịch",
        "no_recent_transactions": "Chưa có giao dịch nào gần đây",
        "monthly_chart": "Biểu đồ tháng này",
        "overview_income_expense": "Tổng quan thu chi",
        "total_income": "Tổng thu",
        "total_expense": "Tổng chi",
        "remaining_budget": "Ngân sách còn lại",
        "budget_remaining_short": "Ngân sách còn",
        "spent_label": "Đã dùng",
        "spent_format": "Đã tiêu: %@",
        "total_format": "Tổng: %@",
        "used_percent_format": "Đã sử dụng %@",
        "no_budget_title": "Chưa có ngân sách",
        "no_budget_desc": "Chưa thiết lập ngân sách tháng này",
        "category": "Danh mục",
        "remaining_prefix": "Còn",
        "daily_spending": "Chi tiêu theo ngày",
        "by_category": "Theo danh mục",
        "no_category_budget": "Chưa có ngân sách theo danh mục"
    ]

    static let zh: [String: String] = [
        "remaining_balance": "剩余金额",
        "no_transactions": "暂无交易",
        "no_recent_transactions": "近期暂无交易",
        "monthly_chart": "本月图表",
        "overview_income_expense": "收支总览",
        "total_income": "总收入",
        "total_expense": "总支出",
        "remaining_budget": "剩余预算",
        "budget_remaining_short": "剩余",
        "spent_label": "已用",
        "spent_format": "已支出: %@",
        "total_format": "总计: %@",
        "used_percent_format": "已使用 %@",
        "no_budget_title": "暂无预算",
        "no_budget_desc": "本月尚未设置预算",
        "category": "分类",
        "remaining_prefix": "剩余",
        "daily_spending": "每日支出",
        "by_category": "按分类",
        "no_category_budget": "暂无分类预算"
    ]

    static let zh_Hant: [String: String] = [
        "remaining_balance": "剩餘金額",
        "no_transactions": "暫無交易",
        "no_recent_transactions": "近期暫無交易",
        "monthly_chart": "本月圖表",
        "overview_income_expense": "收支總覽",
        "total_income": "總收入",
        "total_expense": "總支出",
        "remaining_budget": "剩餘預算",
        "budget_remaining_short": "剩餘",
        "spent_label": "已用",
        "spent_format": "已支出: %@",
        "total_format": "總計: %@",
        "used_percent_format": "已使用 %@",
        "no_budget_title": "暫無預算",
        "no_budget_desc": "本月尚未設定預算",
        "category": "類別",
        "remaining_prefix": "剩餘",
        "daily_spending": "每日支出",
        "by_category": "按類別",
        "no_category_budget": "暫無類別預算"
    ]

    static let ja: [String: String] = [
        "remaining_balance": "残高",
        "no_transactions": "取引なし",
        "no_recent_transactions": "最近の取引はありません",
        "monthly_chart": "今月のグラフ",
        "overview_income_expense": "収支の概要",
        "total_income": "総収入",
        "total_expense": "総支出",
        "remaining_budget": "残りの予算",
        "budget_remaining_short": "残り",
        "spent_label": "使用済",
        "spent_format": "支出: %@",
        "total_format": "合計: %@",
        "used_percent_format": "使用率 %@",
        "no_budget_title": "予算なし",
        "no_budget_desc": "今月の予算は設定されていません",
        "category": "カテゴリー",
        "remaining_prefix": "残り",
        "daily_spending": "日別支出",
        "by_category": "カテゴリー別",
        "no_category_budget": "カテゴリー別予算なし"
    ]

    static let ko: [String: String] = [
        "remaining_balance": "남은 잔액",
        "no_transactions": "내역 없음",
        "no_recent_transactions": "최근 거래 내역이 없습니다",
        "monthly_chart": "이번 달 차트",
        "overview_income_expense": "수입 및 지출",
        "total_income": "총수입",
        "total_expense": "총지출",
        "remaining_budget": "남은 예산",
        "budget_remaining_short": "남은 금액",
        "spent_label": "사용됨",
        "spent_format": "지출: %@",
        "total_format": "총액: %@",
        "used_percent_format": "사용됨 %@",
        "no_budget_title": "예산 없음",
        "no_budget_desc": "이번 달 예산이 설정되지 않았습니다",
        "category": "카테고리",
        "remaining_prefix": "남음",
        "daily_spending": "일별 지출",
        "by_category": "카테고리별",
        "no_category_budget": "카테고리별 예산 없음"
    ]

    static let es: [String: String] = [
        "remaining_balance": "Saldo restante",
        "no_transactions": "Sin transacciones",
        "no_recent_transactions": "No hay transacciones recientes",
        "monthly_chart": "Gráfico mensual",
        "overview_income_expense": "Resumen de ingresos y gastos",
        "total_income": "Ingresos totales",
        "total_expense": "Gastos totales",
        "remaining_budget": "Presupuesto restante",
        "budget_remaining_short": "Restante",
        "spent_label": "Gastado",
        "spent_format": "Gastado: %@",
        "total_format": "Total: %@",
        "used_percent_format": "Usado %@",
        "no_budget_title": "Sin presupuesto",
        "no_budget_desc": "No se ha establecido presupuesto este mes",
        "category": "Categoría",
        "remaining_prefix": "Queda",
        "daily_spending": "Gasto diario",
        "by_category": "Por categoría",
        "no_category_budget": "Sin presupuesto por categoría"
    ]

    static let fr: [String: String] = [
        "remaining_balance": "Solde restant",
        "no_transactions": "Aucune transaction",
        "no_recent_transactions": "Aucune transaction récente",
        "monthly_chart": "Graphique mensuel",
        "overview_income_expense": "Revenus & Dépenses",
        "total_income": "Revenu total",
        "total_expense": "Dépense totale",
        "remaining_budget": "Budget restant",
        "budget_remaining_short": "Restant",
        "spent_label": "Utilisé",
        "spent_format": "Dépensé : %@",
        "total_format": "Total : %@",
        "used_percent_format": "Utilisé %@",
        "no_budget_title": "Aucun budget",
        "no_budget_desc": "Aucun budget défini ce mois-ci",
        "category": "Catégorie",
        "remaining_prefix": "Reste",
        "daily_spending": "Dépenses quotidiennes",
        "by_category": "Par catégorie",
        "no_category_budget": "Aucun budget par catégorie"
    ]

    static let de: [String: String] = [
        "remaining_balance": "Restguthaben",
        "no_transactions": "Keine Transaktionen",
        "no_recent_transactions": "Keine aktuellen Transaktionen",
        "monthly_chart": "Monatsdiagramm",
        "overview_income_expense": "Einnahmen & Ausgaben",
        "total_income": "Gesamteinnahmen",
        "total_expense": "Gesamtausgaben",
        "remaining_budget": "Restbudget",
        "budget_remaining_short": "Verbleibend",
        "spent_label": "Verbraucht",
        "spent_format": "Ausgegeben: %@",
        "total_format": "Gesamt: %@",
        "used_percent_format": "Verbraucht %@",
        "no_budget_title": "Kein Budget",
        "no_budget_desc": "Diesen Monat kein Budget festgelegt",
        "category": "Kategorie",
        "remaining_prefix": "Übrig",
        "daily_spending": "Tägliche Ausgaben",
        "by_category": "Nach Kategorie",
        "no_category_budget": "Keine Kategoriebudgets"
    ]

    static let pt: [String: String] = [
        "remaining_balance": "Saldo restante",
        "no_transactions": "Sem transações",
        "no_recent_transactions": "Nenhuma transação recente",
        "monthly_chart": "Gráfico mensal",
        "overview_income_expense": "Receitas e Despesas",
        "total_income": "Receita total",
        "total_expense": "Despesa total",
        "remaining_budget": "Orçamento restante",
        "budget_remaining_short": "Restante",
        "spent_label": "Gasto",
        "spent_format": "Gasto: %@",
        "total_format": "Total: %@",
        "used_percent_format": "Usado %@",
        "no_budget_title": "Sem orçamento",
        "no_budget_desc": "Nenhum orçamento definido este mês",
        "category": "Categoria",
        "remaining_prefix": "Resta",
        "daily_spending": "Gasto diário",
        "by_category": "Por categoria",
        "no_category_budget": "Nenhum orçamento por categoria"
    ]

    static func get(_ key: String, lang: String? = nil) -> String {
        let currentLang: String
        if let lang = lang, !lang.isEmpty {
            currentLang = lang
        } else {
            let defaults = UserDefaults(suiteName: "group.com.duogkhiem.spendflow")
            currentLang = defaults?.string(forKey: "app_language") ?? Locale.current.languageCode ?? "vi"
        }
        let lower = currentLang.lowercased()
        let dict: [String: String]
        if lower.contains("hant") || lower.contains("tw") || lower.contains("hk") {
            dict = zh_Hant
        } else if lower.starts(with: "zh") {
            dict = zh
        } else if lower.starts(with: "ja") {
            dict = ja
        } else if lower.starts(with: "ko") {
            dict = ko
        } else if lower.starts(with: "es") {
            dict = es
        } else if lower.starts(with: "fr") {
            dict = fr
        } else if lower.starts(with: "de") {
            dict = de
        } else if lower.starts(with: "pt") {
            dict = pt
        } else if lower.starts(with: "en") {
            dict = en
        } else {
            dict = vi
        }
        return dict[key] ?? key
    }

    static func format(_ key: String, lang: String? = nil, _ arguments: CVarArg...) -> String {
        let template = get(key, lang: lang)
        return String(format: template, arguments: arguments)
    }
}

@main
struct SpendFlowWidgetsBundle: WidgetBundle {
    var body: some Widget {
        RecentTransactionsWidget()
        MonthlyChartWidget()
        RemainingBudgetWidget()
    }
}

