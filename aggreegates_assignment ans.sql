-- Yogesh Rahangdale C391 
USE orderbook_activity_db;

-- #1: How many users do we have?
SELECT COUNT(*) AS userCount
FROM User;
/*
7
ROWS=1
*/

-- #2: List the username, userid, and number of orders each user has placed.
SELECT 
    u.uname, 
    u.userid, 
    COUNT(o.orderid) AS orderCount
FROM User u
LEFT JOIN orderbook_activity_db.Order o ON u.userid = o.userid
GROUP BY u.uname, u.userid;
/*
admin	1	3
alice	5	8
james	3	3
kendra	4	5
robert	6	5
sam	7	0
wiley	2	0
ROWS=7
*/

-- #3: List the username, symbol, and number of orders placed for each user and for each symbol. 
-- Sort results in alphabetical order by symbol.
SELECT 
    u.uname, 
    o.symbol, 
    COUNT(o.orderid) AS orderCount
FROM User u
JOIN orderbook_activity_db.Order o ON u.userid = o.userid
GROUP BY u.uname, o.symbol
ORDER BY o.symbol ASC;
/*
alice	A	5
james	A	1
robert	AAA	1
admin	AAPL	1
robert	AAPL	1
kendra	AAPL	1
alice	GOOG	1
admin	GS	1
kendra	GS	1
robert	MSFT	1
robert	NFLX	1
kendra	QQQ	2
kendra	SPY	1
alice	SPY	1
james	TLT	1
alice	TLT	1
james	WLY	1
robert	WLY	1
admin	WLY	1
ROWS=19
*/

-- #4: Perform the same query as the one above, but only include admin users.
SELECT uname, symbol, COUNT(o.orderid) orders
FROM orderbook_activity_db.Order o 
JOIN User u ON o.userid = u.userid 
JOIN UserRoles ur ON u.userid = ur.userid 
JOIN Role r ON ur.roleid = r.roleid
WHERE r.roleid = 1
GROUP BY u.userid, o.symbol
ORDER BY o.symbol;
/*
alice	A	5
admin	AAPL	1
alice	GOOG	1
admin	GS	1
alice	SPY	1
alice	TLT	1
admin	WLY	1
*/


-- #5: List the username and the average absolute net order amount for each user with an order.
-- Round the result to the nearest hundredth and use an alias (averageTradePrice).
-- Sort the results by averageTradePrice with the largest value at the top.
SELECT 
    u.uname, 
    ROUND(AVG(ABS(o.shares * o.price)), 2) AS averageTradePrice
FROM User u
JOIN orderbook_activity_db.Order o ON u.userid = o.userid
GROUP BY u.uname
ORDER BY averageTradePrice DESC;
/*
kendra	17109.53
admin	12182.47
robert	10417.84
alice	6280.26
james	2053.73
ROWS=5
*/
-- #6: How many shares for each symbol does each user have?
-- Display the username and symbol with number of shares.
SELECT 
    u.uname, 
    o.symbol, 
    SUM(o.shares) AS totalShares
FROM User u
JOIN orderbook_activity_db.Order o ON u.userid = o.userid
GROUP BY u.uname, o.symbol;
/*
admin	WLY	100
admin	GS	100
admin	AAPL	-15
alice	A	18
alice	SPY	100
alice	TLT	-10
alice	GOOG	100
james	A	-10
james	TLT	10
james	WLY	100
kendra	GS	-10
kendra	AAPL	-10
kendra	QQQ	-200
kendra	SPY	-75
robert	WLY	-10
robert	NFLX	-100
robert	AAPL	25
robert	AAA	10
robert	MSFT	100
ROWS=19
*/

-- #7: What symbols have at least 3 orders?
SELECT 
    o.symbol, 
    COUNT(o.orderid) AS orderCount
FROM orderbook_activity_db.Order o
GROUP BY o.symbol
HAVING COUNT(o.orderid) >= 3;
/*
A	6
AAPL	3
WLY	3
ROWS=3
*/
-- #8: List all the symbols and absolute net fills that have fills exceeding $100.
-- Do not include the WLY symbol in the results.
-- Sort the results by highest net with the largest value at the top
SELECT 
    f.symbol, 
    ABS(f.shares * f.price) AS absNetFillAmount
FROM Fill f
WHERE ABS(f.shares * f.price) > 100
  AND f.symbol <> 'WLY'
ORDER BY absNetFillAmount DESC;



-- #8: List all the symbols and absolute net fills that have fills exceeding $100.
-- Do not include the WLY symbol in the results.
-- Sort the results by highest net with the largest value at the top.
SELECT symbol, MAX(ABS(share * price)) AS abs_net_fills
FROM orderbook_activity_db.Fill
WHERE ABS(share * price)>100 AND symbol != 'WLY'
GROUP BY symbol
ORDER BY abs_net_fills DESC;
/*
1	admin	30563.00	3056.30	27506.70
5	alice	36573.00	27429.75	9143.25
1	admin	3873.00	387.30	3485.70
6	robert	3519.00	1407.60	2111.40
6	robert	3519.00	2111.40	1407.60
ROWS=5
*/
-- #9: List the top five users with the greatest amount of outstanding orders.
-- Display the absolute amount filled, absolute amount ordered, and net outstanding.
-- Sort the results by the net outstanding amount with the largest value at the top.
SELECT u.userid, uname, ABS(o.shares*o.price) abs_order_amount, ABS(f.share*f.price) abs_fill_amount, ABS(o.shares*o.price) - ABS(f.share*f.price) net_outstanding 
FROM orderbook_activity_db.Order o JOIN User u ON o.userid = u.userid LEFT JOIN Fill f ON o.orderid = f.orderid
ORDER BY net_outstanding DESC LIMIT 5;
/*
1	admin	30563.00	3056.30	27506.70
5	alice	36573.00	27429.75	9143.25
1	admin	3873.00	387.30	3485.70
6	robert	3519.00	1407.60	2111.40
6	robert	3519.00	2111.40	1407.60
ROWS=5
*/