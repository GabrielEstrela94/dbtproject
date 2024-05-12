SELECT

*

FROM {{ref('joins')}}
WHERE
    TRUE
    AND EXTRACT(YEAR FROM order_date) = 2021