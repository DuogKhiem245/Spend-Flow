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

class RecentTransactionsWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_recent_transactions).apply {
                // Open App on Container Click
                val appIntent = HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_container, appIntent)


                // Total Balance
                val totalBalance = widgetData.getString("total_balance", "0 ₫") ?: "0 ₫"
                setTextViewText(R.id.tv_total_balance, totalBalance)

                // Recent Transactions JSON
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
                setTextViewText(R.id.tv_balance_label, localizedContext.getString(R.string.widget_remaining_balance))
                setTextViewText(R.id.tv_empty_tx, localizedContext.getString(R.string.widget_empty_tx))
                val defaultTxTitle = localizedContext.getString(R.string.widget_default_transaction)

                val txJson = widgetData.getString("recent_transactions", null)
                if (txJson != null) {
                    try {
                        val array = JSONArray(txJson)
                        if (array.length() == 0) {
                            setViewVisibility(R.id.tv_empty_tx, View.VISIBLE)
                            setViewVisibility(R.id.tx_list_container, View.GONE)
                        } else {
                            setViewVisibility(R.id.tv_empty_tx, View.GONE)
                            setViewVisibility(R.id.tx_list_container, View.VISIBLE)

                            // Bind Row 1
                            if (array.length() > 0) {
                                val item = array.getJSONObject(0)
                                setViewVisibility(R.id.row_tx_1, View.VISIBLE)
                                setTextViewText(R.id.tv_tx1_title, item.optString("title", defaultTxTitle))
                                setTextViewText(R.id.tv_tx1_category, item.optString("categoryName", ""))
                                val amountStr = item.optString("formattedAmount", "0 ₫")
                                setTextViewText(R.id.tv_tx1_amount, amountStr)
                                val isIncome = item.optBoolean("isIncome", false)
                                setTextColor(R.id.tv_tx1_amount, if (isIncome) Color.parseColor("#32D74B") else Color.parseColor("#FF453A"))
                            } else {
                                setViewVisibility(R.id.row_tx_1, View.GONE)
                            }

                            // Bind Row 2
                            if (array.length() > 1) {
                                val item = array.getJSONObject(1)
                                setViewVisibility(R.id.row_tx_2, View.VISIBLE)
                                setTextViewText(R.id.tv_tx2_title, item.optString("title", defaultTxTitle))
                                setTextViewText(R.id.tv_tx2_category, item.optString("categoryName", ""))
                                val amountStr = item.optString("formattedAmount", "0 ₫")
                                setTextViewText(R.id.tv_tx2_amount, amountStr)
                                val isIncome = item.optBoolean("isIncome", false)
                                setTextColor(R.id.tv_tx2_amount, if (isIncome) Color.parseColor("#32D74B") else Color.parseColor("#FF453A"))
                            } else {
                                setViewVisibility(R.id.row_tx_2, View.GONE)
                            }

                            // Bind Row 3
                            if (array.length() > 2) {
                                val item = array.getJSONObject(2)
                                setViewVisibility(R.id.row_tx_3, View.VISIBLE)
                                setTextViewText(R.id.tv_tx3_title, item.optString("title", defaultTxTitle))
                                setTextViewText(R.id.tv_tx3_category, item.optString("categoryName", ""))
                                val amountStr = item.optString("formattedAmount", "0 ₫")
                                setTextViewText(R.id.tv_tx3_amount, amountStr)
                                val isIncome = item.optBoolean("isIncome", false)
                                setTextColor(R.id.tv_tx3_amount, if (isIncome) Color.parseColor("#32D74B") else Color.parseColor("#FF453A"))
                            } else {
                                setViewVisibility(R.id.row_tx_3, View.GONE)
                            }
                        }
                    } catch (e: Exception) {
                        setViewVisibility(R.id.tv_empty_tx, View.VISIBLE)
                        setViewVisibility(R.id.tx_list_container, View.GONE)
                    }
                } else {
                    setViewVisibility(R.id.tv_empty_tx, View.VISIBLE)
                    setViewVisibility(R.id.tx_list_container, View.GONE)
                }
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
