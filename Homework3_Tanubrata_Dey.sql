DESC bank.employee;
SET linesize 150;
SET pagesize 30;
SELECT fname, lname, emp_id, superior_emp_id FROM bank.employee;

SELECT COUNT(fname) FROM bank.employee;

DESC bank.department;
SELECT name FROM bank.department;
SELECT COUNT(name) FROM bank.department;

SELECT cust_id, avail_balance FROM bank.account WHERE avail_balance<6000;
SELECT COUNT(avail_balance) FROM bank.account WHERE avail_balance<6000;

SELECT * FROM bank.business;
SELECT name FROM bank.business;

SELECT * FROM bank.employee;
SELECT fname AS First_Name, lname AS Last_Name FROM bank.employee;




SELECT MAX(avail_balance) FROM bank.account WHERE open_branch_id=2;
SELECT MIN(avail_balance) FROM bank.account WHERE open_branch_id=2;
SELECT AVG(avail_balance) FROM bank.account WHERE open_branch_id=2;

SELECT MAX(avail_balance) FROM bank.account;
SELECT open_branch_id FROM bank.account WHERE avail_balance=(SELECT MAX(avail_balance) FROM bank.account);
