
%Sum the total type of each cell at each time point

t=50;

for i=0:1:Niter-1
    
    total_empty=(sum(StateOutput==0));
    total_empty1(i+1)=sum(total_empty((i+1)*t:i*t+1));
    
    total_normal=(sum(StateOutput==1));
    total_normal1(i+1)=sum(total_normal((i+1)*t:i*t+1));

    total_hyp=(sum(StateOutput==5 | StateOutput == 7));
    total_hyp1(i+1)=sum(total_hyp((i+1)*t:i*t+1));

    total_other=(sum(StateOutput==2| StateOutput==3| StateOutput==4));
    total_other1(i+1)=sum(total_other((i+1)*t:i*t+1));

    total_hyp_gly=(sum(StateOutput==6));
    total_hyp_gly1(i+1)=sum(total_hyp_gly((i+1)*t:i*t+1));
    
    total_hyp_gly_AR=(sum(StateOutput==8));
    total_hyp_gly_AR1(i+1)=sum(total_hyp_gly_AR((i+1)*t:i*t+1));


end