#Cleaning Data in SQL Queries

select * from nashvillehousing

---standardisation date format

select SaleDate, str_to_date(SaleDate,'%M %d, %Y') as Saledate
from nashvillehousing

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

update NashvilleHousing
set SaleDateConverted = str_to_date(SaleDate,'%M %d, %Y')

alter table NashvilleHousing
drop column SaleDate;
------------------------------------------------------------------------------------------------------------------------------------------
---populate property adress data

select * from nashvillehousing where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing a
JOIN NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing a
JOIN NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null
-----------------------------------------------------------------------------------------------------------------------------------------
---Breaking out Address into Individual Columns (Address, City, State)
select PropertyAddress from nashvillehousing

SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) AS ADRESS,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) AS CITY

ALTER TABLE nashvillehousing
ADD ADRESS NVARCHAR(255)

UPDATE nashvillehousing
SET ADRESS = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE nashvillehousing
ADD CITY NVARCHAR(255)

UPDATE nashvillehousing
SET ADRESS = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) AS CITY

-------------------------------------------------------------------------------------------------------------------------------------------
#SPLITING OWNER ADRESS

SELECT * FROM nashvillehousing

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From NashvilleHousing

ALTER TABLE nashvillehousing
Add OwnerSplitAddress Nvarchar(255);

Update nashvillehousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE nashvillehousing
Add OwnerSplitCity Nvarchar(255);

Update nashvillehousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE nashvillehousing
Add OwnerSplitState Nvarchar(255);

Update nashvillehousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

===========================================================================================================================================
-- Change Y and N to Yes and No in "Sold as Vacant" field
select * from nashvillehousing
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM nashvillehousing
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	   when SoldAsVacant = 'N' THEN 'No'
	   else SoldAsVacant 
	   end
from nashvillehousing

update nashvillehousing
set SoldAsVacant= CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	   when SoldAsVacant = 'N' THEN 'No'
	   else SoldAsVacant 
	   end
=========================================================================================================================================
---remove duplicate

     WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From nashvilleHousing)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress  

Select *
From nashvilleHousing


===========================================================================================================================================
-- Delete Unused Columns


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate