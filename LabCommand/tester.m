 
Log_Period = 1;
Log_Timer = timer('ExecutionMode', 'fixedRate', 'Period', Log_Period )  ;
            app.Log_Timer.BusyMode = 'queue';
            app.Log_Timer.TimerFcn = @(~,~) Timer_Update