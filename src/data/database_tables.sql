DROP TABLE if EXISTS historical_data;
DROP TABLE if EXISTS microsoft;
DROP TABLE if EXISTS balance_sheet_data;
DROP TABLE if EXISTS income_statement_data;
DROP TABLE if EXISTS cash_flow_data;

CREATE TABLE historical_data (
    date DATE PRIMARY KEY,
    "open" FLOAT NOT NULL,
    high FLOAT NOT NULL,
    low FLOAT NOT NULL,
    "close" FLOAT NOT NULL,
    adjusted_close FLOAT NOT NULL,
    volume BIGINT NOT NULL,
    dividend_amount FLOAT NOT NULL,
    split_coefficient FLOAT NOT NULL
);

-- ALTER TABLE historical_data
-- ALTER COLUMN "open" TYPE FLOAT USING "open"::float,
-- ALTER COLUMN high TYPE FLOAT USING high::float,
-- ALTER COLUMN "low" TYPE FLOAT USING low::float,
-- ALTER COLUMN "close" TYPE FLOAT USING "close"::float,
-- ALTER COLUMN adjusted_close TYPE FLOAT USING adjusted_close::float,
-- ALTER COLUMN volume TYPE FLOAT USING volume::float,
-- ALTER COLUMN dividend_amount TYPE FLOAT USING dividend_amount::float,
-- ALTER COLUMN split_coefficient TYPE FLOAT USING split_coefficient::float;

CREATE TABLE microsoft (
    Symbol VARCHAR(255),
    AssetType VARCHAR(255),
    Name VARCHAR(255),
    Description TEXT,
    Exchange VARCHAR(255),
    Currency VARCHAR(255),
    Country VARCHAR(255),
    Sector VARCHAR(255),
    Industry VARCHAR(255),
    Address VARCHAR(255),
    FiscalYearEnd VARCHAR(255),
    LatestQuarter VARCHAR(255),
    MarketCapitalization NUMERIC(20,4),
    EPS NUMERIC(20,4),
    ProfitMargin NUMERIC(20,4),
    QuarterlyEarningsGrowthYOY NUMERIC(20,4),
    QuarterlyRevenueGrowthYOY NUMERIC(20,4),
    AnalystTargetPrice NUMERIC(20,4),
    Beta NUMERIC(20,4),
    SharesOutstanding BIGINT,
    DividendDate DATE,
    ExDividendDate DATE
);

-- ALTER TABLE microsoft
--     ALTER COLUMN MarketCapitalization TYPE NUMERIC(20,4) USING MarketCapitalization::NUMERIC,
--     ALTER COLUMN EPS TYPE NUMERIC(20,4) USING EPS::NUMERIC,
--     ALTER COLUMN ProfitMargin TYPE NUMERIC(20,4) USING ProfitMargin::NUMERIC,
--     ALTER COLUMN QuarterlyEarningsGrowthYOY TYPE NUMERIC(20,4) USING QuarterlyEarningsGrowthYOY::NUMERIC,
--     ALTER COLUMN QuarterlyRevenueGrowthYOY TYPE NUMERIC(20,4) USING QuarterlyRevenueGrowthYOY::NUMERIC,
--     ALTER COLUMN AnalystTargetPrice TYPE NUMERIC(20,4) USING AnalystTargetPrice::NUMERIC,
--     ALTER COLUMN Beta TYPE NUMERIC(20,4) USING Beta::NUMERIC,
--     ALTER COLUMN SharesOutstanding TYPE BIGINT USING sharesoutstanding::bigint,
--     ALTER COLUMN DividendDate TYPE DATE USING to_date(DividendDate, 'YYYY-MM-DD'),
--     ALTER COLUMN ExDividendDate TYPE DATE USING to_date(ExDividendDate, 'YYYY-MM-DD');

CREATE TABLE balance_sheet_data (
    fiscalDateEnding TEXT, 
    reportedCurrency TEXT,
    totalAssets TEXT,
    totalCurrentAssets TEXT,
    cashAndCashEquivalentsAtCarryingValue TEXT,
    cashAndShortTermInvestments TEXT,
    inventory TEXT,
    currentNetReceivables TEXT,
    totalNonCurrentAssets TEXT,
    propertyPlantEquipment TEXT,
    accumulatedDepreciationAmortizationPPE TEXT,
    intangibleAssets TEXT,
    intangibleAssetsExcludingGoodwill TEXT,
    goodwill TEXT,
    investments TEXT,
    longTermInvestments TEXT,
    shortTermInvestments TEXT,
    otherCurrentAssets TEXT,
    otherNonCurrentAssets TEXT,
    totalLiabilities TEXT,
    totalCurrentLiabilities TEXT,
    currentAccountsPayable TEXT,
    deferredRevenue TEXT,
    currentDebt TEXT,
    shortTermDebt TEXT,
    totalNonCurrentLiabilities TEXT,
    capitalLeaseObligations TEXT,
    longTermDebt TEXT,
    currentLongTermDebt TEXT,
    longTermDebtNoncurrent TEXT,
    shortLongTermDebtTotal TEXT,
    otherCurrentLiabilities TEXT,
    otherNonCurrentLiabilities TEXT,
    totalShareholderEquity TEXT,
    treasuryStock TEXT,
    retainedEarnings TEXT,
    commonStock TEXT,
    commonStockSharesOutstanding TEXT
);

