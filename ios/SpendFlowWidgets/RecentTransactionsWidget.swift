import WidgetKit
import SwiftUI

// MARK: - Models
struct WidgetTransaction: Identifiable, Codable {
    let id: String
    let title: String
    let amount: Double
    let formattedAmount: String
    let categoryName: String
    let categoryColor: String
    let iconKey: String
    let isIncome: Bool
    let date: String
}

struct RecentTransactionsEntry: TimelineEntry {
    let date: Date
    let totalBalance: String
    let transactions: [WidgetTransaction]
    let language: String
}

// MARK: - Timeline Provider
struct RecentTransactionsProvider: TimelineProvider {
    private let appGroupId = "group.com.duogkhiem.spendflow"

    func placeholder(in context: Context) -> RecentTransactionsEntry {
        RecentTransactionsEntry(
            date: Date(),
            totalBalance: "15,000,000 ₫",
            transactions: [
                WidgetTransaction(id: "1", title: "Cà phê sáng", amount: 35000, formattedAmount: "-35,000 ₫", categoryName: "Ăn uống", categoryColor: "#FF5722", iconKey: "food", isIncome: false, date: "Hôm nay"),
                WidgetTransaction(id: "2", title: "Lương tháng", amount: 20000000, formattedAmount: "+20,000,000 ₫", categoryName: "Lương", categoryColor: "#4CAF50", iconKey: "salary", isIncome: true, date: "Hôm qua")
            ],
            language: "vi"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (RecentTransactionsEntry) -> Void) {
        completion(loadData())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<RecentTransactionsEntry>) -> Void) {
        let entry = loadData()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date()) ?? Date()
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }

    private func loadData() -> RecentTransactionsEntry {
        let prefs = UserDefaults(suiteName: appGroupId)
        let totalBalance = prefs?.string(forKey: "total_balance") ?? "0 ₫"
        let language = prefs?.string(forKey: "app_language") ?? "vi"
        var transactions: [WidgetTransaction] = []

        if let jsonStr = prefs?.string(forKey: "recent_transactions"),
           let data = jsonStr.data(using: .utf8) {
            do {
                transactions = try JSONDecoder().decode([WidgetTransaction].self, from: data)
            } catch {
                print("Error decoding transactions: \(error)")
            }
        }

        return RecentTransactionsEntry(
            date: Date(),
            totalBalance: totalBalance,
            transactions: transactions,
            language: language
        )
    }
}

// MARK: - Widget View
struct RecentTransactionsWidgetEntryView: View {
    var entry: RecentTransactionsProvider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        Group {
            switch family {
            case .systemSmall:
                SmallRecentView(entry: entry)
            case .systemMedium:
                MediumRecentView(entry: entry)
            case .systemLarge:
                LargeRecentView(entry: entry)
            default:
                MediumRecentView(entry: entry)
            }
        }
        .widgetBackground(Color(uiColor: .systemBackground))
    }
}

// MARK: - Small View
struct SmallRecentView: View {
    let entry: RecentTransactionsEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(WidgetStrings.get("remaining_balance", lang: entry.language))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.secondary)
                Spacer()
            }


            Text(entry.totalBalance)
                .font(.system(size: 15, weight: .bold))
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Divider()

            if let tx = entry.transactions.first {
                VStack(alignment: .leading, spacing: 3) {
                    Text(tx.title)
                        .font(.system(size: 12, weight: .semibold))
                        .lineLimit(1)
                    Text(tx.formattedAmount)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(tx.isIncome ? .green : .red)
                    Text(tx.date)
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
            } else {
                Text(WidgetStrings.get("no_transactions", lang: entry.language))
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(12)
    }
}

// MARK: - Medium View
struct MediumRecentView: View {
    let entry: RecentTransactionsEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(WidgetStrings.get("remaining_balance", lang: entry.language))
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.secondary)
                    Text(entry.totalBalance)
                        .font(.system(size: 16, weight: .bold))
                }
                Spacer()
            }

            Divider()

            if entry.transactions.isEmpty {
                Spacer()
                Text(WidgetStrings.get("no_recent_transactions", lang: entry.language))
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            } else {
                ForEach(entry.transactions.prefix(2)) { tx in
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color(hex: tx.categoryColor))
                            .frame(width: 8, height: 8)

                        VStack(alignment: .leading, spacing: 1) {
                            Text(tx.title)
                                .font(.system(size: 12, weight: .semibold))
                                .lineLimit(1)
                            Text(tx.categoryName)
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 1) {
                            Text(tx.formattedAmount)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(tx.isIncome ? .green : .red)
                            Text(tx.date)
                                .font(.system(size: 9))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .padding(14)
    }
}

// MARK: - Large View
struct LargeRecentView: View {
    let entry: RecentTransactionsEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(WidgetStrings.get("remaining_balance", lang: entry.language))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                    Text(entry.totalBalance)
                        .font(.system(size: 20, weight: .bold))
                }
                Spacer()
            }

            Divider()

            if entry.transactions.isEmpty {
                Spacer()
                Text(WidgetStrings.get("no_recent_transactions", lang: entry.language))
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            } else {
                VStack(spacing: 8) {
                    ForEach(entry.transactions.prefix(5)) { tx in
                        HStack(spacing: 10) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color(hex: tx.categoryColor).opacity(0.15))
                                .frame(width: 28, height: 28)
                                .overlay(
                                    Circle()
                                        .fill(Color(hex: tx.categoryColor))
                                        .frame(width: 10, height: 10)
                                )

                            VStack(alignment: .leading, spacing: 2) {
                                Text(tx.title)
                                    .font(.system(size: 13, weight: .semibold))
                                    .lineLimit(1)
                                Text("\(tx.categoryName) • \(tx.date)")
                                    .font(.system(size: 10))
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Text(tx.formattedAmount)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(tx.isIncome ? .green : .red)
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
struct RecentTransactionsWidget: Widget {
    let kind: String = "RecentTransactionsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: RecentTransactionsProvider()) { entry in
            RecentTransactionsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Giao dịch gần đây")
        .description("Xem nhanh số dư, các giao dịch mới nhất và bấm để nói AI.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// MARK: - Color Hex & Widget Background Helpers
extension Color {
    init(hex: String) {
        let cleanHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: cleanHex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch cleanHex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension View {
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOSApplicationExtension 17.0, iOS 17.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}
