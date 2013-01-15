function [] = RunTwoParameterSets(Variable)

%Initialse the parameters to default values and save output matrices
setParams;
RunSimulation(30,1,0,params,'output1.mat');

%Make and save movie
load('output1.mat')
if(strcmpi(Variable,'State')==1)
    MakeMovie(StateOutput,Variable,params,'MovieNormal.avi');
elseif((strcmpi(Variable,'ATP')==1))
    MakeMovie(ATPOutput,Variable,params,'MovieNormal.avi');
elseif((strcmpi(Variable,'Glucose')==1))
    MakeMovie(GlucoseOutput,Variable,params,'MovieNormal.avi')
elseif((strcmpi(Variable,'Oxygen')==1))
    MakeMovie(OxygenOutput,Variable,params,'MovieNormal.avi')
elseif((strcmpi(Variable,'Hydrogen')==1))
    MakeMovie(HydrogenOutput,Variable,params,'MovieNormal.avi')
end

%Initialse the parameters to alternative values and save output matrices
setNewParams;
RunSimulation(30,1,0,params,'output2.mat');
load('output2.mat')
if(strcmpi(Variable,'State')==1)
    MakeMovie(StateOutput,Variable,params,'MovieNew.avi');
elseif((strcmpi(Variable,'ATP')==1))
    MakeMovie(ATPOutput,Variable,params,'MovieNew.avi');
elseif((strcmpi(Variable,'Glucose')==1))
    MakeMovie(GlucoseOutput,Variable,params,'MovieNew.avi')
elseif((strcmpi(Variable,'Oxygen')==1))
    MakeMovie(OxygenOutput,Variable,params,'MovieNew.avi')
elseif((strcmpi(Variable,'Hydrogen')==1))
    MakeMovie(HydrogenOutput,Variable,params,'MovieNew.avi')
end

Play2Movies('MovieNormal.avi','MovieNew.avi');