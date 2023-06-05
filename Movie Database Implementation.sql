--Movie Database / Tables, Stored Procedures and Queries
--By: James Nguyen, Irene Jo, Ethan Kim, William Yuen

CREATE TABLE Genre (
    [GenreID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Genre] VARCHAR(50) NOT NULL
)
CREATE TABLE Rating (
    [RatingID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Rating] INT NOT NULL,
    [Descr] TEXT
)
CREATE TABLE Movie (
    [MovieID] INT IDENTITY(1, 1) PRIMARY KEY, 
    [GenreID] INT FOREIGN KEY REFERENCES Genre(GenreID),
    [MovieName] VARCHAR(50) NOT NULL,
    [Origin] VARCHAR(50) NULL,
    [ReleaseDate] DATE NOT NULL,
    [BoxOffice] NUMERIC(12,2) NOT NULL,
    [Language] VARCHAR(50) NULL
)
CREATE TABLE Customer (
    [CustomerID] INT IDENTITY(1, 1) PRIMARY KEY, 
    [Firstname] VARCHAR(50) NOT NULL,
    [Lastname] VARCHAR(50) NOT NULL,
    [Email] VARCHAR(256) NOT NULL,
    [PhoneNumber] VARCHAR(50) NOT NULL,
    [Address] VARCHAR(100) NOT NULL,
    [City] VARCHAR(50) NOT NULL,
    [ZipCode] VARCHAR(50) NOT NULL,
    [DOB] DATE NOT NULL
)
CREATE TABLE Cust_Movie (
    [CustMovieID] INT IDENTITY(1, 1) PRIMARY KEY, 
    [CustomerID] INT FOREIGN KEY REFERENCES Customer(CustomerID),
    [MovieID] INT FOREIGN KEY REFERENCES Movie(MovieID),
    [DateSeen] DATE NOT NULL
)
CREATE TABLE Theater (
    [TheaterID] INT IDENTITY(1, 1) PRIMARY KEY, 
    [TheaterName] VARCHAR(100) NOT NULL,
    [Address] VARCHAR(100) NOT NULL,
    [Country] VARCHAR(50) NOT NULL,
    [City] VARCHAR(50) NOT NULL,
    [ZipCode] VARCHAR(50) NOT NULL,
    [PhoneNumber] VARCHAR(50) NOT NULL,
)
CREATE TABLE Theater_Movie (
    [TheaterMovieID] INT IDENTITY(1, 1) PRIMARY KEY, 
    [TheaterID] INT FOREIGN KEY REFERENCES Theater(TheaterID),
    [MovieID] INT FOREIGN KEY REFERENCES Movie(MovieID),
    [StartDateShown] DATE NOT NULL,
    [EndDateShown] DATE NOT NULL,
    TheaterBoxOffice NUMERIC(12,2) NOT NULL
)
CREATE TABLE Actor (
    [ActorID] INT IDENTITY (1, 1) PRIMARY KEY,
    [Firstname] VARCHAR(50) NOT NULL,
    [Lastname] VARCHAR(50) NOT NULL,
    [PhoneNumber] VARCHAR(50) NULL,
    [ProductionCompany] VARCHAR(50) NULL,
    [Gender] VARCHAR(50) NULL,
    [DOB] DATE NULL
)
CREATE TABLE DirectorType (
    [DirectorTypeID] INT IDENTITY(1, 1) PRIMARY KEY,
    [DirectorTypeName] VARCHAR(50) NOT NULL,
    [Descr] TEXT NULL
)
CREATE TABLE Director (
    [DirectorID] INT IDENTITY(1, 1) PRIMARY KEY,
    [DirectorTypeID] INT FOREIGN KEY REFERENCES DirectorType(DirectorTypeID),
    [Firstname] VARCHAR(50) NOT NULL,
    [Lastname] VARCHAR(50) NOT NULL,
    [PhoneNumber] VARCHAR(50) NULL,
    [ProductionCompany] VARCHAR(50) NULL,
    [Degree] VARCHAR(50) NULL,
    [DOB] DATE NULL
)
CREATE TABLE Actor_Movie (
    [ActorMovieID] INT IDENTITY(1, 1) PRIMARY KEY,
    [ActorID] INT FOREIGN KEY REFERENCES Actor(ActorID),
    [MovieID] INT FOREIGN KEY REFERENCES Movie(MovieID),
    [CharacterPlayed] VARCHAR(50) NOT NULL,
    [AwardsWon] INT NOT NULL
)
CREATE TABLE Direct_Movie (
    [DirectMovieID] INT IDENTITY(1, 1) PRIMARY KEY,
    [DirectorID] INT FOREIGN KEY REFERENCES Director(DirectorID),
    [MovieID] INT FOREIGN KEY REFERENCES Movie(MovieID),
    [AwardsWon] INT NOT NULL
)
CREATE TABLE Review (
    [ReviewID] INT IDENTITY(1,1) PRIMARY KEY,
    [RatingID] INT FOREIGN KEY REFERENCES Rating(RatingID),
    [CustMovieID] INT FOREIGN KEY REFERENCES Cust_Movie(CustMovieID),
    [Descr] TEXT
)
GO

