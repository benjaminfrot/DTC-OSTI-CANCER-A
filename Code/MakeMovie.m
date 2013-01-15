%Make movie!!!
function []=MakeMovie(SavedMat,params,filename)

close all

NSaves=floor(length(SavedMat)/params.height);

for i=1:1:NSaves

    State=SavedMat((i-1)*params.height+1:(i)*params.height,:);
    epty = (State == 0);                            % 1
    normal = logical((State == 1));                 % 2
    hypl = logical((State == 5) + (State == 7));    % 3
    hyplgly = logical((State == 6));                % 4
    hyplglyar = logical((State == 8));              % 5

    toDisplay = 5*ones(params.height, params.width);
    toDisplay(epty) = 0;
    toDisplay(normal) = 1;
    toDisplay(hypl) = 2;
    toDisplay(hyplgly) = 3;
    toDisplay(hyplglyar) = 4;

    imagesc(toDisplay,[0 5]);
    title('State Matrix');
    colorbar;
    
    set(gcf,'Renderer','zbuffer')
    M(i)=getframe(gcf);
end

movie(M,1,12);
movie2avi(M,(filename));
