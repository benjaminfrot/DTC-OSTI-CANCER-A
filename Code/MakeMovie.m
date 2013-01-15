%Make movie!!!
function []=MakeMovie(SavedMat,Variable,params,filename)

NSaves=floor(length(SavedMat)/params.height);

for i=1:1:NSaves

     Matrix=SavedMat((i-1)*params.height+1:(i)*params.height,:);
     fontSize=14;
     
    %If the input is a state matrix
    if(strcmpi(Variable,'State')==1)
        epty = (Matrix == 0);                            % 1
        normal = logical((Matrix == 1));                 % 2
        hypl = logical((Matrix == 5) + (Matrix == 7));    % 3
        hyplgly = logical((Matrix == 6));                % 4
        hyplglyar = logical((Matrix == 8));              % 5

        toDisplay = 5*ones(params.height, params.width);
        toDisplay(epty) = 0;
        toDisplay(normal) = 1;
        toDisplay(hypl) = 2;
        toDisplay(hyplgly) = 3;
        toDisplay(hyplglyar) = 4;

        imagesc(toDisplay,[0 5]);
        title('State Matrix','FontSize',fontSize);
        colorbar;
        set(gca,'FontSize',fontSize)
    elseif((strcmpi(Variable,'ATP')==1))
        imagesc(Matrix, [0 2]);
        title('ATP Matrix','FontSize',fontSize);
        colorbar;
        set(gca,'FontSize',fontSize)
    elseif((strcmpi(Variable,'Glucose')==1))
        imagesc(Matrix);
        title('Glucose Matrix','FontSize',fontSize);
        colorbar;
        caxis([0.95,1]);
        set(gca,'FontSize',fontSize)
    elseif((strcmpi(Variable,'Oxygen')==1))
        imagesc(Matrix);
        title('Oxygen Matrix','FontSize',fontSize);
        colorbar;
        caxis([0.2,1]);
        set(gca,'FontSize',fontSize)
    elseif((strcmpi(Variable,'Hydrogen')==1))
        imagesc(Matrix);
        title('Hydrogen Matrix','FontSize',fontSize);
        colorbar;
        caxis([0,500]);
        set(gca,'FontSize',fontSize)
    end
        
    set(gcf,'Renderer','zbuffer')
    M(i)=getframe(gcf);
end

movie(M,1,12);
movie2avi(M,(filename));
