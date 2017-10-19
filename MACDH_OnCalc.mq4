//+------------------------------------------------------------------+
//|                                                 MACDH_OnCalc.mq4 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_separate_window

#property indicator_buffers 3

#property indicator_color1 DodgerBlue
#property indicator_color2 Red
#property indicator_color3 Silver

#property indicator_level1 0

//----
#define arrowsDisplacement 0.0001
//---- input parameters
extern int FastMAPeriod = 12;
extern int SlowMAPeriod = 26;
extern int SignalMAPeriod= 9;
//---- buffers
double MACDLineBuffer[];
double SignalLineBuffer[];
double HistogramBuffer[];
//---- variables
double alpha=0;
double alpha_1=0;
//----
static datetime lastAlertTime;
static string   indicatorName;


const double constMarkupVal = 10000.0 ;


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   IndicatorDigits(Digits+1);
//---- indicators
   
   SetIndexStyle(0,DRAW_NONE);      // No drawing
   SetIndexBuffer(0,MACDLineBuffer);
   SetIndexDrawBegin(0,SlowMAPeriod);
   
   SetIndexStyle(1,DRAW_NONE);      // No drawing
   SetIndexBuffer(1,SignalLineBuffer);
   SetIndexDrawBegin(1,SlowMAPeriod+SignalMAPeriod);
   
   SetIndexStyle(2,DRAW_HISTOGRAM,STYLE_SOLID,2, clrBlue);
   SetIndexBuffer(2,HistogramBuffer);
   SetIndexDrawBegin(2,SlowMAPeriod+SignalMAPeriod);
   

//---- name for DataWindow and indicator subwindow label
   indicatorName=("MACDHist("+FastMAPeriod+","+SlowMAPeriod+","+SignalMAPeriod+")");
   SetIndexLabel(0,"MACD");
   SetIndexLabel(1,"Signal");
   SetIndexLabel(2,"Histogr");
   
   
   IndicatorShortName(indicatorName);
//----
   alpha=2.0/(SignalMAPeriod+1.0);
   alpha_1=1.0-alpha;
//----
   return(0);
  }
  

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---

   int counted_bars=IndicatorCounted();
   if(counted_bars<0) return(-1);
   if(counted_bars>0) counted_bars--;
   int limit=Bars-counted_bars;
   if(counted_bars==0) limit-=1+5;
   
   // 21/10/2016
   // MACDH is based on PRICE_MEDIAN, not PRICE_CLOSE
   // PRICE_MEDIAN disregards white candle or black candle on D1, therefore focusing on 
   // pure drift including its range.
   
   for(int i=limit; i>=0; i--)
     {
      MACDLineBuffer[i]=iMA(NULL,0,FastMAPeriod,0,MODE_EMA,PRICE_MEDIAN ,i) -
                        iMA(NULL,0,SlowMAPeriod,0,MODE_EMA,PRICE_MEDIAN ,i);
      SignalLineBuffer[i]= alpha*MACDLineBuffer[i]+alpha_1*SignalLineBuffer[i+1];
      HistogramBuffer[i] = (MACDLineBuffer[i]-SignalLineBuffer[i]) * constMarkupVal;
     }
        
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
