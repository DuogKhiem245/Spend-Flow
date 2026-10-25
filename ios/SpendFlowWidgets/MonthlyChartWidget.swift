import WidgetKit
import SwiftUI

// MARK: - Models
struct DailySpendPoint: Identifiable, Codable {
    var id: Int { day }
    let day: Int
    let date: String
    let expense: Double
    let income: Double
}

struct MonthlyChartEntry: TimelineEntry {
    let date: Date
    let monthlyExpense: String
    let monthlyIncome: String
    let chartData: [DailySpendPoint]
}

// MARK: - Timeline Provider
struct MonthlyChartProvider: TimelineProvider {
    private let appGroupId = "group.com.duogkhiem.spendflow"

    func placeholder(in context: Context) -> MonthlyChartEntry {
        MonthlyChartEntry(
            date: Date(),
            monthlyExpense: "8,500,000 ₫",
            monthlyIncome: "20,000,000 ₫",
            chartData: (1...15).map { d in
                DailySpendPoint(day: d, date: "\(d)/10", expense: Double(d * 100000 % 600000), income: d == 5 ? 20000000 : 0)
            }
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (MonthlyChartEntry) -> Void) {
        completion(loadData())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MonthlyChartEntry>) -> Void) {
        let entry = loadData()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date()) ?? Date()
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }

    private func loadData() -> MonthlyChartEntry {
        let prefs = UserDefaults(suiteName: appGroupId)
        let monthlyExpense = prefs?.string(forKey: "monthly_expense") ?? "0 ₫"
        let monthlyIncome = prefs?.string(forKey: "monthly_income") ?? "0 ₫"
        var chartData: [DailySpendPoint] = []

        if let jsonStr = prefs?.string(forKey: "monthly_daily_chart"),
           let data = jsonStr.data(using: .utf8) {
            do {
                chartData = try JSONDecoder().decode([DailySpendPoint].self, from: data)
            } catch {
                print("Error decoding chart data: \(error)")
            }
        }

        return MonthlyChartEntry(
            date: Date(),
            monthlyExpense: monthlyExpense,
            monthlyIncome: monthlyIncome,
            chartData: chartData
        )
    }
}

// MARK: - Widget View
struct MonthlyChartWidgetEntryView: View {
    var entry: MonthlyChartProvider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Biểu đồ tháng này")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.secondary)
                    Text("Tổng quan thu chi")
                        .font(.system(size: 18, weight: .bold))
                }
                Spacer()
            }


            // Cards: Thu & Chi
            HStack(spacing: 10) {
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.green.opacity(0.15))
                        .frame(width: 32, height: 32)
                        .overlay(
                            Image(systemName: "arrow.down.left")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.green)
                        )
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Tổng thu")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.secondary)
                        Text(entry.monthlyIncome)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.green)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.green.opacity(0.08)))

                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.red.opacity(0.15))
                        .frame(width: 32, height: 32)
                        .overlay(
                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.red)
                        )
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Tổng chi")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.secondary)
                        Text(entry.monthlyExpense)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.red)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.red.opacity(0.08)))
            }

            // Chart bars
            VStack(alignment: .leading, spacing: 6) {
                Text("Chi tiêu theo ngày")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.secondary)

                let maxExpense = max(entry.chartData.map(\.expense).max() ?? 1.0, 1.0)
                let recentDays = Array(entry.chartData.suffix(14))

                GeometryReader { geo in
                    HStack(alignment: .bottom, spacing: 4) {
                        ForEach(recentDays) { item in
                            VStack(spacing: 3) {
                                let ratio = CGFloat(item.expense / maxExpense)
                                let barHeight = max(geo.size.height * 0.7 * ratio, item.expense > 0 ? 4 : 2)

                                RoundedRectangle(cornerRadius: 3)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.red.opacity(0.8), Color.orange.opacity(0.6)],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .frame(height: barHeight)

                                Text("\(item.day)")
                                    .font(.system(size: 8))
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }

            Spacer(minLength: 0)
        }
        .padding(16)
        .widgetBackground(Color(uiColor: .systemBackground))
    }
}

// MARK: - Widget Declaration
struct MonthlyChartWidget: Widget {
    let kind: String = "MonthlyChartWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MonthlyChartProvider()) { entry in
            MonthlyChartWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Biểu đồ giao dịch tháng")
        .description("Theo dõi biểu đồ chi tiêu và tổng thu/chi trong tháng.")
        .supportedFamilies([.systemLarge])
    }
}
