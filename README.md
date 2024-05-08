# SQL-Nashville-Housing-Data-Quality-Assessment
The Nashville Housing project is about cleaning a real estate dataset for Nashville market by standardizing data formats, removing duplicates, and improving data completeness.
1. About Project
- The dataset contained information about property sales, rentals, and other real estate transactions in Nashville Housing market.
- Data source: https://www.kaggle.com/datasets/tmthyjames/nashville-housing-data
- Technologies used: MS SQL Server Management

2. Project Planning & Aim Grid:
- Main purpose:
  - Applying data cleaning and normalizing techniques, make the dataset became more consistent, complete, and usable for further analysis.
- Stakeholders:
  - Real estate professionals
  - Investors
  - Anyyone interested
- Success Criteria:
  - The dataset will be more standardized, consistent and usable for further analysis.
  - Users, managers, investors can analyze quality and reliability dataset to identify trends, patterns, and insights about the Nashville Housing real estate market.
- Setup process:
  - Step 1: Collect data from above source
  - Step 2: Import data to SSMS to perform cleaning techniques
  - Step 3: Export cleaned data to .xlsx file
  
3. Problem statement:
- Standardize Date format
- Populate Property Address data
- Breaking out PropertyAddress, OwnerAddress into individual columns (Address, City)
- Add Individual columns (Address, City), (Address, City, State) to the table
- Change values 'Y' and 'N' to 'Yes' and 'No' in SoldAsVacant column
- Checking for duplicated rows
- Remove Duplicates
- Remove Unused columns (if required)

4. Project Recap and Recommended Options

- Recap
    - In this project, we tackled the crucial task of cleaning the 'Nashville Housing' dataset to ensure
it's ready for detailed analysis. After understanding the problem and objectives for subsequent analyses,
we collected the dataset and proceeded with the cleaning process.
   - We began by identifying issues through a data quality check, addressing concerns such as null
values and unwanted spaces using the TRIM function. We conducted thorough cleaning of 
the 'PropertyAddress' column, populating and splitting the information into 'address' and 'city'. 
We adjusted the format of the 'SaleDate' column and corrected inconsistencies in entries. We also 
identified and removed duplicates to ensure data integrity.

- Conclusions
    - As a result of these efforts, we obtained complete and accurate data in key columns 
like 'SaleDate','SalePrice','PropertyAddress', 'LegalReference', and 'SoldAsVacant'.
    - However, it's important to note that around 60% of records, approximately 30,000 entries, lack information 
in critical columns like 'Acreage', 'LandValue', 'BuildingValue', 'TotalValue', 'YearBuilt', 'Bedrooms', 
'FullBath', and 'HalfBath'. Next, with that said, several options are presented for moving forward.

- Recommended Options

    - Analysis with Available Information: Consider the possibility to analyze with the available information. 
Although a lot of data will be missing, valuable insights can still be gained from the existing data.
Consider conducting two separate analyses for a comprehensive understanding of the dataset. 
    - The first focuses on sales, dates, prices, and geographic locations, utilizing the complete dataset
for a thorough examination. The second delves into property values and details, using a reduced dataset but 
potentially providing valuable insights as well.
    - Seek Additional Information: Explore the ways to obtain the missing information, whether through 
additional sources, collaborations, or the possibility of completing the data through new acquisitions.

5. Finished products
- SQL (MS SSMS) queries (uploaded file)
- Cleaned dataset in .xlsx file (uploaded file)


