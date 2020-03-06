SET linesize 300;
SET pagesize 300;
/*1. Which stores have ordered ice cream?*/
select s.store_name, s.store_id from grocery.store_order o INNER JOIN (select product_id FROM grocery.belongs_to WHERE category_name='ice cream') b ON o.product_id=b.product_id INNER JOIN (select store_name, store_id from grocery.store) s ON o.store_id=s.store_id;
/*2. Which salaried employees are over 20 and work at Manhattan 5?*/
select DISTINCT CONCAT(e.fname, CONCAT(' ',e.lname)) AS FULL_NAME from grocery.employee e INNER JOIN (select essn from grocery.salaried) s ON e.essn=s.essn INNER JOIN (select essn, store_id FROM grocery.works_in where store_id IN (select store_id from grocery.store WHERE store_name='Manhattan 5')) w ON e.essn=w.essn;
/*3. What are the names and telephone numbers of the contacts at the vendors that sell ice cream?*/
select c.contact_name, c.contact_phone from grocery.vendor_contact c INNER JOIN (select vendor_id, product_id from grocery.store_order) o ON c.vendor_id=o.vendor_id INNER JOIN (select product_id, category_name from grocery.belongs_to WHERE category_name='ice cream') b ON o.product_id=b.product_id;
/*4. Has any product yet to arrive?*/
select b.name, b.expected_arrival_date, p.actual_arrival_date from grocery.product_batch b INNER JOIN grocery.product_batch_purchased p ON b.product_id=p.product_id AND p.actual_arrival_date IS NULL;
/*5. Who works at Manhattan 3?*/
select DISTINCT CONCAT(e.fname, CONCAT(' ', e.lname)) AS Full_Name from grocery.employee e INNER JOIN grocery.works_in w ON e.essn=w.essn WHERE w.store_id IN (select store_id from grocery.store WHERE store_name='Manhattan 3');
/*6. Which employees have both daughter and son?*/
 select DISTINCT (CONCAT(e.fname,CONCAT(' ', e.lname))) AS FULL_NAME from grocery.employee e INNER JOIN (select essn from grocery.dependent where relationship='son') d1 ON e.essn=d1.essn INNER JOIN (select essn from grocery.dependent where relationship='daughter') d2 ON d1.essn=d2.essn;