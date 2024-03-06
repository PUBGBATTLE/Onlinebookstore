CREATE DATABASE onlineBookstore1;
USE onlineBookstore1;

-- Table for Authors
CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

-- Table for Books
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    price DECIMAL(10, 2),
    release_date DATE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- Table for Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    address VARCHAR(255)
);

-- Table for Orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert values into Authors table
INSERT INTO authors (author_id, author_name) VALUES
(1, 'Author A'),
(2, 'Author B'),
(3, 'Author C'),
(4, 'Author D'),
(5, 'Author E'),
(6, 'Author F'),
(7, 'Author G'),
(8, 'Author H'),
(9, 'Author I');

-- Insert values into Books table
INSERT INTO books (book_id, title, author_id, price, release_date) VALUES
(101, 'book 1', 1, 18.99, '2022-01-01'),
(102, 'book 2', 1, 19.99, '2022-02-28'),
(103, 'book 3', 2, 20.99, '2022-12-10'),
(104, 'book 4', 3, 25.99, '2022-03-05'),
(105, 'book 5', 4, 27.99, '2022-04-10'),
(106, 'book 6', 5, 18.99, '2022-03-15'),
(107, 'book 7', 8, 14.99, '2022-02-28'),
(108, 'book 8', 5, 12.99, '2022-01-05'),
(109, 'book 9', 7, 110.99, '2022-12-20'),
(110, 'book 10', 9, 10.99, '2022-05-05'),
(111, 'book 11', 4, 18.99, '2022-06-10'),
(112, 'book 12', 6, 18.99, '2022-07-15');

-- Select all from Books table
SELECT * FROM books;

-- Insert values into Customers table
INSERT INTO customers (customer_id, customer_name, email, address) VALUES
(1001, 'Customer A', 'customerA@email.com', '123 Main St, City X'),
(1002, 'Customer B', 'customerB@email.com', '456 Oak St, City Y'),
(1003, 'Customer C', 'customerC@email.com', '789 Elm St, City Z'),
(1004, 'Customer D', 'customerD@email.com', '789 Pine St, City X'),
(1005, 'Customer E', 'customerE@email.com', '123 Oak St, City Y'),
(1006, 'Customer F', 'customerF@email.com', '456 Elm St, City Z'),
(1007, 'Customer G', 'customerG@email.com', '789 Cedar St, City X'),
(1008, 'Customer H', 'customerH@email.com', '123 Birch St, City Y'),
(1009, 'Customer I', 'customerI@email.com', '456 Maple St, City Z');

-- Insert values into Orders table
INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(2001, 1001, '2022-01-20', 49.98),
(2002, 1002, '2022-02-05', 74.97),
(2003, 1003, '2022-03-10', 39.98),
(2004, 1004, '2022-04-15', 99.98),
(2005, 1005, '2022-03-01', 124.97),
(2006, 1006, '2022-02-05', 79.98),
(2008, 1008, '2022-06-15', 89.98),
(2009, 1009, '2022-07-20', 104.97);

select * from authors,books,customers,orders;

 -- 1 Basic Select: Retrieve all columns from the "authors" table
	     select * from authors;
         
-- 2 Select all books with a price greater than $20.
     select * from books
      where price>15;
      
-- 2 Select all books with a price greater than $20.
     select * from books
      where price>20;
      
-- 3 Display the books in alphabetical order by title
     select * from books
     order by title;
     
-- 4 List all orders with customer information (use the "orders" and "customers" tables).
     select orders.*,customers.*
	 from orders
     inner join customers on orders.customer_id = customers.customer_id;
     
-- 5 Find the total number of orders for each customer.
     select customer_id,count(order_id) as order_count
     from orders
     group by customer_id;
     
-- 6 Calculate the average price of books.
     select avg(price) as average_price from books;
     
-- 7  Count the number of books with a price less than $25.
      select count(*) 
      from books
      where price<25;
      
-- 8  Retrieve unique customer names from the "customers" table.
      select distinct customer_name 
      from customers;
      
-- 9  Find the books written by 'Author A'
      select * from books
      where author_id = ( select author_id from authors where author_name = 'Author A');
      
-- 10 Subqueries:-- Find authors who have written books with prices higher than the average book price.
      select author_id,author_name
      from authors
      where author_id IN (select author_id from books where price>(select avg(price) from books));
      
-- 11 Update Statement:--Increase the price of 'Book 1' by 15%
      update books set price = price * 1.15 where title='book 1';
      SET sql_safe_updates = 0;
      
-- 12  Delete Statement:-Delete all books with a release date before '2022-01-01'.
      delete from books
      where release_date <'2022-01-01';
      
-- 13 IN Operator:-Select all books authored by 'Author A' or 'Author B'.
      select * from books 
      where author_id in ( select author_id from authors where author_name in ('Author A','Author B'));
  
-- 14 Join with Conditions:-List customers who have placed orders along with the total number of orders they placed
      SELECT customers.customer_name, COUNT(orders.order_id) as total_orders
      FROM customers
	  LEFT JOIN orders ON customers.customer_id = orders.customer_id
      GROUP BY customers.customer_id;


-- 15 Having Clause:-Find authors who have an average book price greater than $21 
      SELECT author_id, AVG(price) as avg_price
      FROM books
	  GROUP BY author_id
      HAVING avg_price > 21;

