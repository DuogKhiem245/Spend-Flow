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


                val lang = widgetData.getString("app_language", null)
                val locale = when {
                    lang == null -> java.util.Locale("vi")
                    lang.startsWith("en", ignoreCase = true) -> java.util.Locale.ENGLISH
                    lang.contains("hant", ignoreCase = true) || lang.contains("tw", ignoreCase = true) || lang.contains("hk", ignoreCase = true) -> java.util.Locale.TRADITIONAL_CHINESE
                    lang.startsWith("zh", ignoreCase = true) -> java.util.Locale.SIMPLIFIED_CHINESE
                    lang.startsWith("ja", ignoreCase = true) -> java.util.Locale.JAPANESE
                    lang.startsWith("ko", ignoreCase = true) -> java.util.Locale.KOREAN
                    lang.startsWith("es", ignoreCase = true) -> java.util.Locale("es")
                    lang.startsWith("fr", ignoreCase = true) -> java.util.Locale.FRENCH
                    lang.startsWith("de", ignoreCase = true) -> java.util.Locale.GERMAN
                    lang.startsWith("pt", ignoreCase = true) -> java.util.Locale("pt")
                    else -> java.util.Locale("vi")
                }
                val config = android.content.res.Configuration(context.resources.configuration)
                config.setLocale(locale)
                val localizedContext = context.createConfigurationContext(config)

                val remaining = widgetData.getString("budget_remaining", "0 ₫") ?: "0 ₫"
                val spent = widgetData.getString("budget_spent", "0 ₫") ?: "0 ₫"
                val total = widgetData.getString("budget_total", "0 ₫") ?: "0 ₫"
                val percent = widgetData.getString("budget_percent", "0%") ?: "0%"
                val progressDouble = widgetData.getFloat("budget_progress", 0.0f)

                val spentAndTotalText = localizedContext.getString(R.string.widget_budget_spent_total, spent, total)
                val defaultCategoryText = localizedContext.getString(R.string.widget_default_category)

                setTextViewText(R.id.tv_remaining_budget_label, localizedContext.getString(R.string.widget_remaining_budget))
                setTextViewText(R.id.tv_budget_remaining, remaining)
                setTextViewText(R.id.tv_spent_and_total, spentAndTotalText)
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
                            setTextViewText(R.id.tv_cat1_name, cat1.optString("name", defaultCategoryText))
                            val cat1Remaining = localizedContext.getString(R.string.widget_cat_remaining, cat1.optString("formattedRemaining", "0 ₫"))
                            setTextViewText(R.id.tv_cat1_remaining, cat1Remaining)
                        } else {
                            setViewVisibility(R.id.row_cat_1, View.GONE)
                        }

                        if (array.length() > 1) {
                            val cat2 = array.getJSONObject(1)
                            setViewVisibility(R.id.row_cat_2, View.VISIBLE)
                            setTextViewText(R.id.tv_cat2_name, cat2.optString("name", defaultCategoryText))
                            val cat2Remaining = localizedContext.getString(R.string.widget_cat_remaining, cat2.optString("formattedRemaining", "0 ₫"))
                            setTextViewText(R.id.tv_cat2_remaining, cat2Remaining)
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