INSERT INTO Genre (Genre)
VALUES 
('Action'), 
('Thriller'), 
('Drama'), 
('Romance'), 
('Adventure'), 
('Science Fiction'), 
('History'),
('Mystery'),
('Comedy'),
('Animation'),
('Western')
GO

INSERT INTO DirectorType (DirectorTypeName, Descr)
VALUES
('Writer', 'These directors are well-known for making films that have strong screenplays and eccentric, yet naturalistic dialogue. Usually, these directors write their own screenplays.'), 
('Actor', 'These directors are well-known for their sharp, precise presentation and their skills in visual story-telling. They tend to have signature visual aethistics that are unique to them.'),
('Visionary', 'These directors are well-known for making films that are often praised for their strong performances and characters. Actors like to work with these directors and some of them were actors before they became directors.'),
('Avant Garde', 'These directors are well-known for their experimental approach to filmmaking and their disregard for the conventional "3 act structure" way of storytelling. Their films are typically known to be very interpretive and they rely a lot on ambigiouity, when it comes to plot and themes.')
GO

INSERT INTO Rating (Rating, Descr)
VALUES (1, 'Poor'), (2, 'Fair'), (3, 'Good'), (4, 'Excellent'), (5, 'Amazing')
GO

--Get and Stored Procedures
CREATE OR ALTER PROCEDURE GetDirectorTypeID
@DirectorTypeName VARCHAR(50),
@DirectorTypeID INT OUTPUT
AS
SET @DirectorTypeID = (
    SELECT DirectorTypeID
    FROM DirectorType
    WHERE DirectorTypeName = @DirectorTypeName
)
GO

CREATE OR ALTER PROCEDURE GetGenreID
@Genre VARCHAR(50),
@GenreID INT OUTPUT
AS
SET @GenreID = (
    SELECT GenreID
    FROM Genre
    WHERE Genre = @Genre
)
GO

CREATE OR ALTER PROCEDURE GetRatingID
@Rating INT,
@RatingID INT OUTPUT
AS
SET @RatingID = (
    SELECT RatingID
    FROM Rating
    WHERE Rating = @Rating
)
GO

CREATE OR ALTER PROCEDURE GetActorID
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@PhoneNumber VARCHAR(50),
@ProductionCompany VARCHAR(50),
@Gender VARCHAR(50),
@DOB DATE,
@ActorID INT OUTPUT
AS
SET @ActorID = (
    SELECT ActorID
    FROM Actor
    WHERE FirstName = @FirstName
    AND LastName = @LastName
    AND PhoneNumber = @PhoneNumber
    AND ProductionCompany = @ProductionCompany
    AND Gender = @Gender
    AND DOB = @DOB
)
GO

