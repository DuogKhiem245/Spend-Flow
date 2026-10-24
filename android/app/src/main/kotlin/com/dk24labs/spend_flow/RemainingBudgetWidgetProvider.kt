package com.dk24labs.spend_flow

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.Color
import android.net.Uri
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONArray

class RemainingBudgetWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_remaining_budget).apply {
                // Open App on Container Click
                val appIntent = HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_container, appIntent)

                // Open Voice Input on Mic Button Click
                val voiceIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("spendflow://voice_input")
                )
                setOnClickPendingIntent(R.id.btn_voice_input, voiceIntent)

                val remaining = widgetData.getString("budget_remaining", "0 ₫") ?: "0 ₫"
                val spent = widgetData.getString("budget_spent", "0 ₫") ?: "0 ₫"
                val total = widgetData.getString("budget_total", "0 ₫") ?: "0 ₫"
                val percent = widgetData.getString("budget_percent", "0%") ?: "0%"
                val progressDouble = widgetData.getFloat("budget_progress", 0.0f)

                setTextViewText(R.id.tv_budget_remaining, remaining)
                setTextViewText(R.id.tv_spent_and_total, "Đã tiêu: $spent / $total")
                setTextViewText(R.id.tv_budget_percent, percent)

                val progressInt = (progressDouble * 100).toInt().coerceIn(0, 100)
                setProgressBar(R.id.pb_budget, 100, progressInt, false)

                if (progressDouble >= 0.9f) {
                    setTextColor(R.id.tv_budget_percent, Color.parseColor("#FF453A"))
                    setTextColor(R.id.tv_budget_remaining, Color.parseColor("#FF453A"))
                } else if (progressDouble >= 0.7f) {
                    setTextColor(R.id.tv_budget_percent, Color.parseColor("#FF9F0A"))
                } else {
                    setTextColor(R.id.tv_budget_percent, Color.parseColor("#32D74B"))
                }

                // Category Budgets
                val catJson = widgetData.getString("category_budgets", null)
                if (catJson != null) {
                    try {
                        val array = JSONArray(catJson)
                        if (array.length() > 0) {
                            val cat1 = array.getJSONObject(0)
                            setViewVisibility(R.id.row_cat_1, View.VISIBLE)
                            setTextViewText(R.id.tv_cat1_name, cat1.optString("name", "Danh mục"))
                            setTextViewText(R.id.tv_cat1_remaining, "Còn " + cat1.optString("formattedRemaining", "0 ₫"))
                        } else {
                            setViewVisibility(R.id.row_cat_1, View.GONE)
                        }

                        if (array.length() > 1) {
                            val cat2 = array.getJSONObject(1)
                            setViewVisibility(R.id.row_cat_2, View.VISIBLE)
                            setTextViewText(R.id.tv_cat2_name, cat2.optString("name", "Danh mục"))
                            setTextViewText(R.id.tv_cat2_remaining, "Còn " + cat2.optString("formattedRemaining", "0 ₫"))
                        } else {
                            setViewVisibility(R.id.row_cat_2, View.GONE)
                        }
                    } catch (e: Exception) {
                        setViewVisibility(R.id.row_cat_1, View.GONE)
                        setViewVisibility(R.id.row_cat_2, View.GONE)
                    }
                } else {
                    setViewVisibility(R.id.row_cat_1, View.GONE)
                    setViewVisibility(R.id.row_cat_2, View.GONE)
                }
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
