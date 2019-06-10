 
   Time = 7;

  fun = {@Polarplot, @Plot_rand};
  
  
  for idx = 1:length(fun)
 fun{2,idx} = func2str(fun{1,idx});
  end
 
  %string(fun{2,1}) == x;
  fun(:,1) = []
  
 for idx = 1:length(fun)
 fun{idx}()
 pause(2)
 end
  
   function Polarplot()
   A =randn(40,1);
   B = randn(40,1);
   polarplot(A,B)
   end
    
    function Plot_rand()
    A =randn(40,1);
    B = randi(10,40,1);
      plot(A, B)
    end