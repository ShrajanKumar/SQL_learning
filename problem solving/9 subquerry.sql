use hr;
#1. From the following table, write a SQL query to find those employees who receive a higher salary than the employee with ID 163. Return first name, last name.
#Sample table: employees
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    salary > (SELECT 
            salary
        FROM
            employees
        WHERE
            employee_id = 163);
            
#2. From the following table, write a SQL query to find out which employees have the same designation as the employee whose ID is 169. Return first name, last name, department ID and job ID.
#Sample table: employees     
SELECT 
    first_name, last_name, job_id, department_id
FROM
    employees
WHERE
    job_id = (SELECT 
            job_id
        FROM
            employees
        WHERE
            employee_id = 169);
#3. From the following table, write a SQL query to find those employees whose salary matches the lowest salary of any of the departments. Return first name, last name and department ID.
#Sample table: employees   
SELECT 
    first_name, last_name, department_id
FROM
    employees
WHERE
    salary IN (SELECT 
            MIN(salary)
        FROM
            employees
        GROUP BY department_id); 

        
        
#4. From the following table, write a SQL query to find those employees who earn more than the average salary. Return employee ID, first name, last name.
#Sample table: employees  
SELECT 
    employee_id, first_name, last_name
FROM
    employees
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employees); 
            
#5. From the following table, write a SQL query to find those employees who report to that manager whose first name is ‘Payam’. Return first name, last name, employee ID and salary.
#Sample table: employees
SELECT 
    *
FROM
    employees
WHERE
    manager_id IN (SELECT 
            employee_id
        FROM
            employees
        WHERE
            first_name = 'Payam');
            
#6. From the following tables, write a SQL query to find all those employees who work in the Finance department. Return department ID, name (first), job ID and department name.            
SELECT 
    department_id,
    first_name,
    job_id,
    'Finance' AS department_name
FROM
    employees
WHERE
    department_id = (SELECT 
            department_id
        FROM
            departments
        WHERE
            department_name = 'Finance');
SELECT 
    d.department_id, e.first_name, e.job_id, d.department_name
FROM
    employees e
        JOIN
    departments d ON d.department_id = e.department_id
        AND d.department_name = 'Finance';
        
 #7 From the following table, write a SQL query to find the employee whose salary is 3000 and reporting person’s ID is 121. Return all fields.       
select* from employees where salary=3000 and manager_id=121; 

use  w3_resource;
#8. From the following tables write a SQL query to find all orders generated by London-based salespeople. Return ord_no, purch_amt, ord_date, customer_id, salesman_id.
SELECT 
    ord_no, purch_amnt, ord_date, customer_id, salesman_id
FROM
    orders
WHERE
    salesman_id IN (SELECT 
            salesman_id
        FROM
            salesman
        WHERE
            city = 'London'); 
            
#9. From the following tables write a SQL query to find all orders generated by the salespeople who may work for customers whose id is 3007. Return ord_no, purch_amt, ord_date, customer_id, salesman_id.
SELECT 
    ord_no, purch_amnt, ord_date, customer_id, salesman_id
FROM
    orders
WHERE
    salesman_id IN (SELECT 
           distinct salesman_id
        FROM
            orders
        WHERE
            customer_id = 3007);

#10  From the following tables write a SQL query to find the order values greater than the average order value of 10th October 2012. Return ord_no, purch_amt, ord_date, customer_id, salesman_id.

SELECT 
    ord_no, purch_amnt, ord_date, customer_id, salesman_id
FROM
    orders
WHERE
    purch_amnt > (SELECT 
            AVG(purch_amnt)
        FROM
            orders
        WHERE
            ord_date = '2012-10-10');
            
#11 Write a query to display all the customers whose ID is 2001 below the salesperson ID of Mc Lyon.           
SELECT 
    *
FROM
    customer
WHERE
    customer_id = (SELECT 
            salesman_id - 2001
        FROM
            salesman
        WHERE
            name = 'Mc Lyon');
            
#12  From the following tables write a SQL query to count the number of customers with grades above the average in New York City. Return grade and count
SELECT 
    grade,COUNT(*)
FROM
    customer
group by grade having
    grade > (SELECT 
            AVG(grade)
        FROM
            customer
        WHERE
            city = 'New york');
            
#13 From the following tables, write a SQL query to find those salespeople who earned the maximum commission. Return ord_no, purch_amt, ord_date, and salesman_id. 
SELECT 
    o.ord_no, o.purch_amnt, o.ord_date, o.salesman_id
FROM
    orders o,
    salesman s
WHERE
    o.salesman_id = s.salesman_id
        AND s.commission = (SELECT 
            MAX(commission)
        FROM
            salesman);
#or

    SELECT 
    ord_no, purch_amnt, ord_date, salesman_id
FROM
    orders
WHERE
    salesman_id IN (SELECT 
            salesman_id
        FROM
            salesman
        WHERE
            commission = (SELECT 
                    MAX(commission)
                FROM
                    salesman));
                    
