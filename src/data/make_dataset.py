import pandas as pd
import yfinance as yf
import yahoofinancials

def stock_price_dataset(company: str, period: str = 'max', interval: str = '1d'):
    
    
    stock = yf.Ticker(company)

    stock_data = stock.history(period = period, interval = interval)
    
    print(stock_data)
    pass

def company_dataset():
    pass

if __name__ == '__main__':
    stock_price_dataset('AAPL')