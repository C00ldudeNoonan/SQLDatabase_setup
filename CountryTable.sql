-- creating country table and populating it. 

IF OBJECT_ID('dbo.Countries') is not null
DROP Table dbo.Countries

CREATE TABLE dbo.Countries
	(
	CountryId int identity PRIMARY KEY,
	CountryName varchar(50) NOT NULL,
	CountryCode varchar(50) NULL
	) 
GO

INSERT INTO dbo.Countries

SELECT Distinct
	CountryName,
	CountryCode
FROM dbo.worldcities;
GO

-- adding country id and updating the column
SELECT * FROM dbo.Countries

ALTER TABLE dbo.worldcities
ADD CountryId int;
Go


UPDATE dbo.worldcities
SET CountryID = Countries.CountryId
FROM Countries
WHERE Countries.CountryName = worldcities.CountryName



-- removing not null contraint and dropping column
ALTER TABLE dbo.worldcities ALTER COlUMN CountryName Varchar(50) NULL
ALTER TABLE dbo.worldcities ALTER COlUMN CountryCode Varchar(50) NULL

ALTER TABLE dbo.worldcities DROP COLUMN CountryName
ALTER TABLE dbo.worldcities DROP COLUMN CountryCode

-- Making countryid a foreign key on both tables
ALTER TABLE dbo.worldcities ADD FOREIGN KEY (CountryId) REFERENCES Countries(CountryId)
ALTER TABLE dbo.worldcities ALTER COLUMN CountryID int NOT NULL


SELECT TOP 10 * FROM dbo.worldcities
JOIN Countries on worldcities.CountryId = Countries.CountryId