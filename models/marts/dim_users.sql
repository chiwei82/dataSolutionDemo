with users as (

    select * from {{ ref('stg_user') }}

),

country_region as (

    select * from {{ ref('country_region') }}

)

select
    users.user_id,
    users.login,
    users.platform,
    users.country_code,
    country_region.city,
    country_region.region,
    users.created_at

from users
left join country_region
    on users.country_code = country_region.country_code
