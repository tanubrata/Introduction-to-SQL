/*1. Which directors have no movie data associated with them?*/
select CONCAT(p.firstname, CONCAT(' ',p.lastname)) Full_Name, d.movieid movie_id from films.movieperson p LEFT OUTER JOIN films.directs d ON p.moviepersonid=d.moviepersonid where p.occupation='director' AND d.movieid IS NULL; 
/*2. Generate a table with the names of studios that do not produce any movie.*/
select s.name Studio_names from films.filmstudio s LEFT OUTER JOIN films.movie m ON s.filmstudioid=m.filmstudioid where m.title IS NULL;
/*3. Which countries have no language recorded for them?*/
select c.name country from world.country c LEFT OUTER JOIN world.countrylanguage l on c.code=l.countrycode where l.language IS NULL;
/*4. Find the number of products for each store ordered from each vendor in 2010. Show NULL if a store does not order products from a vendor. The full table includes many rows. You only need to list (1) top 10 the most number of products, and (2) write down the total number of rows in the full table(Hint: ROWNUM).*/
 SELECT s.store_id, v.vendor_id,so2010.num FROM grocery.Store s CROSS JOIN grocery.Vendor v LEFT OUTER JOIN(SELECT so.store_id, so.vendor_id, COUNT(so.product_id) num FROM grocery.Store_order so INNER JOIN grocery.Product_Batch pb ON so.product_id=pb.product_id WHERE EXTRACT(YEAR FROM pb.order_date)=2010 GROUP BY so.store_id, so.vendor_id) so2010 ON so2010.vendor_id = v.vendor_id AND so2010.store_id = s.store_id ORDER BY num DESC;
 
 
 /*q6 hw11*/
 SELECT b.branch_id, p.product_cd, NVL(total.s,0) total FROM bank.branch b CROSS JOIN bank.product p LEFT OUTER JOIN(SELECT open_branch_id, product_cd, sum(avail_balance) s FROM bank.account GROUP BY open_branch_id, product_cd) total ON total.open_branch_id=b.branch_id AND total.product_cd=p.product_cd ORDER BY b.branch_id;

select tot.branch,
SUM(CASE WHEN tot.product='CHK' THEN tot.balance ELSE 0 END) CHECKING,
SUM(CASE WHEN tot.product='BUS' THEN tot.balance ELSE 0 END) BUSINESS,
SUM(CASE WHEN tot.product='AUT' THEN tot.balance ELSE 0 END) AUTOLOAN,
SUM(CASE WHEN tot.product='CD' THEN tot.balance ELSE 0 END) CERTIFICATE_DEPOSIT,
SUM(CASE WHEN tot.product='MM' THEN tot.balance ELSE 0 END) MONEY_MARKET,
SUM(CASE WHEN tot.product='MRT' THEN tot.balance ELSE 0 END) MORTGAGE,
SUM(CASE WHEN tot.product='SAV' THEN tot.balance ELSE 0 END) SAVINGS,
SUM(CASE WHEN tot.product='SBL' THEN tot.balance ELSE 0 END) BUSINESS_LOAN
FROM(select b.branch_id branch, p.product_cd product, p.product_type_cd, NVL(SUM(a.avail_balance),0) balance from bank.branch b cross join bank.product p left outer join bank.account a on b.branch_id=a.open_branch_id AND p.product_cd=a.product_cd GROUP BY (b.branch_id, p.product_cd, p.product_type_cd) ORDER BY b.branch_id)tot GROUP BY ROLLUP (tot.branch) ORDER BY tot.branch;
