{{
    config(
        materialized = 'table',
        schema= 'prod',
        alias = 'partition2021'
    )
}}

SELECT

*

FROM {{ref('joins')}}
WHERE
    TRUE
    AND EXTRACT(YEAR FROM order_date) = 2021