#14  From the following tables write a SQL query to find salespeople who had more than one customer. Return salesman_id and name.  
SELECT 
    salesman_id, name
FROM
    salesman
WHERE
    salesman_id IN (SELECT 
            salesman_id
        FROM
            customer
        GROUP BY salesman_id
        HAVING COUNT(*) > 1); 
        
#15  From the following tables write a SQL query to find those orders, which are higher than the average amount of the orders of that customer. Return ord_no, purch_amt, ord_date, customer_id and salesman_id.

SELECT 
    a.ord_no,
    a.purch_amnt,
    a.ord_date,
    a.customer_id,
    a.salesman_id
FROM
    orders a
        JOIN
    (SELECT 
        customer_id, AVG(purch_amnt) AS avg_amnt
    FROM
        orders
    GROUP BY customer_id) AS b
    on a.customer_id=b.customer_id and a.purch_amnt>b.avg_amnt;
#or
SELECT 
    a.ord_no,
    a.purch_amnt,
    a.ord_date,
    a.customer_id,
    a.salesman_id
FROM
    orders a
WHERE
    purch_amnt > (SELECT 
            AVG(purch_amnt)
        FROM
            orders b
        WHERE
            b.customer_id = a.customer_id);
            
#16  Write a query to find the sums of the amounts from the orders table, grouped by date, and eliminate all dates where the sum was not at least 1000.00 above the maximum order amount for that date.
SELECT 
    ord_date, SUM(purch_amnt)
FROM
    orders
GROUP BY ord_date
HAVING SUM(purch_amnt) - MAX(purch_amnt) >= 1000;            

#17 write a SQL query to find salespeople who deal with multiple customers. Return salesman_id, name, city and commission. table:customer and salesman
SELECT 
    *
FROM
    salesman
WHERE
    salesman_id IN (SELECT 
            salesman_id
        FROM
            customer
        GROUP BY salesman_id
        HAVING COUNT(*) > 1);
        
#without groupby 
SELECT 
    *
FROM
    salesman
WHERE
    salesman_id IN (SELECT 
            distinct a.salesman_id
        FROM
            customer a
                JOIN
            customer b ON a.salesman_id = b.salesman_id
                AND a.customer_id <> b.customer_id);
                
#18 From the following tables write a SQL query to find salespeople who deal with a single customer. Return salesman_id, name, city and commission.

SELECT 
    *
FROM
    salesman
WHERE
    salesman_id NOT IN (SELECT DISTINCT
            a.salesman_id
        FROM
            customer a
                JOIN
            customer b ON a.salesman_id = b.salesman_id
                AND a.customer_id <> b.customer_id);
                
#19 From the following tables, write a SQL query to find the salespeople who deal the customers with more than one order. Return salesman_id, name, city and commission.
SELECT 
    *
FROM
    salesman
WHERE
    salesman_id IN (SELECT 
            a.salesman_id
        FROM
            orders a
                JOIN
            orders b
        WHERE
            a.customer_id = b.customer_id
                AND a.ord_no <> b.ord_no
                AND a.salesman_id = b.salesman_id);
                
SELECT 
    *
FROM
    salesman
WHERE
    salesman_id IN (SELECT 
            salesman_id
        FROM
            customer
        WHERE
            customer_id IN (SELECT 
                    customer_id
                FROM
                    orders
                GROUP BY customer_id
                HAVING COUNT(*) > 1));
                
#20  From the following tables write a SQL query to find the salespeople who deal with those customers who live in the same city. Return salesman_id, name, city and commission. 
SELECT 
    distinct s.*
FROM
    salesman s
        JOIN
    customer c
WHERE
    s.salesman_id = c.salesman_id
        AND c.city = s.city;
        
#21 From the following tables write a SQL query to find all those salespeople whose names appear alphabetically lower than the customer’s name. Return salesman_id, name, city, commission
SELECT 
    *
FROM
    salesman
WHERE
    EXISTS( SELECT 
            *
        FROM
            customer
        WHERE
            salesman.name < customer.cust_name);
            
#22 From the following table write a SQL query to find all those customers with a higher grade than all the customers alphabetically below the city of New York. Return customer_id, cust_name, city, grade, salesman_id.
select * from customer where grade> all(select grade from customer where city<"New York"); 

#23 From the following table write a SQL query to find all those orders whose order amount exceeds at least one of the orders placed on September 10th 2012. Return ord_no, purch_amt, ord_date, customer_id and salesman_id.
SELECT 
    *
FROM
    orders
WHERE
    purch_amnt > ANY (SELECT 
            purch_amnt
        FROM
            orders
        WHERE
            ord_date = '2012-09-10');
            
#24. From the following tables write a SQL query to find orders where the order amount is less than the order amount of a customer residing in London City. Return ord_no, purch_amt, ord_date, customer_id and salesman_id.
SELECT 
    *
FROM
    orders
