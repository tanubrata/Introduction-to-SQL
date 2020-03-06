SET linesize 200;
SET pagesize 200;


 /* 1. How many vendors are in New York state? */
 SELECT v.name, a.street_name FROM grocery.vendor v INNER JOIN grocery.vendor_address a ON v.vendor_id=a.vendor_id WHERE a.state_territory_province='New York';
 SELECT COUNT(v.name) FROM grocery.vendor v INNER JOIN grocery.vendor_address a ON v.vendor_id=a.vendor_id WHERE a.state_territory_province='New York';
 /*2. What baked goods were ordered before the current date? */
 SELECT p.name FROM grocery.product_batch p INNER JOIN grocery.belongs_to b ON p.product_id=b.product_id AND (b.category_name='baked goods') WHERE p.order_date<(select TRUNC(current_date) FROM dual);
 /*3. Which employee(s) (outputting their full names in one single column) have son(s)? */
 SELECT DISTINCT (CONCAT(e.fname,CONCAT(' ',e.lname))) AS Full_Name FROM grocery.employee e INNER JOIN grocery.dependent d ON e.essn=d.essn WHERE d.relationship='son';
  /*4. Which vendors have contact phone numbers with area code 234? */
 SELECT v.name, c.contact_name FROM grocery.vendor v INNER JOIN grocery.vendor_contact c ON v.vendor_id=c.vendor_id WHERE c.contact_phone LIKE ('234%');
  /*5.  Which salaried employees have a phone number with area code 333?*/
 SELECT e.fname, e.lname, s.salary FROM grocery.employee e INNER JOIN grocery.salaried s ON e.essn=s.essn WHERE e.phone1 LIKE '333%' OR e.phone2 LIKE '333%';
  /*6. What is the product name that is not expired and whose in-store price per item is less than $5.00?(If there is no expired date, the product will be considered to last forever)*/
 SELECT b.name,p.instore_price_per_item FROM grocery.product_batch b INNER JOIN grocery.product_batch_purchased p ON b.product_id=p.product_id AND (p.instore_price_per_item<5.00) WHERE b.expiration_date IS NULL OR (b.expiration_date>(SELECT TRUNC(current_date) FROM dual));
 