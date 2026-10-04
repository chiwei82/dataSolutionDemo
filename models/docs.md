{% docs eod_count %}
Number of end-of-day (EOD) rollovers an order was held through.

- An EOD is counted for every calendar day from the open date up to the day before the close date (UTC midnight).
- Only trading days count: Saturdays, Sundays and Christmas Day (25 December) have no EOD.
- An order opened and closed on the same day has an `eod_count` of 0.
{% enddocs %}

{% docs fee_type %}
The overnight fee type that applies to the order, based on the user's region.

| fee_type | Rule |
|---|---|
| `admin` | The user's country is in the `Muslim_Majority_Europe` region (swap-free account, charged an admin fee instead) |
| `swap` | All other regions |
{% enddocs %}

{% docs region %}
Geographic region of the user's country, from the `country_region` seed: `Western_Europe`, `Eastern_Europe` or `Muslim_Majority_Europe`.
{% enddocs %}

{% docs product %}
Traded instrument symbol without separators, e.g. `EURUSD`, `XAUUSD`, `S&P 500`.
{% enddocs %}

{% docs category %}
Instrument category: `FX`, `XAU`, `XAG`, `Crude`, `Equities`, `Index` or `Cmdty`.
{% enddocs %}