CREATE OR ALTER PROCEDURE GetCustomerID
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@Email VARCHAR(256),
@PhoneNumber VARCHAR(50),
@Address VARCHAR(100),
@City VARCHAR(50),
@ZipCode VARCHAR(50),
@DOB DATE,
@CustomerID INT OUTPUT
AS
SET @CustomerID = (
    SELECT CustomerID
    FROM Customer
    WHERE FirstName = @FirstName
    AND LastName = @LastName
    AND Email = @Email
    AND PhoneNumber = @PhoneNumber
    AND [Address] = @Address
    AND City = @City
    AND ZipCode = @ZipCode
    AND DOB = @DOB
)
GO

CREATE OR ALTER PROCEDURE GetDirectorID
@DirectorTypeName VARCHAR(50),
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@PhoneNumber VARCHAR(50),
@ProductionCompany VARCHAR(50),
@Degree VARCHAR(50),
@DOB DATE,
@DirectorID INT OUTPUT 
AS

DECLARE @DirectorTypeID INT
EXEC GetDirectorTypeID
@DirectorTypeName = @DirectorTypeName,
@DirectorTypeID = @DirectorTypeID OUTPUT

SET @DirectorID = (
    SELECT DirectorID
    FROM Director
    WHERE DirectorTypeID = @DirectorTypeID
    AND FirstName = @FirstName
    AND LastName = @LastName
    AND PhoneNumber = @PhoneNumber
    AND ProductionCompany = @ProductionCompany
    AND Degree = @Degree
    AND DOB = @DOB
)
GO

CREATE OR ALTER PROCEDURE GetMovieID
@Genre VARCHAR(50),
@MovieName VARCHAR(50),
@Origin VARCHAR(50),
@ReleaseDate DATE,
@BoxOffice NUMERIC(12,2),
@Language VARCHAR(50),
@MovieID INT OUTPUT 
AS
DECLARE @GenreID INT
EXEC GetGenreID
@Genre = @Genre,
@GenreID = @GenreID OUTPUT

SET @MovieID = (
    SELECT MovieID
    FROM Movie
    WHERE GenreID = @GenreID
    AND MovieName = @MovieName
    AND Origin = @Origin
    AND ReleaseDate = @ReleaseDate
    AND BoxOffice = @BoxOffice
    AND [Language] = @Language
)
GO

CREATE OR ALTER PROCEDURE GetTheaterID
@TheaterName VARCHAR(100),
@Address VARCHAR(100),
@Country VARCHAR(50),
@City VARCHAR(50),
@ZipCode VARCHAR(50),
@PhoneNumber VARCHAR(50),
@TheaterID INT OUTPUT
AS
SET @TheaterID = (
    SELECT TheaterID 
    FROM Theater
    WHERE TheaterName = @TheaterName
    AND [Address] = @Address
    AND Country = @Country
    AND City = @City
    AND ZipCode = @ZipCode
    AND PhoneNumber = @PhoneNumber
)
GO

CREATE OR ALTER PROCEDURE InsertActor
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@PhoneNumber VARCHAR(50),
@ProductionCompany VARCHAR(50),
@Gender VARCHAR(50),
@DOB DATE
AS
BEGIN TRANSACTION N1
INSERT INTO Actor(FirstName, LastName, PhoneNumber, ProductionCompany, Gender, DOB)
VALUES (@FirstName, @LastName, @PhoneNumber, @ProductionCompany, @Gender, @DOB)
COMMIT TRANSACTION N1 
GO

CREATE OR ALTER PROCEDURE InsertCustomer
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@Email VARCHAR(256),
@PhoneNumber VARCHAR(50),
@Address VARCHAR(100),
@City VARCHAR(50),
@ZipCode VARCHAR(50),
@DOB DATE
AS
BEGIN TRANSACTION N1
INSERT INTO Customer(FirstName, LastName, Email, PhoneNumber, [Address], City, ZipCode, DOB)
VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @Address, @City, @ZipCode, @DOB)
COMMIT TRANSACTION N1
GO

