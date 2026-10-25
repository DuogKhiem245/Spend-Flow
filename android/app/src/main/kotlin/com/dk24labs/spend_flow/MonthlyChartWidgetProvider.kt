package com.dk24labs.spend_flow

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONArray
import kotlin.math.max

class MonthlyChartWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_monthly_chart).apply {
                // Open App on Container Click
                val appIntent = HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_container, appIntent)


                val monthlyIncome = widgetData.getString("monthly_income", "0 ₫") ?: "0 ₫"
                val monthlyExpense = widgetData.getString("monthly_expense", "0 ₫") ?: "0 ₫"
                setTextViewText(R.id.tv_monthly_income, monthlyIncome)
                setTextViewText(R.id.tv_monthly_expense, monthlyExpense)

                // Chart data
                val chartJson = widgetData.getString("monthly_daily_chart", null)
                if (chartJson != null) {
                    try {
                        val array = JSONArray(chartJson)
                        val barViewIds = intArrayOf(
                            R.id.bar_view_1, R.id.bar_view_2, R.id.bar_view_3,
                            R.id.bar_view_4, R.id.bar_view_5, R.id.bar_view_6, R.id.bar_view_7
                        )
                        val dayViewIds = intArrayOf(
                            R.id.tv_day_1, R.id.tv_day_2, R.id.tv_day_3,
                            R.id.tv_day_4, R.id.tv_day_5, R.id.tv_day_6, R.id.tv_day_7
                        )

                        val count = minOf(array.length(), 7)
                        val startIndex = max(0, array.length() - 7)

                        for (i in 0 until 7) {
                            val dataIndex = startIndex + i
                            if (dataIndex < array.length()) {
                                val item = array.getJSONObject(dataIndex)
                                val day = item.optInt("day", i + 1)
                                setTextViewText(dayViewIds[i], "$day")
                            } else {
                                setTextViewText(dayViewIds[i], "${i + 1}")
                            }
                        }
                    } catch (e: Exception) {
                        // Keep default layout
                    }
                }
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
