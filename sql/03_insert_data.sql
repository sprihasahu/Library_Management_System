USE LibraTrack;

INSERT INTO Authors (Author_Name, Country) VALUES
('Chinua Achebe','Nigeria'),
('Rabindranath Tagore','India'),
('George Orwell','United Kingdom'),
('Jane Austen','United Kingdom'),
('R.K. Narayan','India'),
('Arundhati Roy','India'),
('Paulo Coelho','Brazil'),
('Harper Lee','United States'),
('Neil Gaiman','United Kingdom'),
('Terry Pratchett','United Kingdom');

INSERT INTO Members (Full_Name, Email, Phone, City, Join_Date, Status) VALUES
('Aarav Sharma','aarav.sharma@example.com','9000000001','Kolkata','2025-12-10','Active'),
('Priya Das','priya.das@example.com','9000000002','Kolkata','2025-12-15','Active'),
('Rohan Mehta','rohan.mehta@example.com','9000000003','Mumbai','2026-01-02','Active'),
('Sneha Roy','sneha.roy@example.com','9000000004','Berhampore','2026-01-05','Active'),
('Imran Khan','imran.khan@example.com','9000000005','Delhi','2026-01-08','Active'),
('Ananya Ghosh','ananya.ghosh@example.com','9000000006','Kolkata','2026-01-20','Active'),
('Vikram Singh','vikram.singh@example.com','9000000007','Jaipur','2026-01-25','Active'),
('Meera Nair','meera.nair@example.com','9000000008','Kochi','2026-02-01','Inactive'),
('Arjun Patel','arjun.patel@example.com','9000000009','Ahmedabad','2026-02-05','Active'),
('Kavya Iyer','kavya.iyer@example.com','9000000010','Chennai','2026-02-10','Active');

INSERT INTO Books (Title, Genre, Publisher, Publication_Year, ISBN, Total_Copies, Available_Copies) VALUES
('Things Fall Apart','Fiction','Heinemann',1958,'9780000000011',4,4),
('Gitanjali','Poetry','Macmillan',1912,'9780000000028',3,3),
('Nineteen Eighty-Four','Dystopian','Secker & Warburg',1949,'9780000000035',5,5),
('Animal Farm','Satire','Secker & Warburg',1945,'9780000000042',3,3),
('Pride and Prejudice','Romance','T. Egerton',1813,'9780000000059',3,3),
('Malgudi Days','Short Stories','Indian Thought Publications',1943,'9780000000066',2,2),
('The God of Small Things','Fiction','IndiaInk',1997,'9780000000073',3,3),
('The Alchemist','Adventure','HarperOne',1988,'9780000000080',4,4),
('To Kill a Mockingbird','Fiction','J.B. Lippincott',1960,'9780000000097',3,3),
('Good Omens','Fantasy','Gollancz',1990,'9780000000103',3,3),
('American Gods','Fantasy','William Morrow',2001,'9780000000110',2,2),
('The Guide','Fiction','Viking Press',1958,'9780000000127',2,2);

INSERT INTO Book_Authors (Book_ID, Author_ID) VALUES
(1,1),(2,2),(3,3),(4,3),(5,4),(6,5),(7,6),(8,7),(9,8),(10,9),(10,10),(11,9),(12,5);

INSERT INTO Issues (Member_ID, Book_ID, Issue_Date, Due_Date, Return_Date) VALUES
(1,1,'2026-01-05','2026-01-19','2026-01-18'),
(2,3,'2026-01-07','2026-01-21','2026-01-25'),
(3,5,'2026-01-10','2026-01-24','2026-01-22'),
(4,8,'2026-01-12','2026-01-26','2026-02-05'),
(5,10,'2026-01-15','2026-01-29','2026-01-28'),
(1,3,'2026-02-01','2026-02-15','2026-02-14'),
(6,7,'2026-02-03','2026-02-17','2026-02-20'),
(7,9,'2026-02-05','2026-02-19','2026-02-19'),
(2,1,'2026-02-10','2026-02-24','2026-03-04'),
(8,4,'2026-02-12','2026-02-26','2026-02-25'),
(9,11,'2026-02-15','2026-03-01','2026-03-10'),
(10,6,'2026-02-20','2026-03-06','2026-03-05'),
(3,3,'2026-03-01','2026-03-15','2026-03-14'),
(1,8,'2026-03-05','2026-03-19','2026-03-30'),
(5,3,'2026-03-10','2026-03-24','2026-03-23'),
(6,10,'2026-03-12','2026-03-26','2026-03-26'),
(4,3,'2026-04-01','2026-04-15','2026-04-17'),
(7,12,'2026-04-03','2026-04-17','2026-04-16'),
(2,5,'2026-04-08','2026-04-22','2026-05-02'),
(8,3,'2026-04-15','2026-04-29','2026-04-28'),
(9,1,'2026-05-02','2026-05-16','2026-05-15'),
(10,9,'2026-05-05','2026-05-19','2026-05-30'),
(3,8,'2026-05-10','2026-05-24',NULL),
(5,11,'2026-06-01','2026-06-15',NULL),
(1,7,'2026-06-10','2026-06-24',NULL),
(6,3,'2026-07-01','2026-07-15',NULL),
(2,10,'2026-09-01','2026-09-15',NULL),
(7,3,'2026-10-10','2026-10-24',NULL),
(4,5,'2026-10-20','2026-11-03',NULL);

UPDATE Books b
SET b.Available_Copies = b.Total_Copies - (
    SELECT COUNT(*) FROM Issues i
    WHERE i.Book_ID = b.Book_ID AND i.Return_Date IS NULL
)
WHERE b.Book_ID > 0;

INSERT INTO Fines (Issue_ID, Fine_Amount, Fine_Date)
SELECT Issue_ID, DATEDIFF(Return_Date, Due_Date) * 5.00, Return_Date
FROM Issues
WHERE Return_Date > Due_Date;

UPDATE Fines SET Payment_Status = 'Paid'
WHERE Fine_ID > 0 AND Fine_Amount <= 30;