CREATE OR ALTER PROCEDURE InsertDirector
@DirectorTypeName VARCHAR(50),
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@PhoneNumber VARCHAR(50),
@ProductionCompany VARCHAR(50),
@Degree VARCHAR(50),
@DOB DATE
AS
DECLARE @DirectorTypeID INT, @DegreeID INT
EXEC GetDirectorTypeID 
@DirectorTypeName = @DirectorTypeName,
@DirectorTypeID = @DirectorTypeID OUTPUT
BEGIN TRANSACTION N1
INSERT INTO Director(DirectorTypeID, FirstName, LastName, PhoneNumber, ProductionCompany, Degree, DOB)
VALUES (@DirectorTypeID, @FirstName, @LastName, @PhoneNumber, @ProductionCompany, @Degree, @DOB)
COMMIT TRANSACTION N1 
GO

CREATE OR ALTER PROCEDURE InsertMovie
@Genre VARCHAR(50),
@MovieName VARCHAR(50),
@Origin VARCHAR(50),
@ReleaseDate DATE,
@BoxOffice NUMERIC(12,2),
@Language VARCHAR(50)
AS
DECLARE @GenreID INT
EXEC GetGenreID
@Genre = @Genre,
@GenreID = @GenreID OUTPUT
BEGIN TRANSACTION N1
INSERT INTO Movie(GenreID, MovieName, Origin, ReleaseDate, BoxOffice, [Language])
VALUES (@GenreID, @MovieName, @Origin, @ReleaseDate, @BoxOffice, @Language)
COMMIT TRANSACTION N1 
GO

CREATE OR ALTER PROCEDURE InsertTheater
@TheaterName VARCHAR(100),
@Address VARCHAR(100),
@Country VARCHAR(50),
@City VARCHAR(50),
@ZipCode VARCHAR(50),
@PhoneNumber VARCHAR(50)
AS 
BEGIN TRANSACTION N1
INSERT INTO Theater(TheaterName, [Address], Country, City, ZipCode, PhoneNumber)
VALUES (@TheaterName, @Address, @Country, @City, @ZipCode, @PhoneNumber)
COMMIT TRANSACTION N1 
GO

CREATE OR ALTER PROCEDURE InsertActor_Movie
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@PhoneNumber VARCHAR(50),
@ProductionCompany VARCHAR(50),
@Gender VARCHAR(50),
@DOB DATE,
@Genre VARCHAR(50),
@MovieName VARCHAR(50),
@Origin VARCHAR(50),
@ReleaseDate DATE,
@BoxOffice NUMERIC(12,2),
@Language VARCHAR(50),
@CharacterPlayed VARCHAR(50),
@AwardsWon INT
AS
DECLARE @MovieID INT, @ActorID INT

EXEC GetMovieID
@Genre = @Genre,
@MovieName = @MovieName,
@Origin = @Origin,
@ReleaseDate = @ReleaseDate,
@BoxOffice = @BoxOffice,
@Language = @Language,
@MovieID = @MovieID OUTPUT 

EXEC GetActorID
@FirstName = @FirstName,
@LastName = @LastName,
@PhoneNumber = @PhoneNumber,
@ProductionCompany = @ProductionCompany,
@Gender = @Gender,
@DOB = @DOB,
@ActorID = @ActorID OUTPUT

BEGIN TRANSACTION N1
INSERT INTO Actor_Movie(ActorID, MovieID, CharacterPlayed, AwardsWon)
VALUES (@ActorID, @MovieID, @CharacterPlayed, @AwardsWon )
COMMIT TRANSACTION N1 
GO

CREATE OR ALTER PROCEDURE InsertCust_Movie
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@Email VARCHAR(256),
@PhoneNumber VARCHAR(50),
@Address VARCHAR(100),
@City VARCHAR(50),
@ZipCode VARCHAR(50),
@DOB DATE,
@Genre VARCHAR(50),
@MovieName VARCHAR(50),
@Origin VARCHAR(50),
@ReleaseDate DATE,
@BoxOffice NUMERIC(12,2),
@Language VARCHAR(50),
@DateSeen DATE

