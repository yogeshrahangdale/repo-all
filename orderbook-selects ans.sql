-- Yogesh Rahangdale, C391

USE orderbook_activity_db;

-- #1: List all users, including username and dateJoined.
SELECT uname, dateJoined
FROM User;
/*
admin	2023-02-14 13:13:28
wiley	2023-04-01 13:13:28
james	2023-03-15 19:15:48
kendra	2023-03-15 19:16:06
alice	2023-03-15 19:16:21
robert	2023-03-15 19:16:43
sam	2023-03-15 19:16:59
 */

-- #2: List the username and datejoined from users with the newest users at the top.
SELECT uname, dateJoined
FROM User
ORDER BY dateJoined DESC;
/*
	uname	dateJoined
	wiley	2023-04-01 13:13:28
	sam	2023-03-15 19:16:59
	robert	2023-03-15 19:16:43
	alice	2023-03-15 19:16:21
	kendra	2023-03-15 19:16:06
	james	2023-03-15 19:15:48
	admin	2023-02-14 13:13:28
*/

-- #3: List all usernames and dateJoined for users who joined in March 2023.
SELECT uname, dateJoined
FROM User
WHERE dateJoined BETWEEN '2023-03-01' AND '2023-03-31';
/*
james	2023-03-15 19:15:48
kendra	2023-03-15 19:16:06
alice	2023-03-15 19:16:21
robert	2023-03-15 19:16:43
sam	    2023-03-15 19:16:59
*/

-- #4: List the different role names a user can have.
SELECT DISTINCT name
FROM Role;
/*
admin
it
user
*/

-- #5: List all the orders.
SELECT * 
FROM orderbook_activity_db.Role;
/*
1	admin
2	it
3	user
*/

-- #6: List all orders in March where the absolute net order amount is greater than 1000.
SELECT *
FROM orderbook_activity_db.Order
WHERE (orderTime BETWEEN '2023-03-01' AND '2023-03-31')
  AND ABS(price) > 1000;
/*
null all columns
*/

-- #7: List all the unique status types from orders.
SELECT DISTINCT status
FROM orderbook_activity_db.Order;
/*
partial_fill
filled
pending
canceled_partial_fill
canceled
*/
-- #8: List all pending and partial fill orders with oldest orders first.
SELECT *
FROM orderbook_activity_db.Order 
WHERE status IN ('Pending', 'Partial Fill')
ORDER BY orderTime ASC;
/*
3	6	NFLX	2	2023-03-15 19:21:12	-100	243.15	pending
12	4	QQQ	2	2023-03-15 19:24:32	-100	268.27	pending
13	4	QQQ	2	2023-03-15 19:24:32	-100	268.27	pending
20	3	WLY	1	2023-03-15 19:51:06	100	38.73	pending
21	5	A	2	2023-03-15 20:09:38	-1	129.89	pending
22	5	A	1	2023-03-15 20:09:46	2	129.89	pending
23	5	A	1	2023-03-15 20:09:51	5	129.89	pending
24	5	A	1	2023-03-15 20:09:56	2	129.89	pending
*/
-- #9: List the 10 most expensive financial products where the productType is stock.
SELECT name, price
FROM Product
WHERE productType = 'stock'
ORDER BY price DESC
LIMIT 10;
/*
Samsung Biologics Co.,Ltd.	830000.00
Taekwang Industrial Co., Ltd.	715000.00
Young Poong Corporation	630000.00
Korea Zinc Company, Ltd.	616000.00
Samsung SDI Co., Ltd.	605000.00
LG H&H Co., Ltd.	575000.00
LG Chem, Ltd.	575000.00
Ottogi Corporation	441500.00
Berkshire Hathaway Inc.	418391.00
SK Materials Co., Ltd.	402900.00
*/

-- #10: Display orderid, fillid, userid, symbol, and absolute net fill amount
SELECT orderid, fillid, userid, symbol, ABS(share * price) AS absNetFillAmount
FROM Fill
WHERE ABS(share * price) > 1000
ORDER BY absNetFillAmount DESC;
/* 
11	11	5	SPY	27429.75
14	12	4	SPY	27429.75
6	5	1	GS	3056.30
7	6	4	GS	3056.30
8	9	6	AAPL	2111.40
10	10	1	AAPL	2111.40
8	7	6	AAPL	1407.60
9	8	4	AAPL	1407.60
4	3	5	A	1298.90
5	4	3	A	1298.90
*/
