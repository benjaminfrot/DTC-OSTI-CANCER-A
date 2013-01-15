
%Sum the total type of each cell at each time point

t=35;


for i=0:1:Niter-1
    
    total_empty=(sum(StateOutput==0));
    total_empty1(i+1)=sum(total_empty(i*t+1:(i+1)*t));
    
    total_normal=(sum(StateOutput==1));
    total_normal1(i+1)=sum(total_normal(i*t+1:(i+1)*t));

    total_hyp=(sum(StateOutput==5 | StateOutput == 7));
    total_hyp1(i+1)=sum(total_hyp(i*t+1:(i+1)*t));

    total_other=(sum(StateOutput==2| StateOutput==3| StateOutput==4));
    total_other1(i+1)=sum(total_other(i*t+1:(i+1)*t));

    total_hyp_gly=(sum(StateOutput==6));
    total_hyp_gly1(i+1)=sum(total_hyp_gly(i*t+1:(i+1)*t));
    
    total_hyp_gly_AR=(sum(StateOutput==8));
    total_hyp_gly_AR1(i+1)=sum(total_hyp_gly_AR(i*t+1:(i+1)*t));


end

time=1:Niter;
plot(time, total_empty1, 'r', time, total_normal1, 'b', time, total_hyp1, 'g',...
    time, total_hyp_gly1, 'k', time, total_hyp_gly_AR1, 'y', time, total_other1, '--')
xlabel('time')
ylabel('cell counts')
legend('Empty','Normal', 'Hyp', 'Hyp+Gly', 'Hyp+Gly+AR', 'Other')
title('Cell Counts')