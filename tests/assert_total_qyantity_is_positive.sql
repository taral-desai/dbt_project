-- You cant order a negative amount of products.
-- This test will return records where that is not true (and cause a failure)
select
    customer_id,
    total_quantity

from {{ ref('customers' )}}

where total_quantity < 0