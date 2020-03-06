/* First, set the line size and page size to proper values for the easy readings of the log*/
SET linesize 150;
SET pagesize 30;

/*1. Which  movies’  show  times  are  longer  than “I  Know  What  You  Did.” but  shorter  than“Wonton Soup”?*/
select movieid, title from films.movie where runningtime > (select runningtime FROM films.movie WHERE title = 'I Know What You Did.') AND runningtime < (select runningtime FROM films.movie WHERE title='Wonton Soup');
/* I did not use the substring for runningtime because at that time I was confused and I just copy and pasted the runningtime value directly from table. But now I am aware of that.)

/*2. What are movie titles that start with letter ‘T’ and are released between 2000 and 2005?*/
 SELECT title FROM films.movie WHERE SUBSTR(title,1,1)='T' AND (year_>=2000 AND year_<=2005);
 
 /*3. How many movie people are not actors?*/
 
  SELECT COUNT(moviepersonid) AS Answer FROM films.movieperson WHERE occupation IS NOT NULL AND (occupation!='actor');
  /* Actually I was confused while observing the table and there were many blanks in occupation. The question asked where occupation is not actors and I thought that those blanks are going to be the only answer, but I was not aware that there are also other occupations mentioned other than actors.)
  
  /*4. How many theatres are in New York or Connecticut?*/
  SELECT DISTINCT count(theatreid) FROM films.theatre WHERE locationid IN (SELECT locationid FROM films.location WHERE state='NY' OR state='CT');
  /*I was not very aware at that time that it only wants the count, but rather I thought it wants name also, but now I can understand that.)
  
  /*5. Find  all  actors  whose  last  name  contains  an  ‘a’  in  the  second  position  or  first  name  ends with an ‘a’. */
  SELECT moviepersonid, firstname, lastname FROM films.movieperson WHERE occupation='actor' AND (SUBSTR(lastname,2,1)='a' OR firstname LIKE '%a');
  
  /*6. Find  all  theatres  whose  names  have  the  pattern  of  ‘nameTheatre’  (e.g.  ‘Worst  Theatre’ where ‘Worst’ is the name), and extract the name(e.g. Worst, use SUBSTR). */
SELECT name, substr(name, 1, instr(name,' ',-1)-1 ) AS NewName FROM films.theatre WHERE instr(name,'Theatre')>0; 

  /*7. Find all theatres whose names DO NOT contain whitespaces between words? Hint:checkthe usage of regular expressions in Oracle, specifically REGEXP_LIKE */
    SELECT * FROM films.theatre WHERE NOT REGEXP_LIKE(name, '[[:blank:]]');
   /*I was confused with using regular expression at that time but now I have got the idea of how to do it.*/
   
  /*8. Which individual  (not  business) customer  has  the  maximum  available  balance  in  all  of  his or her accounts
  (means the total of his or her balance), print out his or her full name with column heading “Full Name”(concatenating
  the first name and last name, with a space in between, e.g.‘Di He’not ‘DiHe’)  */
SELECT CONCAT(fname, concat(' ', lname)) AS "Full Name" FROM bank.individual 
WHERE cust_id  IN (SELECT cust_id 
	FROM (SELECT cust_id, SUM(avail_balance) AS total 
		   FROM bank.account WHERE cust_id IN (SELECT cust_id FROM bank.individual) GROUP BY cust_id) 
	           WHERE total = (SELECT MAX(total) FROM (SELECT cust_id, SUM(avail_balance) AS total FROM bank.account WHERE cust_id IN (SELECT cust_id FROM bank.individual) GROUP BY cust_id)));

  