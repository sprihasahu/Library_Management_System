USE LibraTrack;

DROP TABLE IF EXISTS Fines;
DROP TABLE IF EXISTS Issues;
DROP TABLE IF EXISTS Book_Authors;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Authors;

CREATE TABLE Authors (
    Author_ID    INT AUTO_INCREMENT PRIMARY KEY,
    Author_Name  VARCHAR(100) NOT NULL,
    Country      VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE Members (
    Member_ID    INT AUTO_INCREMENT PRIMARY KEY,
    Full_Name    VARCHAR(100) NOT NULL,
    Email        VARCHAR(100) NOT NULL UNIQUE,
    Phone        VARCHAR(15),
    City         VARCHAR(50),
    Join_Date    DATE NOT NULL,
    Status       ENUM('Active','Inactive') NOT NULL DEFAULT 'Active'
) ENGINE=InnoDB;

CREATE TABLE Books (
    Book_ID           INT AUTO_INCREMENT PRIMARY KEY,
    Title             VARCHAR(150) NOT NULL,
    Genre             VARCHAR(50)  NOT NULL,
    Publisher         VARCHAR(100),
    Publication_Year  INT,
    ISBN              VARCHAR(20) NOT NULL UNIQUE,
    Total_Copies      INT NOT NULL CHECK (Total_Copies >= 0),
    Available_Copies  INT NOT NULL CHECK (Available_Copies >= 0),
    CHECK (Available_Copies <= Total_Copies)
) ENGINE=InnoDB;

CREATE TABLE Book_Authors (
    Book_ID    INT NOT NULL,
    Author_ID  INT NOT NULL,
    PRIMARY KEY (Book_ID, Author_ID),
    FOREIGN KEY (Book_ID)   REFERENCES Books(Book_ID)     ON DELETE CASCADE,
    FOREIGN KEY (Author_ID) REFERENCES Authors(Author_ID) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Issues (
    Issue_ID     INT AUTO_INCREMENT PRIMARY KEY,
    Member_ID    INT NOT NULL,
    Book_ID      INT NOT NULL,
    Issue_Date   DATE NOT NULL,
    Due_Date     DATE NOT NULL,
    Return_Date  DATE NULL,
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
    FOREIGN KEY (Book_ID)   REFERENCES Books(Book_ID),
    CHECK (Due_Date >= Issue_Date),
    CHECK (Return_Date IS NULL OR Return_Date >= Issue_Date)
) ENGINE=InnoDB;

CREATE TABLE Fines (
    Fine_ID         INT AUTO_INCREMENT PRIMARY KEY,
    Issue_ID        INT NOT NULL UNIQUE,
    Fine_Amount     DECIMAL(8,2) NOT NULL CHECK (Fine_Amount >= 0),
    Fine_Date       DATE NOT NULL,
    Payment_Status  ENUM('Paid','Unpaid') NOT NULL DEFAULT 'Unpaid',
    FOREIGN KEY (Issue_ID) REFERENCES Issues(Issue_ID) ON DELETE CASCADE
) ENGINE=InnoDB;