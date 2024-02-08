function [yfc] = CatenaryCF(r,a,h,x,x0,d)
%CatenaryCaputo function to compute the fractional catenary curve with 
%the caputo fractional derivative
%r fractional order derivative
%a the parameter of the catenary
%h the original high
%x is the vector of distance of the reference
%x0 is the initial position x0
%s1=sinh(d);
%s2=cosh(d);
X=x-x0;

yfc=h+a*(1-r)*(sinh(X/a))+r*a*(cosh(X/a)-1);  %solucion anterior
end