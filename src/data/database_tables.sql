DROP TABLE if EXISTS historical_data;
DROP TABLE if EXISTS microsoft;
DROP TABLE if EXISTS balance_sheet_data;
DROP TABLE if EXISTS income_statement_data;
DROP TABLE if EXISTS cash_flow_data;

CREATE TABLE historical_data (
    date DATE PRIMARY KEY,
    "open" NUMERIC(12, 4) NOT NULL,
    high NUMERIC(12, 4) NOT NULL,
    low NUMERIC(12, 4) NOT NULL,
    "close" NUMERIC(12, 4) NOT NULL,
    adjusted_close NUMERIC(12, 4) NOT NULL,
    volume BIGINT NOT NULL,
    dividend_amount NUMERIC(12, 4) NOT NULL,
    split_coefficient NUMERIC(12, 4) NOT NULL
);

-- ALTER TABLE historical_data
-- ALTER COLUMN "open" TYPE FLOAT USING "open"::float,
-- ALTER COLUMN high TYPE float USING high::float,
-- ALTER COLUMN "low" TYPE float USING low::float,
-- ALTER COLUMN "close" TYPE float USING "close"::float,
-- ALTER COLUMN adjusted_close TYPE float USING adjusted_close::float,
-- ALTER COLUMN volume TYPE float USING volume::float,
-- ALTER COLUMN dividend_amount TYPE float USING dividend_amount::float,
-- ALTER COLUMN split_coefficient TYPE float USING split_coefficient::float;

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
    MarketCapitalization VARCHAR(255),
    EPS VARCHAR(255),
    ProfitMargin VARCHAR(255),
    QuarterlyEarningsGrowthYOY VARCHAR(255),
    QuarterlyRevenueGrowthYOY VARCHAR(255),
    AnalystTargetPrice VARCHAR(255),
    Beta VARCHAR(255),
    SharesOutstanding VARCHAR(255),
    DividendDate VARCHAR(255),
    ExDividendDate VARCHAR(255)
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
    interestIncome TEXT,
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

