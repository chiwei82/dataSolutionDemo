select
    id as order_id,
    userid as user_id,
    product,
    category,
    cast(opentime as timestamp) as opened_at,
    cast(closetime as timestamp) as closed_at,
    cast(_etl_loaded_at as timestamp) as _etl_loaded_at

from {{ source('trading', 'orders') }}
