import WidgetKit
import SwiftUI

// MARK: - Models
struct WidgetCategoryBudget: Identifiable, Codable {
    var id: String { name }
    let name: String
    let total: Double
    let spent: Double
    let remaining: Double
    let formattedRemaining: String
    let progress: Double
    let color: String
    let iconKey: String
}

struct RemainingBudgetEntry: TimelineEntry {
    let date: Date
    let budgetTotal: String
    let budgetSpent: String
    let budgetRemaining: String
    let budgetProgress: Double
    let budgetPercent: String
    let categories: [WidgetCategoryBudget]
}

// MARK: - Timeline Provider
struct RemainingBudgetProvider: TimelineProvider {
    private let appGroupId = "group.com.duogkhiem.spendflow"

    func placeholder(in context: Context) -> RemainingBudgetEntry {
        RemainingBudgetEntry(
            date: Date(),
            budgetTotal: "10,000,000 ₫",
            budgetSpent: "6,500,000 ₫",
            budgetRemaining: "3,500,000 ₫",
            budgetProgress: 0.65,
            budgetPercent: "65%",
            categories: [
                WidgetCategoryBudget(name: "Ăn uống", total: 4000000, spent: 2500000, remaining: 1500000, formattedRemaining: "1,500,000 ₫", progress: 0.625, color: "#FF5722", iconKey: "food"),
                WidgetCategoryBudget(name: "Di chuyển", total: 1500000, spent: 1000000, remaining: 500000, formattedRemaining: "500,000 ₫", progress: 0.67, color: "#2196F3", iconKey: "transport")
            ]
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (RemainingBudgetEntry) -> Void) {
        completion(loadData())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<RemainingBudgetEntry>) -> Void) {
        let entry = loadData()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date()) ?? Date()
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }

    private func loadData() -> RemainingBudgetEntry {
        let prefs = UserDefaults(suiteName: appGroupId)
        let total = prefs?.string(forKey: "budget_total") ?? "0 ₫"
        let spent = prefs?.string(forKey: "budget_spent") ?? "0 ₫"
        let remaining = prefs?.string(forKey: "budget_remaining") ?? "0 ₫"
        let progress = prefs?.double(forKey: "budget_progress") ?? 0.0
        let percent = prefs?.string(forKey: "budget_percent") ?? "0%"
        var categories: [WidgetCategoryBudget] = []

        if let jsonStr = prefs?.string(forKey: "category_budgets"),
           let data = jsonStr.data(using: .utf8) {
            do {
                categories = try JSONDecoder().decode([WidgetCategoryBudget].self, from: data)
            } catch {
                print("Error decoding category budgets: \(error)")
            }
        }

        return RemainingBudgetEntry(
            date: Date(),
            budgetTotal: total,
            budgetSpent: spent,
            budgetRemaining: remaining,
            budgetProgress: progress,
            budgetPercent: percent,
            categories: categories
        )
    }
}

// MARK: - Widget View
struct RemainingBudgetWidgetEntryView: View {
    var entry: RemainingBudgetProvider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        Group {
            switch family {
            case .systemSmall:
                SmallBudgetView(entry: entry)
            case .systemMedium:
                MediumBudgetView(entry: entry)
            case .systemLarge:
                LargeBudgetView(entry: entry)
            default:
                MediumBudgetView(entry: entry)
            }
        }
        .widgetBackground(Color(uiColor: .systemBackground))
    }
}

// MARK: - Small View
struct SmallBudgetView: View {
    let entry: RemainingBudgetEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Ngân sách còn")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.secondary)
                Spacer()
            }


            Text(entry.budgetRemaining)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(entry.budgetProgress >= 1.0 ? .red : .primary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Spacer()

            // Progress bar
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("Đã dùng")
                        .font(.system(size: 9))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(entry.budgetPercent)
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(entry.budgetProgress >= 0.8 ? .red : .primary)
                }

                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 6)
                        Capsule()
                            .fill(
                                entry.budgetProgress >= 0.9 ? Color.red :
                                entry.budgetProgress >= 0.7 ? Color.orange : Color.green
                            )
                            .frame(width: max(geo.size.width * CGFloat(entry.budgetProgress), 0), height: 6)
                    }
                }
                .frame(height: 6)
            }
        }
        .padding(12)
    }
}

// MARK: - Medium View
struct MediumBudgetView: View {
    let entry: RemainingBudgetEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Ngân sách còn lại")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.secondary)
                    Text(entry.budgetRemaining)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(entry.budgetProgress >= 1.0 ? .red : .primary)
                }
                Spacer()
            }

            Divider()

            HStack {
                Text("Đã tiêu: \(entry.budgetSpent)")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
                Spacer()
                Text("Tổng: \(entry.budgetTotal)")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.secondary.opacity(0.2))
                        .frame(height: 8)
                    Capsule()
                        .fill(
                            entry.budgetProgress >= 0.9 ? Color.red :
                            entry.budgetProgress >= 0.7 ? Color.orange : Color.green
                        )
                        .frame(width: max(geo.size.width * CGFloat(entry.budgetProgress), 0), height: 8)
                }
            }
            .frame(height: 8)

            HStack {
                Spacer()
                Text("Đã sử dụng \(entry.budgetPercent)")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(entry.budgetProgress >= 0.8 ? .red : .secondary)
            }
        }
        .padding(14)
    }
}

// MARK: - Large View
struct LargeBudgetView: View {
    let entry: RemainingBudgetEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Ngân sách còn lại")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                    Text(entry.budgetRemaining)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(entry.budgetProgress >= 1.0 ? .red : .primary)
                }
                Spacer()
            }

            // Overall progress
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Đã tiêu \(entry.budgetSpent) / \(entry.budgetTotal)")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(entry.budgetPercent)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(entry.budgetProgress >= 0.8 ? .red : .primary)
                }
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 8)
                        Capsule()
                            .fill(
                                entry.budgetProgress >= 0.9 ? Color.red :
                                entry.budgetProgress >= 0.7 ? Color.orange : Color.green
                            )
                            .frame(width: max(geo.size.width * CGFloat(entry.budgetProgress), 0), height: 8)
                    }
                }
                .frame(height: 8)
            }

            Divider()

            Text("Theo danh mục")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)

            if entry.categories.isEmpty {
                Spacer()
                Text("Chưa có ngân sách theo danh mục")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            } else {
                VStack(spacing: 8) {
                    ForEach(entry.categories.prefix(4)) { cat in
                        VStack(spacing: 3) {
                            HStack {
                                Circle()
                                    .fill(Color(hex: cat.color))
                                    .frame(width: 8, height: 8)
                                Text(cat.name)
                                    .font(.system(size: 12, weight: .medium))
                                Spacer()
                                Text("Còn \(cat.formattedRemaining)")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(cat.progress >= 1.0 ? .red : .primary)
                            }
                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    Capsule()
                                        .fill(Color.secondary.opacity(0.15))
                                        .frame(height: 5)
                                    Capsule()
                                        .fill(Color(hex: cat.color))
                                        .frame(width: max(geo.size.width * CGFloat(cat.progress), 0), height: 5)
                                }
                            }
                            .frame(height: 5)
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(16)
    }
}

// MARK: - Widget Declaration
struct RemainingBudgetWidget: Widget {
    let kind: String = "RemainingBudgetWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: RemainingBudgetProvider()) { entry in
            RemainingBudgetWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Ngân sách còn lại")
        .description("Theo dõi ngân sách chi tiêu còn lại và bấm để nói AI.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
