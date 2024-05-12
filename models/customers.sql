-- the customers model.

WITH deduplicated AS
(
SELECT  

*

FROM {{source('sources','customers')}}
QUALIFY ROW_NUMBER() OVER(PARTITION BY CompanyName, ContactName) = 1
)

SELECT * FROM deduplicated