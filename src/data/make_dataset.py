import pandas as pd
import alpha_vantage.timeseries
import alpha_vantage.fundamentaldata
import time
import psycopg2
import pprint

import keys
from keys import api_key

overview_columns = [
    'Symbol',
    'AssetType',
    'Name',
    'Description',
    'Exchange',
    'Currency',
    'Country',
    'Sector',
    'Industry',
    'Address',
    'FiscalYearEnd',
    'LatestQuarter',
    'MarketCapitalization',
    'EPS',
    'ProfitMargin',
    'QuarterlyEarningsGrowthYOY',
    'QuarterlyRevenueGrowthYOY',
    'AnalystTargetPrice',
    'Beta',
    'SharesOutstanding',
    'DividendDate'
]

class StockData:
    
    def __init__(self, ticker: str):
        self.ticker = ticker
        self.ts = alpha_vantage.timeseries.TimeSeries(key=api_key,
                                                      output_format='pandas')
        self.fd = alpha_vantage.fundamentaldata.FundamentalData(key=api_key)
    
    def get_historical_data(self):
        data, _ = self.ts.get_daily_adjusted(symbol=self.ticker, outputsize='full')
        historical_data = pd.DataFrame(data=data)
        historical_data = historical_data.rename(columns={historical_data.columns[0]: 'open',
                                                          historical_data.columns[1]: 'high',
                                                          historical_data.columns[2]: 'low',
                                                          historical_data.columns[3]: 'close',
                                                          historical_data.columns[4]: 'adjusted_close',
                                                          historical_data.columns[5]: 'volume', 
                                                          historical_data.columns[6]: 'dividend_amount',
                                                          historical_data.columns[7]: 'split_coefficient'})
        historical_data = historical_data.reset_index()
        return historical_data
    
    def get_fundamental_data(self):
        overview = self.fd.get_company_overview(symbol=self.ticker)
        overview_df = pd.DataFrame(overview[0], index=[0], columns=overview_columns)
        
        q_bs = self.fd.get_balance_sheet_quarterly(symbol=self.ticker)
        bs_df = pd.DataFrame.from_records(q_bs[0])

        q_is = self.fd.get_income_statement_quarterly(symbol=self.ticker)
        is_df = pd.DataFrame.from_records(q_is[0])

        q_cf = self.fd.get_cash_flow_quarterly(symbol=self.ticker)
        cf_df = pd.DataFrame.from_records(q_cf[0])

        return overview_df, bs_df, is_df, cf_df
        
    def save_to_database(self):
        # Connect to PostgreSQL database
        conn = psycopg2.connect(
            host=keys.host,
            database=keys.database,
            user=keys.user,
            password=keys.password
        )

        # Open a cursor to perform database operations
        cur = conn.cursor()

        # Insert historical data into database
        historical_data = self.get_historical_data()            
        for row in historical_data.itertuples(index=False):
            cur.execute("""INSERT INTO historical_data (date, open, high, low, close, adjusted_close, volume, dividend_amount, split_coefficient) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)""",
                        (row.date,
                         row.open,
                         row.high,
                         row.low,
                         row.close,
                         row.adjusted_close,
                         row.volume,
                         row.dividend_amount,
                         row.split_coefficient))
        
        overview_data, _, _, _ = self.get_fundamental_data()
        for row in overview_data.itertuples(index=False):
            cur.execute("""INSERT INTO microsoft (Symbol, AssetType, Name, Description, Exchange, Currency, Country, Sector, Industry, Address, FiscalYearEnd, LatestQuarter, MarketCapitalization, EPS, ProfitMargin, QuarterlyEarningsGrowthYOY, QuarterlyRevenueGrowthYOY, AnalystTargetPrice, Beta, SharesOutstanding, DividendDate) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""",
                        (row.Symbol,
                         row.AssetType,
                         row.Name,
                         row.Description,
                         row.Exchange,
                         row.Currency,
                         row.Country,
                         row.Sector,
                         row.Industry,
                         row.Address,
                         row.FiscalYearEnd,
                         row.LatestQuarter,
                         row.MarketCapitalization,
                         row.EPS,
                         row.ProfitMargin,
                         row.QuarterlyEarningsGrowthYOY,
                         row.QuarterlyRevenueGrowthYOY,
                         row.AnalystTargetPrice,
                         row.Beta,
                         row.SharesOutstanding,
                         row.DividendDate))

        # Insert balance sheet data into database
        _, balance_sheet_data, _, _ = self.get_fundamental_data()
        for row in balance_sheet_data.itertuples(index=False):
            cur.execute("""INSERT INTO balance_sheet_data (fiscalDateEnding, reportedCurrency, totalAssets, totalCurrentAssets, cashAndCashEquivalentsAtCarryingValue, cashAndShortTermInvestments, inventory, currentNetReceivables, totalNonCurrentAssets, propertyPlantEquipment, accumulatedDepreciationAmortizationPPE, intangibleAssets, intangibleAssetsExcludingGoodwill, goodwill, investments, longTermInvestments, shortTermInvestments, otherCurrentAssets, otherNonCurrentAssets, totalLiabilities, totalCurrentLiabilities, currentAccountsPayable, deferredRevenue, currentDebt, shortTermDebt, totalNonCurrentLiabilities, capitalLeaseObligations, longTermDebt, currentLongTermDebt, longTermDebtNoncurrent, shortLongTermDebtTotal, otherCurrentLiabilities, otherNonCurrentLiabilities, totalShareholderEquity, treasuryStock, retainedEarnings, commonStock, commonStockSharesOutstanding) VALUES ( %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) """,
                        (row.fiscalDateEnding, row.reportedCurrency, row.totalAssets, row.totalCurrentAssets, row.cashAndCashEquivalentsAtCarryingValue, row.cashAndShortTermInvestments, row.inventory, row.currentNetReceivables, row.totalNonCurrentAssets, row.propertyPlantEquipment, row.accumulatedDepreciationAmortizationPPE, row.intangibleAssets, row.intangibleAssetsExcludingGoodwill, row.goodwill, row.investments, row.longTermInvestments, row.shortTermInvestments, row.otherCurrentAssets, row.otherNonCurrentAssets, row.totalLiabilities, row.totalCurrentLiabilities, row.currentAccountsPayable, row.deferredRevenue, row.currentDebt, row.shortTermDebt, row.totalNonCurrentLiabilities, row.capitalLeaseObligations, row.longTermDebt, row.currentLongTermDebt, row.longTermDebtNoncurrent, row.shortLongTermDebtTotal, row.otherCurrentLiabilities, row.otherNonCurrentLiabilities, row.totalShareholderEquity, row.treasuryStock, row.retainedEarnings, row.commonStock, row.commonStockSharesOutstanding))

        # Insert income statement data into database
        _, _, income_statement_data, _ = self.get_fundamental_data()
        for row in income_statement_data.itertuples(index=False):
            cur.execute("INSERT INTO income_statement_data (fiscalDateEnding, reportedCurrency, grossProfit, totalRevenue, costOfRevenue, costofGoodsAndServicesSold, operatingIncome, sellingGeneralAndAdministrative, researchAndDevelopment, operatingExpenses, investmentIncomeNet, netInterestIncome, interestIncome, interestExpense, nonInterestIncome, otherNonOperatingIncome, depreciation, depreciationAndAmortization, incomeBeforeTax, incomeTaxExpense, interestAndDebtExpense, netIncomeFromContinuingOperations, comprehensiveIncomeNetOfTax, ebit, ebitda, netIncome) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                        (row.fiscalDateEnding, row.reportedCurrency, float(row.grossProfit), float(row.totalRevenue), float(row.costOfRevenue), float(row.costofGoodsAndServicesSold), float(row.operatingIncome), float(row.sellingGeneralAndAdministrative), float(row.researchAndDevelopment), float(row.operatingExpenses), float(row.investmentIncomeNet), float(row.netInterestIncome), row.interestIncome, float(row.interestExpense), float(row.nonInterestIncome), float(row.otherNonOperatingIncome), row.depreciation, float(row.depreciationAndAmortization), float(row.incomeBeforeTax), float(row.incomeTaxExpense), float(row.interestAndDebtExpense), float(row.netIncomeFromContinuingOperations), float(row.comprehensiveIncomeNetOfTax), float(row.ebit), float(row.ebitda), float(row.netIncome)))


        # Insert cash flow statement data into database
        _, _, _, cash_flow_data = self.get_fundamental_data()
        for row in cash_flow_data.itertuples(index=False):
            cur.execute("INSERT INTO cash_flow_data (fiscalDateEnding, reportedCurrency, operatingCashflow, paymentsForOperatingActivities, proceedsFromOperatingActivities, changeInOperatingLiabilities, changeInOperatingAssets, depreciationDepletionAndAmortization, capitalExpenditures, changeInReceivables, changeInInventory, profitLoss, cashflowFromInvestment, cashflowFromFinancing, proceedsFromRepaymentsOfShortTermDebt, paymentsForRepurchaseOfCommonStock, paymentsForRepurchaseOfEquity, paymentsForRepurchaseOfPreferredStock, dividendPayout, dividendPayoutCommonStock, dividendPayoutPreferredStock, proceedsFromIssuanceOfCommonStock, proceedsFromIssuanceOfLongTermDebtAndCapitalSecuritiesNet, proceedsFromIssuanceOfPreferredStock, proceedsFromRepurchaseOfEquity, proceedsFromSaleOfTreasuryStock, changeInCashAndCashEquivalents, changeInExchangeRate, netIncome) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                        (row.fiscalDateEnding, row.reportedCurrency, row.operatingCashflow, row.paymentsForOperatingActivities, row.proceedsFromOperatingActivities, row.changeInOperatingLiabilities, row.changeInOperatingAssets, row.depreciationDepletionAndAmortization, row.capitalExpenditures, row.changeInReceivables, row.changeInInventory, row.profitLoss, row.cashflowFromInvestment, row.cashflowFromFinancing, row.proceedsFromRepaymentsOfShortTermDebt, row.paymentsForRepurchaseOfCommonStock, row.paymentsForRepurchaseOfEquity, row.paymentsForRepurchaseOfPreferredStock, row.dividendPayout, row.dividendPayoutCommonStock, row.dividendPayoutPreferredStock, row.proceedsFromIssuanceOfCommonStock, row.proceedsFromIssuanceOfLongTermDebtAndCapitalSecuritiesNet, row.proceedsFromIssuanceOfPreferredStock, row.proceedsFromRepurchaseOfEquity, row.proceedsFromSaleOfTreasuryStock, row.changeInCashAndCashEquivalents, row.changeInExchangeRate, row.netIncome))


        # Commit the changes to the database
        conn.commit()

        # Close the database connection
        cur.close()
        conn.close()


if __name__ == '__main__':
    stock = StockData('MSFT')
    # historical_data = stock.get_historical_data()

    # print(historical_data)
    # print(historical_data.info())

    # overview, bs_df, is_df, cf_df = stock.get_fundamental_data()

    # print(is_df)
        
    # for i in [is_df, cf_df]:
    #     print(i)
    
    # stock.save_to_database()