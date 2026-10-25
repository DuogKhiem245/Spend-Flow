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

    static func get(_ key: String, lang: String? = nil) -> String {
        let currentLang: String
        if let lang = lang, !lang.isEmpty {
            currentLang = lang
        } else {
            let defaults = UserDefaults(suiteName: "group.com.duogkhiem.spendflow")
            currentLang = defaults?.string(forKey: "app_language") ?? Locale.current.languageCode ?? "vi"
        }
        let dict = (currentLang.lowercased().starts(with: "en")) ? en : vi
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

