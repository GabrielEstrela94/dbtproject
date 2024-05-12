WITH calc_employees AS
(
    SELECT  

    DATE_DIFF(CURRENT_DATE(),DATE(BirthDate),YEAR) age
    ,DATE_DIFF(CURRENT_DATE(),DATE(HireDate),YEAR) lengthofservice
    ,CONCAT(FirstName," ",LastName) name
    ,*

    FROM {{source('sources','employees')}}
)

SELECT * FROM calc_employees