AS
DECLARE @MovieID INT, @CustomerID INT
EXEC GetMovieID
@Genre = @Genre,
@MovieName = @MovieName,
@Origin = @Origin,
@ReleaseDate = @ReleaseDate,
@BoxOffice = @BoxOffice,
@Language = @Language,
@MovieID = @MovieID OUTPUT 

EXEC GetCustomerID
@FirstName = @FirstName,
@LastName = @LastName,
@Email = @Email,
@PhoneNumber = @PhoneNumber,
@Address = @Address,
@City = @City,
@ZipCode = @ZipCode,
@DOB = @DOB,
@CustomerID = @CustomerID OUTPUT

BEGIN TRANSACTION N1
INSERT INTO Cust_Movie(CustomerID, MovieID, DateSeen)
VALUES (@CustomerID, @MovieID, @DateSeen)
COMMIT TRANSACTION N1 
GO

CREATE OR ALTER PROCEDURE InsertDirect_Movie
@DirectorTypeName VARCHAR(50),
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@PhoneNumber VARCHAR(50),
@ProductionCompany VARCHAR(50),
@Degree VARCHAR(50),
@DOB DATE,
@Genre VARCHAR(50),
@MovieName VARCHAR(50),
@Origin VARCHAR(50),
@ReleaseDate DATE,
@BoxOffice NUMERIC(12,2),
@Language VARCHAR(50),
@AwardsWon INT
AS
DECLARE @DirectorID INT, @MovieID INT
EXEC GetMovieID
@Genre = @Genre,
@MovieName = @MovieName,
@Origin = @Origin,
@ReleaseDate = @ReleaseDate,
@BoxOffice = @BoxOffice,
@Language = @Language,
@MovieID = @MovieID OUTPUT 

EXEC GetDirectorID
@DirectorTypeName = @DirectorTypeName,
@FirstName = @FirstName,
@LastName = @LastName,
@PhoneNumber = @PhoneNumber,
@ProductionCompany = @ProductionCompany,
@Degree = @Degree,
@DOB = @DOB,
@DirectorID = @DirectorID OUTPUT 

BEGIN TRANSACTION N1
INSERT INTO Direct_Movie(DirectorID, MovieID, AwardsWon)
VALUES (@DirectorID, @MovieID, @AwardsWon)
COMMIT TRANSACTION N1 
GO

CREATE OR ALTER PROCEDURE InsertTheater_Movie
@TheaterName VARCHAR(100),
@Address VARCHAR(100),
@Country VARCHAR(50),
@City VARCHAR(50),
@ZipCode VARCHAR(50),
@PhoneNumber VARCHAR(50),
@Genre VARCHAR(50),
@MovieName VARCHAR(50),
@Origin VARCHAR(50),
@ReleaseDate DATE,
@BoxOffice NUMERIC(12,2),
@Language VARCHAR(50),
@StartDateShown DATE,
@EndDateShown DATE,
@TheaterBoxOffice NUMERIC(12,2)
AS
DECLARE @TheaterID INT, @MovieID INT
EXEC GetMovieID
@Genre = @Genre,
@MovieName = @MovieName,
@Origin = @Origin,
@ReleaseDate = @ReleaseDate,
@BoxOffice = @BoxOffice,
@Language = @Language,
@MovieID = @MovieID OUTPUT

EXEC GetTheaterID
@TheaterName = @TheaterName,
@Address = @Address,
@Country = @Country,
@City = @City,
@ZipCode = @ZipCode,
@PhoneNumber = @PhoneNumber,
@TheaterID = @TheaterID OUTPUT

BEGIN TRANSACTION N1
INSERT INTO Theater_Movie(TheaterID, MovieID, StartDateShown, EndDateShown, TheaterBoxOffice)
VALUES (@TheaterID, @MovieID, @StartDateShown, @EndDateShown, @TheaterBoxOffice)
COMMIT TRANSACTION N1 
GO

