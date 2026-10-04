select
    orders.order_id,
    orders.product,
    orders.category as order_category,
    product_category.category as expected_category

from {{ ref('stg_order') }} as orders
inner join {{ ref('product_category') }} as product_category
    on orders.product = product_category.product

where orders.category != product_category.category
