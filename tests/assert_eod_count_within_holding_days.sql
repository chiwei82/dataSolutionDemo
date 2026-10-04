select
    order_id,
    opened_at,
    closed_at,
    eod_count

from {{ ref('fct_swapfee') }}

where eod_count < 0
    or eod_count > date_diff(date(closed_at), date(opened_at), day)
