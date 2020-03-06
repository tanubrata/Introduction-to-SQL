/*1.How many California cities are on record?*/
 select count(name) from world.city where district='California';
/*2.Which East Coast cities (Maine, New Hampshire, Massachusetts, Rhode Island, Connecticut, New York, New Jersey, Delaware, Maryland, Virginia, North Carolina, South Carolina, Georgia, and Florida) have less than a million people?*/ 
 select id, name from world.city where district IN ('Maine', 'New Hampshire', 'Massachusetts', 'Rhode Island', 'Connecticut', 'New York', 'New Jersey', 'Delaware', 'Maryland', 'Virginia', 'North Carolina', 'South Carolina', 'Georgia', 'Florida') AND population<1000000;
/*3.Which Asian cities have more than 8 millionpeople and are in a country where the life expectancy is under 65?*/ 
 select a.name City, b.name Country from world.city a INNER JOIN world.country b on a.countrycode=b.code WHERE a.population>8000000 AND (b.continent='Asia') AND (b.lifeexpectancy<65);
/*4.How many countries outside Europe have French as their official language?*/ 
 select count(c.name) Answer from world.country c INNER JOIN world.countrylanguage l ON c.code=l.countrycode WHERE l.language='French' AND (l.isofficial='T') AND (c.continent!='Europe');
/*5.Which cities of at least 75 0,000 but no more than a million people are in countries where Spanish is the official language?*/ 
 select c.name City, c.district District, c.countrycode Country from world.city c INNER JOIN world.countrylanguage l on c.countrycode=l.countrycode WHERE (c.population>=750000 AND c.population<1000000) AND (l.language='Spanish') AND (l.isofficial='T');
/*6.How many countries are in the continent of North America?*/ 
 select count(name) Answer from world.country where continent='North America';
/*7.What are the names and capitals of the countries in Oceania?*/ 
 select a.name city, b.name country from world.city a INNER JOIN world.country b on a.id=b.capital WHERE b.continent='Oceania';
/*8.What different forms of government are there in South America?*/ 
 select distinct(governmentform) from world.country where region='South America';
/*9.What country has the smallest GNP and how small is it?*/ 
 select name country, min(gnp) minimum_gnp from world.country group by name having min(gnp)<=0;