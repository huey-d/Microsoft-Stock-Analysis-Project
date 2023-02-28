import pandas as pd

# import plotly.express

import alpha_vantage.timeseries
import alpha_vantage.fundamentaldata

# import pprint
# import json

from api_key import api_key

def stock_historical_dataset(ticker: str):
    
    ts = alpha_vantage.timeseries.TimeSeries(key=api_key, # take out soon
                                             output_format='pandas')
    
    data, _ = ts.get_daily_adjusted(symbol=ticker, outputsize='full')
    
    historical_data = pd.DataFrame(data=data)

    historical_data = historical_data.rename(columns={historical_data.columns[0]: 'open',
                                                      historical_data.columns[1]: 'high',
                                                      historical_data.columns[2]: 'low',
                                                      historical_data.columns[3]: 'close',
                                                      historical_data.columns[4]: 'adjusted_close',
                                                      historical_data.columns[5]: 'volume', 
                                                      historical_data.columns[6]: 'dividend_amount',
                                                      historical_data.columns[7]: 'split_coefficient'})
    
    
    pass

def stock_fundamentals_dataset(company: str):

    fd = alpha_vantage.fundamentaldata.FundamentalData(key=api_key)
    
    # overview = fd.get_company_overview(symbol=company)

    # pprint.pprint(overview)

    # q_is = fd.get_income_statement_quarterly(symbol=company)
    # is_df = pd.DataFrame.from_records(q_is[0])
    
    # print(is_df)
    # print(is_df.info())
    
    # q_bs = fd.get_balance_sheet_quarterly(symbol=company)
    # bs_df = pd.DataFrame.from_records(q_bs[0])
    
    # print(bs_df)
    # print(bs_df.info())
    
    # q_cf = fd.get_cash_flow_quarterly(symbol=company)
    # cf_df = pd.DataFrame.from_records(q_cf[0])
    
    # print(cf_df)
    # print(cf_df.info())
    


    pass

if __name__ == '__main__':
    # stock_historical_dataset('')
    # stock_fundamentals_dataset('')
    pass