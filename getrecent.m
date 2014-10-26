%getrecent.m
function [output]=getrecent(paramvector,timevector,currenttime)
recentind = find(currenttime<timevector,1);
output = paramvector(recentind);
end