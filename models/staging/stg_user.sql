select
    id as user_id,
    login,
    platform,
    country as country_code,
    cast(_create_time as timestamp) as created_at

from {{ source('trading', 'users') }}
