{{
    config(
        materialized = 'table',
        schema= 'prod',
        alias = 'partition2020'
    )
}}

SELECT

*

FROM {{ref('joins')}}
WHERE
    TRUE
    AND EXTRACT(YEAR FROM order_date) = 2020