CREATE OR ALTER PROCEDURE GetCust_MovieID
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@Email VARCHAR(256),
@PhoneNumber VARCHAR(50),
@Address VARCHAR(100),
@City VARCHAR(50),
@ZipCode VARCHAR(50),
@DOB DATE,
@Genre VARCHAR(50),
@MovieName VARCHAR(50),
@Origin VARCHAR(50),
@ReleaseDate DATE,
@BoxOffice NUMERIC(12,2),
@Language VARCHAR(50),
@DateSeen DATE,
@CustMovieID INT OUTPUT
AS
DECLARE @CustomerID INT, @MovieID INT 
EXEC GetCustomerID
@FirstName = @FirstName,
@LastName = @LastName,
@Email = @Email,
@PhoneNumber = @PhoneNumber,
@Address = @Address,
@City = @City,
@ZipCode = @ZipCode,
@DOB = @DOB,
@CustomerID = @CustomerID OUTPUT
EXEC GetMovieID
@Genre = @Genre,
@MovieName = @MovieName,
@Origin = @Origin,
@ReleaseDate = @ReleaseDate,
@BoxOffice = @BoxOffice,
@Language = @Language,
@MovieID = @MovieID OUTPUT

SET @CustMovieID = (
    SELECT CustMovieID
    FROM Cust_Movie
    WHERE CustomerID = @CustomerID
    AND MovieID = @MovieID
    AND DateSeen = @DateSeen
)
GO


CREATE OR ALTER PROCEDURE InsertReview
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@Email VARCHAR(256),
@PhoneNumber VARCHAR(50),
@Address VARCHAR(100),
@City VARCHAR(50),
@ZipCode VARCHAR(50),
@DOB DATE,
@Genre VARCHAR(50),
@MovieName VARCHAR(50),
@Origin VARCHAR(50),
@ReleaseDate DATE,
@BoxOffice NUMERIC(12,2),
@Language VARCHAR(50),
@DateSeen DATE,
@Rating INT, 
@Descr TEXT
AS
DECLARE @CustMovieID INT, @RatingID INT
EXEC GetCust_MovieID
@Genre = @Genre,
@MovieName = @MovieName,
@Origin = @Origin,
@ReleaseDate = @ReleaseDate,
@BoxOffice = @BoxOffice,
@DateSeen = @DateSeen,
@Language = @Language,
@FirstName = @FirstName,
@LastName = @LastName,
@Email = @Email,
@PhoneNumber = @PhoneNumber,
@Address = @Address,
@City = @City,
@ZipCode = @ZipCode,
@DOB = @DOB,
@CustMovieID = @CustMovieID OUTPUT

EXEC GetRatingID
@Rating = @Rating,
@RatingID = @RatingID OUTPUT

BEGIN TRANSACTION N1
INSERT INTO Review(RatingID, CustMovieID, Descr)
VALUES (@RatingID, @CustMovieID, @Descr)
COMMIT TRANSACTION N1 
GO

--Creating Queries/Views for Database

--Which genre has the most amount of movies?
CREATE OR ALTER VIEW MostPopularGenre AS
SELECT TOP 1 G.Genre, COUNT(*) AS MovieCount
FROM Movie M 
    JOIN Genre G ON G.GenreID = M.GenreID
GROUP BY Genre
ORDER BY MovieCount DESC;
GO

-- Which movies have more than 1 director?
CREATE OR ALTER VIEW MoviesWithMoreThanOneDirector AS
SELECT M.MovieID, M.MovieName
FROM Movie M
    JOIN Direct_Movie DM ON DM.MovieID = M.MovieID
GROUP BY M.MovieID, M.MovieName
HAVING COUNT(DM.MovieID) > 1;
GO