-- Altered Table (maybe)

CREATE TABLE balance_sheet_data (
    fiscalDateEnding DATE, 
    reportedCurrency VARCHAR(250),
    totalAssets FLOAT,
    totalCurrentAssets FLOAT,
    cashAndCashEquivalentsAtCarryingValue FLOAT,
    cashAndShortTermInvestments FLOAT,
    inventory FLOAT,
    currentNetReceivables FLOAT,
    totalNonCurrentAssets FLOAT,
    propertyPlantEquipment FLOAT,
    accumulatedDepreciationAmortizationPPE FLOAT,
    intangibleAssets FLOAT,
    intangibleAssetsExcludingGoodwill FLOAT,
    goodwill FLOAT,
    investments FLOAT,
    longTermInvestments FLOAT,
    shortTermInvestments FLOAT,
    otherCurrentAssets FLOAT,
    otherNonCurrentAssets FLOAT,
    totalLiabilities FLOAT,
    totalCurrentLiabilities FLOAT,
    currentAccountsPayable FLOAT,
    deferredRevenue VARCHAR(255),
    currentDebt FLOAT,
    shortTermDebt FLOAT,
    totalNonCurrentLiabilities FLOAT,
    capitalLeaseObligations VARCHAR(255),
    longTermDebt FLOAT,
    currentLongTermDebt FLOAT,
    longTermDebtNoncurrent FLOAT,
    shortLongTermDebtTotal FLOAT,
    otherCurrentLiabilities FLOAT,
    otherNonCurrentLiabilities FLOAT,
    totalShareholderEquity FLOAT,
    treasuryStock VARCHAR(255),
    retainedEarnings FLOAT,
    commonStock FLOAT,
    commonStockSharesOutstanding BIGINT
);



CREATE TABLE income_statement_data (
    fiscalDateEnding DATE,
    reportedCurrency VARCHAR(50),
    grossProfit FLOAT,
    totalRevenue FLOAT,
    costOfRevenue FLOAT,
    costofGoodsAndServicesSold FLOAT,
    operatingIncome FLOAT,
    sellingGeneralAndAdministrative FLOAT,
    researchAndDevelopment FLOAT,
    operatingExpenses FLOAT,
    investmentIncomeNet FLOAT,
    netInterestIncome FLOAT,
    interestIncome VARCHAR(255),
    interestExpense FLOAT,
    nonInterestIncome FLOAT,
    otherNonOperatingIncome FLOAT,
    depreciation TEXT,
    depreciationAndAmortization FLOAT,
    incomeBeforeTax FLOAT,
    incomeTaxExpense FLOAT,
    interestAndDebtExpense FLOAT,
    netIncomeFromContinuingOperations FLOAT,
    comprehensiveIncomeNetOfTax FLOAT,
    ebit FLOAT,
    ebitda FLOAT,
    netIncome FLOAT
);

-- ALTER TABLE income_statement_data
--     ALTER COLUMN interestincome TYPE VARCHAR(255) USING interestincome::VARCHAR(255);

CREATE TABLE cash_flow_data (
    fiscalDateEnding DATE,
    reportedCurrency VARCHAR(50),
    operatingCashflow FLOAT,
    paymentsForOperatingActivities FLOAT,
    proceedsFromOperatingActivities VARCHAR(50),
    changeInOperatingLiabilities FLOAT,
    changeInOperatingAssets FLOAT,
    depreciationDepletionAndAmortization FLOAT,
    capitalExpenditures FLOAT,
    changeInReceivables FLOAT,
    changeInInventory FLOAT,
    profitLoss FLOAT,
    cashflowFromInvestment FLOAT,
    cashflowFromFinancing FLOAT,
    proceedsFromRepaymentsOfShortTermDebt FLOAT,
    paymentsForRepurchaseOfCommonStock FLOAT,
    paymentsForRepurchaseOfEquity FLOAT,
    paymentsForRepurchaseOfPreferredStock VARCHAR(50),
    dividendPayout FLOAT,
    dividendPayoutCommonStock FLOAT,
    dividendPayoutPreferredStock VARCHAR(50),
    proceedsFromIssuanceOfCommonStock FLOAT,
    proceedsFromIssuanceOfLongTermDebtAndCapitalSecuritiesNet VARCHAR(50),
    proceedsFromIssuanceOfPreferredStock VARCHAR(50),
    proceedsFromRepurchaseOfEquity FLOAT,
    proceedsFromSaleOfTreasuryStock VARCHAR(50),
    changeInCashAndCashEquivalents FLOAT,
    changeInExchangeRate VARCHAR(255),
    netIncome FLOAT
);

