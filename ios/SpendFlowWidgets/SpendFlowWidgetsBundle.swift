import WidgetKit
import SwiftUI

@main
struct SpendFlowWidgetsBundle: WidgetBundle {
    var body: some Widget {
        RecentTransactionsWidget()
        MonthlyChartWidget()
        RemainingBudgetWidget()
    }
}