--What was the box office amount for all Visionary directors?
CREATE OR ALTER VIEW BoxOfficeAmtVisionaryDirectors AS
SELECT DirectorTypeName, SUM(BoxOffice) AS BoxOfficeAmt
FROM Director D
    JOIN DirectorType DT ON D.DirectorTypeID = DT.DirectorTypeID
    JOIN Direct_Movie DM ON DM.DirectorID = D.DirectorID
    JOIN Movie M ON M.MovieID = DM.MovieID
GROUP BY DirectorTypeName
HAVING DirectorTypeName = 'Visionary';
GO

--What was the highest rated movie reviewed by customers from Miami?
CREATE OR ALTER VIEW HighestRatedMovieMiami AS 
WITH CustomersFromMiami AS (
    SELECT CustomerID
    FROM Customer
    WHERE City = 'Miami'
) 
SELECT TOP 1 MovieName, AVG(Rt.Rating) AS Rating
FROM Review R
    JOIN Cust_Movie CM on R.CustMovieID = CM.CustMovieID
    JOIN Movie M ON M.MovieID = CM.MovieID
    JOIN Customer C ON C.CustomerID = CM.CustomerID
    JOIN CustomersFromMiami CFM ON CFM.CustomerID = C.CustomerID
    JOIN Rating Rt ON RT.RatingID = R.RatingID
GROUP BY MovieName
ORDER BY Rating DESC;
GO

--Which movie was the most popular among all theaters?
CREATE OR ALTER VIEW MostPopularMovieAmongTheaters AS
SELECT TOP 1 M.MovieID, MovieName, COUNT(*) AS NumOfTheaters
FROM Theater T
    JOIN Theater_Movie TM ON TM.TheaterID = T.TheaterID
    JOIN Movie M ON M.MovieID = TM.MovieID
GROUP BY M.MovieID, MovieName
ORDER BY NumOfTheaters DESC;
GO

--What was the box office amount for every city?
CREATE OR ALTER VIEW CityBoxOffice AS
SELECT t.City, SUM(tm.TheaterBoxOffice) AS TotalBoxOffice
FROM Theater t
    JOIN Theater_Movie tm ON t.TheaterID = tm.TheaterID
GROUP BY t.City;
GO

--Which customers have seen all the movies from the romance genre?
CREATE OR ALTER VIEW CustomersRomanceMovies AS
SELECT c.customerid, c.Firstname, c.LastName
FROM cust_movie cm
    JOIN Movie m ON cm.Movieid = m.MovieID
    JOIN Customer C ON C.CustomerID = CM.CustomerID
WHERE m.genreID = '4' -- ID for Romance
GROUP BY c.customerid, c.FirstName, c.LastName
HAVING COUNT(m.MovieID) = (
    SELECT COUNT(*)
    FROM Movie
    WHERE GenreID = '4'
  );
GO

--Which actors are associated with the movie with the highest box office?
CREATE OR ALTER VIEW ActorsInHighestBoxOfficeMovie AS
WITH MostPopularMovie AS (
    SELECT TOP 1 MovieID
    FROM Movie
    ORDER BY BoxOffice DESC
) 
SELECT A.ActorID, FirstName, LastName, PhoneNumber, ProductionCompany, Gender, DOB, CharacterPlayed
FROM Actor A 
    JOIN Actor_Movie AM ON AM.ActorID = A.ActorID
    JOIN Movie M ON M.MovieID = AM.MovieID
    JOIN MostPopularMovie MPM ON MPM.MovieID = AM.MovieID; 
GO

--Which actors acted in the most movies?
CREATE OR ALTER VIEW MostActorRoles AS
SELECT TOP 3 A.ActorID, FirstName, LastName, PhoneNumber, COUNT(*) AS NumberOfMovies
FROM Actor A
    JOIN Actor_Movie AM ON A.ActorID = AM.ActorID
    JOIN Movie M ON M.MovieID = AM.MovieID
GROUP BY A.ActorID, FirstName, LastName, PhoneNumber, ProductionCompany, Gender, DOB 
ORDER BY NumberOfMovies DESC;
GO