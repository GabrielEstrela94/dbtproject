WITH prod AS 
(
    SELECT

    ct.CategoryName category_name
    ,sp.CompanyName suppliers
    ,pd.ProductName product_name
    ,pd.UnitPrice unit_price
    ,pd.ProductId product_id

    FROM {{source('sources', 'products')}} pd
    LEFT JOIN {{source('sources', 'suppliers')}} sp using(SupplierID)
    LEFT JOIN {{source('sources', 'categories')}} ct using(CategoryID)
)
,orddetai AS
(
    SELECT  
        pd.*
        ,od.order_id
        ,od.quantity
        ,od.discount
    FROM {{ref('orderdetails')}} od
    LEFT JOIN prod pd using(product_id)
)
,ordrs AS
(
    SELECT

        ord.OrderDate order_date
        ,ord.OrderID order_id
        ,cs.CompanyName customer
        ,em.Name employee
        ,em.age
        ,em.lengthofservice

    FROM {{source('sources', 'orders')}} ord
    LEFT JOIN {{ref('customers')}} cs using(CustomerID)
    LEFT JOIN {{ref('employees')}} em using(EmployeeID)
    LEFT JOIN {{source('sources', 'shippers')}} sh ON (ord.ShipVia = sh.ShipperID)
)
,finaljoin AS
(
    SELECT
        od.*
        ,ord.order_date
        ,ord.customer
        ,ord.employee
        ,ord.age
        ,ord.lengthofservice
    FROM orddetai od
    INNER JOIN ordrs ord using(order_id)
)

SELECT * FROM finaljoin