WHERE
    purch_amnt < ANY (SELECT 
            purch_amnt
        FROM
            orders
        WHERE
            EXISTS( SELECT 
                    *
                FROM
                    customer c
                WHERE
                    city = 'London'
                        AND orders.customer_id = c.customer_id));
                        
SELECT 
    *
FROM
    orders
WHERE
    purch_amnt < ANY (SELECT 
            purch_amnt
        FROM
            customer c
                JOIN
            orders o ON c.customer_id = o.customer_id
                AND c.city = 'London');    
                
#25 write a SQL query to find those customers whose grades are higher than those living in New York City. Return customer_id, cust_name, city, grade and salesman_id. 
SELECT 
    *
FROM
    customer
WHERE
    grade > ALL (SELECT 
            grade
        FROM
            customer
        WHERE
            city = 'New york'); 
            
#26 Write a SQL query to calculate the total order amount generated by a salesperson. Salespersons should be from the cities where the customers reside. Return salesperson name, city and total order amount.	
#both cusotmer and salesman city is same
SELECT 
    s1.name, s1.city, b.amnt
FROM
    salesman s1
        JOIN
    (SELECT 
        s.salesman_id, SUM(o.purch_amnt) AS amnt
    FROM
        salesman s
    JOIN customer c ON s.salesman_id = c.salesman_id
        AND s.city = c.city
    JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY s.salesman_id) b ON s1.salesman_id = b.salesman_id;	

#may be or may not be same but salesman city should be present in customer table city
SELECT 
    a.city, a.name, b.amnt
FROM
    salesman a
        JOIN
    (SELECT 
        salesman_id, SUM(purch_amnt) as amnt
    FROM
        orders
    GROUP BY salesman_id) b ON a.salesman_id = b.salesman_id
WHERE
    a.city IN (SELECT 
            city
        FROM
            customer);
            
CREATE TABLE company_mast (
    COM_ID INT,
    COM_NAME VARCHAR(255)
);
INSERT INTO company_mast (COM_ID, COM_NAME) VALUES (11, 'Samsung'),
(12, 'iBall'),
(13, 'Epsion'),
 (14, 'Zebronics'),
(15, 'Asus'),
(16, 'Frontech');


select * from item_mast;


#27 From the following tables write a SQL query to calculate the average price of each manufacturer's product along with their name. Return Average Price and Company.
SELECT 
    a.com_name, AVG(b.pro_price)
FROM
    company_mast a
        JOIN
    item_mast b ON b.pro_com = a.com_id
GROUP BY a.com_name;

#28 From the following tables write a SQL query to calculate the average price of each manufacturer's product of having avg price 350 or more. Return Average Price and Company.
# company_mast,item_mast
SELECT 
    c.com_name, AVG(i.pro_price)
FROM
    company_mast c
        JOIN
    item_mast i ON i.pro_com = c.COM_ID
GROUP BY c.com_name
having avg(pro_price)>=350;

#29 write a SQL query to find the most expensive product of each company. Return Product Name, Price and Company.
SELECT 
    a.pro_name, a.pro_price, b.com_name
FROM
    item_mast a join company_mast b on a.pro_com = b.COM_ID
        AND a.pro_price = (SELECT 
            MAX(a.PRO_PRICE)
        FROM
            item_mast a
        WHERE
            a.pro_com = b.com_id);
            
SELECT P.pro_name AS "Product Name", 
       P.pro_price AS "Price", 
       C.com_name AS "Company"
   FROM item_mast P, company_mast C
   WHERE P.pro_com = C.com_id
     AND P.pro_price =
     (
       SELECT MAX(P.pro_price)
         FROM item_mast P
         WHERE P.pro_com = C.com_id
     ) order by P.pro_price;

SELECT 
    a.pro_name, a.pro_price, b.com_name
FROM
    (SELECT 
        pro_com, MAX(pro_price) as pro_price
    FROM
        item_mast
    GROUP BY pro_com) sub1
        JOIN
    item_mast a ON a.pro_com = sub1.pro_com
        AND a.pro_price = sub1.pro_price
        JOIN
    company_mast b ON a.pro_com = b.COM_ID order by a.pro_price ;         
            
            
#30 From the following tables write a SQL query to find the departments with the second lowest sanction amount. Return emp_fname and emp_lname.
#Sample table: emp_department,emp_details

with cte as (select distinct dpt_allotment as altmnt from emp_department ORDER BY dpt_allotment limit 2)
select e.emp_fname,e.emp_lname 
         from emp_details e 
                join emp_department d
                          on e.emp_dept=d.dpt_code and d.dpt_allotment=(select max(altmnt) from cte);

#or                          
SELECT 
    emp_fname, emp_lname
FROM
    emp_details
WHERE
    emp_dept = (SELECT 
            dpt_code
        FROM
            emp_department
        WHERE
            dpt_allotment = (SELECT 
                    MIN(dpt_allotment)
                FROM
                    emp_department
                WHERE
                    dpt_allotment > (SELECT 
                            MIN(dpt_allotment)
                        FROM
                            emp_department)));                         
	
    