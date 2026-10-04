with orders as (

    select * from {{ ref('stg_order') }}

),

users as (

    select * from {{ ref('dim_users') }}

),

order_eods as (

    select
        order_id,
        user_id,
        product,
        category,
        opened_at,
        closed_at,
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
    order_eods.order_id,
    order_eods.user_id,
    users.login,
    order_eods.product,
    order_eods.category,
    users.platform,
    order_eods.opened_at,
    order_eods.closed_at,
    order_eods.eod_count,
    case
        when users.region = 'Muslim_Majority_Europe' then 'admin'
        else 'swap'
    end as fee_type

from order_eods
left join users
    on order_eods.user_id = users.user_id
