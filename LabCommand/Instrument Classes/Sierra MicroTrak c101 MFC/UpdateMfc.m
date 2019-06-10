function  UpdateMfc(MFC,s)



   
   t=timer;
  
   t.TimerFcn = @timerCallback;
   t.Period   = 1;
   t.TasksToExecute = 50;
   t.ExecutionMode  = 'fixedRate';
   start(t);
   wait(t);
   delete(t);
   
  
 
    function timerCallback(~,~)
     Read_Flow(MFC,s)
     disp(MFC.Flowrate)
       
    end
end