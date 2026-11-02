# 📚 LibraTrack – Library Management System

## 📌 Project Overview

LibraTrack is a relational database management system developed using MySQL to manage library operations efficiently. It maintains information about books, authors, members, borrowing transactions, and overdue fines.

The project focuses on database design, relational data management, SQL queries, and data analysis.

## 🛠️ Technologies Used

- **Database:** MySQL
- **Database Management Tool:** MySQL Workbench
- **Language:** SQL
- **Version Control:** Git and GitHub

## 🗄️ Database Structure

The LibraTrack database consists of six tables:

| Table | Description |
|---|---|
| Members | Stores member details such as name, email, phone, city, and membership status. |
| Books | Stores book information, including title, genre, publisher, ISBN, and copy availability. |
| Authors | Maintains author names and country information. |
| Issues | Records book borrowing, due dates, and return transactions. |
| Fines | Stores overdue fine amounts, fine dates, and payment status. |
| Book_Authors | Implements the many-to-many relationship between books and authors. |

## 🔗 Entity Relationships

The database follows these relationships:

- **Members → Issues:** One-to-Many (1:M)
- **Books → Issues:** One-to-Many (1:M)
- **Issues → Fines:** One-to-One (1:0..1)
- **Books → Authors:** Many-to-Many (M:M), implemented through the Book_Authors junction table.

The database uses primary keys, foreign keys, unique constraints, and check constraints to maintain data integrity.

## 💻 SQL Concepts Implemented

The project demonstrates the following SQL concepts:

- Database and table creation
- Primary Keys and Foreign Keys
- Constraints and data integrity
- INSERT, UPDATE, and SELECT statements
- WHERE and ORDER BY clauses
- GROUP BY and HAVING clauses
- Aggregate functions (COUNT, SUM, AVG)
- INNER JOIN and LEFT JOIN
- Subqueries
- Window functions (RANK, ROW_NUMBER)
- Common Table Expressions concepts and analytical queries
- Indexes and Views
- Date functions (DATEDIFF, CURDATE, DATE_FORMAT)
- Conditional expressions (CASE, COALESCE)

## 📊 Key Business Queries

The project includes SQL queries to solve practical library management problems:

1. **Overdue Books:** Identify books that have passed their due dates and calculate estimated fines.
2. **Most Borrowed Books:** Find the five most frequently borrowed books.
3. **Total Fines per Member:** Calculate total and unpaid fines for each member.
4. **Monthly Borrowing Trends:** Analyse the number of books issued each month.
5. **Books Never Borrowed:** Identify books that have never been issued.
6. **Author Analysis:** Find the number of books associated with each author.
7. **Fine Analysis:** Analyse paid and unpaid fines.
8. **Member Ranking:** Rank members based on their total fines.

## 📁 Project Structure

```text
LibraTrack/
│
├── sql/
│   ├── 01_Database.sql
│   ├── 02_create_tables.sql
│   ├── 03_insert_data.sql
│   └── 04_indexes_views.sql
│
├── queries/
│   ├── 01_basic_queries.sql
│   ├── 02_groupby.sql
│   ├── 03_joins.sql
│   └── 04_required_advanced.sql
│
├── er_diagram/
│   └── LibraTrack_ER_Diagram.png
│
├── screenshots/
│
├── dashboard/
│
├── documentation/
│
└── README.md
```

## 🚀 How to Run the Project

1. Install MySQL Server and MySQL Workbench.
2. Clone this repository:

   ```bash
   git clone https://github.com/YOUR_USERNAME/LibraTrack-Library-Management-System.git
   ```

3. Open MySQL Workbench and connect to your MySQL Server.
4. Execute the SQL scripts in the following order:

   - `01_Database.sql`
   - `02_create_tables.sql`
   - `03_insert_data.sql`
   - `04_indexes_views.sql`

5. Execute the SQL files from the `queries` folder to explore the database and perform analysis.

**Note:** The table creation script uses `DROP TABLE IF EXISTS`. Running it again will delete existing tables and their data before recreating them. Use it only when you intend to rebuild the database.

## 🎯 Project Objectives

- Design and implement a relational database using MySQL.
- Establish relationships between multiple entities.
- Apply SQL concepts to real-world library management scenarios.
- Analyse borrowing patterns and overdue transactions.
- Generate meaningful insights using SQL queries.

---

⭐ If you find this project useful, consider giving the repository a star.
