/*1. For each US state on record in the world database, how many cities are recorded and what is their total population? Characterize them as a few (0 to2), several (anything from 3 to 5), or lots (6 ormore). You may not assume that you “know” the code for the US.*/
select a.district, count(a.city) number_of_cities, sum(a.pop) total_pop, CASE WHEN count(a.city)>=0 AND count(a.city)<=2 THEN 'few' WHEN count(a.city)>=3 AND count(a.city)<=5 THEN 'several' ELSE 'lots' END category FROM(select c.name city, c.district district, c.population pop, co.name country from world.city c INNER JOIN world.country co on c.countrycode=co.code WHERE co.name='United States' order by c.district) a GROUP BY (a.district);
/*2.  Characterize  each  African  country  as  rural  (city  population  <  25%  of  total),  urban  (city population > 75%) or mixed.*/
select tot.country, tot.num_cities, CASE WHEN ((tot.tot_city_pop * 100)/country_pop)<25 THEN 'rural' WHEN ((tot.tot_city_pop * 100)/country_pop)>75 THEN 'urban' ELSE 'mixed' END category FROM (select count(c.name) num_cities, sum(c.population) tot_city_pop,co.population country_pop, co.name country from world.country co INNER JOIN world.city c ON co.code=c.countrycode where continent='Africa' GROUP BY (co.population,co.name)) tot;
/*3. List the forms of government that are used in more than two countries, in descending order by the number of countries in which they are used.*/
select governmentform, count(name) number_of_countries from world.country GROUP BY (governmentform) HAVING count(name)>2 ORDER BY count(name) DESC;
/*4. Categorize contigs by the average number of ORFs they contain: a few (less than 10), many (over 50), or typical.*/
SELECT c.mol_name, CASE WHEN count(o.orf_id)<10 THEN 'few' WHEN count(o.orf_id)>50 THEN 'many' ELSE 'typical' END category FROM genome.contig c INNER JOIN genome.orf o ON c.mol_id = o.mol_id GROUP BY (c.mol_name);
﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿
/*5. For each contig, report how many ORFs are of each length: 1-299, 300-599,  600-899, or longer.*/
SELECT c.mol_name contig,
SUM(CASE WHEN (orf_end_coord-orf_begin_coord+1) BETWEEN 1 AND 299 THEN 1 ELSE 0 END) "1-299",
SUM(CASE WHEN (orf_end_coord-orf_begin_coord+1) BETWEEN 300 AND 599 THEN 1 ELSE 0 END) "300-599",
SUM(CASE WHEN (orf_end_coord-orf_begin_coord+1) BETWEEN 600 AND 899 THEN 1 ELSE 0 END) "600-899",
SUM(CASE WHEN (orf_end_coord-orf_begin_coord+1) > 900 THEN 1 ELSE 0 END) longer
FROM genome.contig c INNER JOIN genome.orf o ON c.mol_id = o.mol_id GROUP BY (c.mol_name); 
/*6. Use conditional logic to output a crosstab table for total amount of available balance for each branch and each product type. If it is null, output 0.*/
select tot.branch, 
SUM(CASE WHEN tot.type='ACCOUNT' THEN tot.balance ELSE 0 END) ACCOUNT,
SUM(CASE WHEN tot.type='LOAN' THEN tot.balance ELSE 0 END) LOAN
FROM(select b.branch_id branch, p.product_cd product, p.product_type_cd type, NVL(SUM(a.avail_balance),0) balance from bank.branch b cross join bank.product p left outer join bank.account a on b.branch_id=a.open_branch_id AND p.product_cd=a.product_cd GROUP BY (b.branch_id, p.product_cd, p.product_type_cd) ORDER BY b.branch_id)tot GROUP BY (tot.branch) ORDER BY tot.branch;
			