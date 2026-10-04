with orders as (

    select * from {{ ref('_stg_order') }}

),

users as (

    select * from {{ ref('_stg_user') }}

),

country_region as (

    select * from {{ ref('country_region') }}

),

order_positions as (

    select
        order_id,
        user_id,
        product,
        category,
        (
            select count(*)
            from unnest(
                generate_date_array(
                    date(opened_at),
                    date_sub(date(closed_at), interval 1 day)
                )
            ) as eod_date
            where extract(dayofweek from eod_date) not in (1, 7)
                and not (extract(month from eod_date) = 12 and extract(day from eod_date) = 25)
        ) as eod_count

    from orders

)

select
    order_positions.order_id,
    order_positions.user_id,
    users.login,
    order_positions.product,
    order_positions.category,
    users.platform,
    order_positions.eod_count,
    case
        when country_region.region = 'Muslim_Majority_Europe' then 'admin'
        else 'swap'
    end as fee_type

from order_positions
left join users
    on order_positions.user_id = users.user_id
left join country_region
    on users.country_code = country_region.country_code
