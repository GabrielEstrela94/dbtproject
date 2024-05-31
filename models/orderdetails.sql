{{
    config(
        materialized = 'table',
        schema= 'prod',
        alias = 'orderdetails'
    )
}}


SELECT

od.OrderID order_id
,od.ProductId product_id
,od.UnitPrice unit_price
,od.Quantity quantity
,pr.ProductName product_name
,pr.SupplierID supplier_id
,pr.CategoryID category_id
,ROUND(od.UnitPrice * od.Quantity,2) total
,ROUND((pr.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity),2) discount 


FROM {{source('sources','orderdetails')}} od
LEFT JOIN {{source('sources','products')}} pr using(ProductId)
