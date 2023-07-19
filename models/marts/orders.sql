with

orders as (

    select * from {{ ref('stg_tech_store__orders') }}

),

transactions as (

    select * from {{ ref('stg_payment_app__transactions') }}

),

products as (

    select * from {{ ref('stg_tech_store__products') }}

),

customers as (

    select * from {{ ref('stg_tech_store__customers') }}

),

sale_dated as (
    select * from {{ ref('sale_dates') }}
),


final as (

    select
        orders.order_id,
        transactions.transaction_id,
        customers.customer_id,
        customers.customer_name,
        products.product_name,
        products.category,
        products.price,
        products.currency,
        orders.quantity, 
        sale_dates.sale_date is not null as is_sale_order,       
        transactions.cost_per_unit_in_usd,
        transactions.amount_in_usd,
        transactions.tax_in_usd,
        transactions.total_charged_in_usd,
        orders.created_at,
        orders.created_at_dt,
        orders.created_at_est

    from orders

    left join transactions
        on orders.order_id = transactions.order_id

    left join products
        on orders.product_id = products.product_id

    left join customers
        on orders.customer_id = customers.customer_id
    
    left join sale_dates
        on orders.created_at_dt = sale_dates.sale_date

)

select * from final