-- 16 Window Functions:-Calculate the running total of order amounts for each order.
      select order_id, total_amount,
      sum(total_amount) 
      over (order by order_id) as running_total
      from orders;
      
-- 17 UNION Operator:-Combine the names of customers and authors into a single listg 
	select customer_name
    from customers
    union select author_name from authors;
    
-- 18 LIKE Operator:-Retrieve customers with addresses containing 'City Y'.
   select * from customers
   where address like '%City Y%';
   
-- 19 Case Statement:-Display books with a category of 'Expensive' if the price is greater than $18, otherwise 'Affordable'.
   select price,title,
   case 
   when price > 18 then 'Expensive'
   else 'Affordable'
   end as pricecatagory
   from books;
 
-- 20 Subquery in SELECT:-Show the total number of orders along with the percentage of orders relative to the total number of orders.
   select count(order_id) as total_orders,
          (count(order_id) * 100.0/ (select count(*) from orders)) as percentage
          from orders;
			
            
-- 21 Self-Join:-Find customers who placed orders on the same date as other customers. 
   
   SELECT DISTINCT o1.customer_id, c1.customer_name, o1.order_date
    FROM orders o1
    JOIN orders o2 ON o1.order_date = o2.order_date AND o1.customer_id <> o2.customer_id
    JOIN customers c1 ON o1.customer_id = c1.customer_id
    JOIN customers c2 ON o2.customer_id = c2.customer_id;
    
-- 22 Update with Case Statement:- Increase the price of books by 10% if the release date is before '2022-01-01'.
   update books set price = case when release_date < '2022-01-01' 
   then price * 1.10
   else price
   end;
   
SET SQL_SAFE_UPDATES = 0;

-- 23 Cross Join:-Combine all authors with all books, showing every possible combination.
      select * from authors
      cross join books;
      
-- 24 Subquery with MAX:- Find the author with the highest-priced book.
select author_id, author_name
from authors
where author_id = (select author_id from books order by price desc limit 1);

-- 25 Date Functions:- Find books released in the last 90 days.
   select* from books
   where release_date >= curdate() - interval 90 day;

-- 26 Aggregation with Subquery:- Calculate the total amount spent by 'Customer A' on orders.
   select customer_id, Sum(total_amount) as total_spend
   from orders
   where customer_id = (select customer_id from customers where customer_name = 'Customer A')
   group by customer_id;
   
-- 27 Top N Records:-Display the top 5 authors with the highest average book prices.
   select author_id, avg(price)as avg_price
   from books
   group by author_id
   order by avg_price desc
   limit 5;
   
-- 28 Complex Query:- List authors who have not written any books.
   select authors.author_id
   from authors
   left join books on authors.author_id = books.author_id
   where books.book_id is null;
   
-- 29 Nested Subquery:-Find customers who have placed orders with a total amount greater than the average total amount of all orders.
   select customer_id, customer_name
   from customers
   where customer_id In (select customer_id from orders where total_amount > (select avg (total_amount) from orders));
   
-- 30 Aggregation with Subquery and JOIN:- Display the average order total for each customer.
       select customers.customer_id, customers.customer_name, avg(orders.total_amount) as avg_order_total
       from customers
	   left join orders on customers.customer_id = orders.customer_id
	   group by customers.customer_id, customers.customer_name;

-- 31  Update with Join and Conditions:- Set the price of all books by 'Author A' to $25.
   update books
   set price =25
   where author_id=(select author_id from authors where author_name = 'Author A');
    
-- 32 Delete with Subquery:- Delete customers who haven't placed any orders.
   delete from customers
   where customer_id not in (select distinct customer_id from orders);
   
-- 33 Join with Multiple Conditions:- List customers and their orders placed in 'City X'.
   select customer_name, orders.order_id, orders.order_date
   from customers
   inner join orders on customers.customer_id = orders.customer_id
   where customers.address like '%City X%';
   
-- 34 Aggregation with Distinct:- Calculate the total number of distinct customers who placed orders.
select count(distinct customer_id) as total_customers
from orders;

-- 35 Subquery in WHERE Clause:- Find books with prices greater than the average price of books written by 'Author B'.
   select * from books
   where price >(select avg(price) from books where author_id = (select author_id from authors where author_name = 'Author B'));
 
 -- 36 Case Statement with JOIN:- Display customer names and a column indicating whether they have placed any orders.
    select customers.customer_name,
    case 
    when orders.order_id is not null then 'Yes'
    else 'No'
    end as place_order
    From customers
    left join orders on customers.customer_id = orders.customer_id;
    
-- 37 Union with Where Clause:-Combine the titles of books and customer names into a single list, excluding those with 'Book' in the name.
   select title as name from books
   where title not like '%Book%'
   union
   select Customer_name as name from customers
   where customer_name not like '%Book%'
   order by name;
   
-- 38 Aggregation with Subquery:-  Calculate the total number of orders placed in 'City Y'.
    select count(order_id) as total_orders
    from orders
    where customer_id in ( select customer_id from customers where address like '%City Y%');
    
-- 39 Subquery with MIN:- Find the book with the lowest price.
   select * from books
   where price = ( select min(price) from books);
   
-- 40  Order By with Limit:- Display the top 3 authors with the most books.
   select author_id, author_name, count(book_id) as book_count
   from books
   group by author_id,author_name
   order by book_count desc
   limit 3;
   
