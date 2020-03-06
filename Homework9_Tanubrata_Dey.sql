/*1. What is the pending balance in all non-business customers’ checking accounts?*/
 select a.cust_id, a.product_cd, a.pending_balance from bank.account a INNER JOIN bank.individual i ON a.cust_id=i.cust_id where a.product_cd='CHK';
/*2. What are the full names of all vendors who can supply more than one item or are based in Illinois?*/
select c.vendor_id, v.name, a.state_territory_province, count(c.product_id) FROM grocery.vendor v INNER JOIN grocery.can_supply c on v.vendor_id=c.vendor_id INNER JOIN grocery.vendor_address a on c.vendor_id=a.vendor_id GROUP BY(c.vendor_id, v.name, a.state_territory_province) HAVING count(c.product_id)>1 OR a.state_territory_province='Illinois';
/* 3.What is the minimum available balance in all accounts for each customer and overall for all customers?*/
select tmp.name, MIN(tmp.bal) from ((select CONCAT(i.fname, CONCAT(' ', i.lname)) name, a.avail_balance bal FROM bank.account a INNER JOIN bank.individual i ON a.cust_id = i.cust_id) UNION (SELECT b.name, a.avail_balance FROM bank.account a INNER JOIN bank.business b ON a.cust_id=b.cust_id)) tmp GROUP BY ROLLUP (tmp.name);
/* 4.  What  is  the  full  name  of  the  countries  that  have  more  than 3 official  languages,  and  how  many  does each one have?*/
select c.code, c.name, count(l.language) from world.countrylanguage l INNER JOIN world.country c on l.countrycode=c.code where l.isofficial='T' GROUP BY(c.code, c.name) HAVING count(l.language)>3;
/* 5. Display the number of countries that speak 1 official language, 2 official languages, and so on.*/
select wd.num_language, count(wd.code) num_country from(select w.countrycode code, count(w.language) num_language from (select countrycode, language from world.countrylanguage where isofficial='T')w GROUP BY(w.countrycode))wd GROUP BY (wd.num_language);
/* 6. Which cities of over three million people are in countries where English is an official language?*/
select c.name, c.countrycode from world.city c INNER JOIN world.countrylanguage l on c.countrycode=l.countrycode WHERE c.population>3000000 AND (l.language='English' AND l.isofficial='T');
/* 7. What is the number of large cities on each continent such that the total “large city population” on the continent is at least 25 million?*/
select b.continent, count(a.name), sum(a.population) FROM world.city a INNER JOIN world.country b on a.countrycode=b.code WHERE a.population>3000000 GROUP BY(b.continent) HAVING sum(a.population)>=25000000;
/* 8. Which large cities are in countries with no more than 2 languages spoken?*/
 select a.name city, b.name country, count(c.language) language_num from world.city a INNER JOIN world.country b on a.countrycode=b.code INNER JOIN world.countrylanguage c on b.code=c.countrycode WHERE a.population>3000000 GROUP BY(a.name, b.name) HAVING count(c.language)<=2;
/* 9. In order of number of languages, what are the names of the countries where 10 or more languages are spoken and how many languages are spoken in each? Use a single query.*/ 
select c.name country, count(l.language) number_of_language from world.country c INNER JOIN world.countrylanguage l on c.code=l.countrycode GROUP BY(c.name) HAVING count(l.language)>=10 ORDER BY count(l.language);
/* 10.  Which  countries  have  average  city  populations  for  the  cities  recorded  in  the  database  of  at  least  3 million but no more than 7 million?*/
select c.name country, AVG(d.population) avg_population from world.country c INNER JOIN world.city d on c.code=d.countrycode GROUP BY(c.name) HAVING AVG(d.population)>=3000000 AND AVG(d.population)<=7000000;