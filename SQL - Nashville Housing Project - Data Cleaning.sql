/*

Cleaning Data in SQL Queries

*/

SELECT * FROM Nashville_Housing_Data
ORDER BY UniqueID;


/* Checking DATA TYPE OF COLUMNS IN the TABLE */

SELECT * FROM INFORMATION_SCHEMA.COLUMNS

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format: from DATETIME to DATE
-- ColumnName: SaleDate to SaleDateConverted 
ALTER TABLE Nashville_Housing_Data
ADD SaleDateConverted  Date;			-- create column SaleDateConverted

UPDATE Nashville_Housing_Data 
SET SaleDateConverted = CONVERT(date, SaleDate) -- convert the data type and transfer result to new column

SELECT 
	SaleDate
	, SaleDateConverted
From 
	Nashville_Housing_Data -- compare old vs new columns







 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

SELECT 
	PropertyAddress 
FROM 
	Nashville_Housing_Data
WHERE PropertyAddress IS NULL           --- -- many null values in this column



SELECT *
FROM 
	Nashville_Housing_Data
ORDER BY ParcelID						-- there are many duplicated values in columns 'ParcelID' and 'PropertyAddress'


--  Column 'PropertyAddress' with all NULL vales and one with values

SELECT	
	a.ParcelID
	, b.ParcelId
	, a.PropertyAddress
	, b.PropertyAddress
	, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Nashville_Housing_Data a
JOIN  Nashville_Housing_Data b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL


-- Copy data from second PropertyAddress column to the first one

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Nashville_Housing_Data a
JOIN  Nashville_Housing_Data b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL






--------------------------------------------------------------------------------------------------------------------------

-- Breaking out PropertyAddress  into Individual Columns (Address, City)

SELECT PropertyAddress FROM Nashville_Housing_Data


SELECT
	-- The value for 'Address' column will be taken before the comma
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS PropertySplitAddress
	-- The value for 'City' column will be taken after the comma
	, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS PropertySplitCity
FROM 
	Nashville_Housing_Data

-- Create columns 'PropertySplitAddress' and 'PropertySplitCity'

ALTER TABLE Nashville_Housing_Data
ADD PropertySplitAddress NVARCHAR(100), PropertySplitCity  NVARCHAR(100)


-- Update value for columns 'PropertySplitAddress' and 'PropertySplitCity'

UPDATE Nashville_Housing_Data
SET 
	PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)
	, PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))


SELECT *
FROM Nashville_Housing_Data

--------------------------------------------------------------------------------------------------------------------------
-- Breaking out OwnerAddress  into Individual Columns (Address, City, State)

SELECT OwnerAddress
FROM Nashville_Housing_Data


SELECT 
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS OwnerSplitAddress
	, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS OwnerSplitCity
	, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS OwnerSplitState
FROM Nashville_Housing_Data


-- Create columns 'OwnerSplitAddress', 'OwnerSplitCity', 'OwnerSplitState'

ALTER TABLE Nashville_Housing_Data
ADD	OwnerSplitAddress NVARCHAR(100)
	, OwnerSplitCity NVARCHAR(100)
	, OwnerSplitState NVARCHAR(100)


-- Update value for 3 columns

UPDATE Nashville_Housing_Data
SET	OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
	, OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
	, OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


SELECT *
FROM Nashville_Housing_Data


--------------------------------------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field


-- Count the distinct value of column SoldAsVacant
SELECT 
	DISTINCT(SoldAsVacant)
	, COUNT(SoldAsVacant)
FROM Nashville_Housing_Data
GROUP BY SoldAsVacant
ORDER BY 2;


-- Use CASE Expression
SELECT
	SoldAsVacant,
	CASE
		WHEN SoldAsVacant = 'Yes' THEN 'Y'
		WHEN SoldAsVacant = 'No' THEN 'N'
		ELSE SoldAsVacant
	END
FROM dbo.Nashville_Housing_Data

-- Update result for the column SoldAsVacant
UPDATE Nashville_Housing_Data
SET	SoldAsVacant = 
	CASE
		WHEN SoldAsVacant = 'Yes' THEN 'Y'
		WHEN SoldAsVacant = 'No' THEN 'N'
		ELSE SoldAsVacant
	END

SELECT SoldAsVacant FROM Nashville_Housing_Data









-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS (
SELECT
	*,
	ROW_NUMBER() OVER (
	PARTITION BY
				ParcelID
				, PropertyAddress
				, SaleDate
				, SalePrice
				, LegalReference
	ORDER BY UniqueID ) AS row_num
FROM Nashville_Housing_Data )


DELETE  
FROM RowNumCTE
WHERE RowNumCTE.row_num > 1 -- Then double checking for duplicated values

-- ORDER BY RowNumCTE.PropertyAddress





---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

ALTER TABLE Nashville_Housing_Data
DROP COLUMN
	PropertyAddress
	, SaleDate
	, OwnerAddress;


















-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--- Importing Data using OPENROWSET and BULK INSERT	

--  More advanced and looks cooler, but have to configure server appropriately to do correctly
--  Wanted to provide this in case you wanted to try it


--sp_configure 'show advanced options', 1;
--RECONFIGURE;
--GO
--sp_configure 'Ad Hoc Distributed Queries', 1;
--RECONFIGURE;
--GO


--USE PortfolioProject 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1 

--GO 


---- Using BULK INSERT

--USE PortfolioProject;
--GO
--BULK INSERT nashvilleHousing FROM 'C:\Temp\SQL Server Management Studio\Nashville Housing Data for Data Cleaning Project.csv'
--   WITH (
--      FIELDTERMINATOR = ',',
--      ROWTERMINATOR = '\n'
--);
--GO


---- Using OPENROWSET
--USE PortfolioProject;
--GO
--SELECT * INTO nashvilleHousing
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
--    'Excel 12.0; Database=C:\Users\alexf\OneDrive\Documents\SQL Server Management Studio\Nashville Housing Data for Data Cleaning Project.csv', [Sheet1$]);
--GO

















