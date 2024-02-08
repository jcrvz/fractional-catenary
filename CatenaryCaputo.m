function [yc] = CatenaryCaputo(r,a,h,x,x0)
%CatenaryCaputo function to compute the fractional catenary curve with 
%the caputo fractional derivative
%r fractional order derivative
%a the parameter of the catenary
%h the original high
%x is the vector of distance of the reference
%x0 is the initial position x0


X=x-x0;
%yc=h+a^(-r)*(X).^(1+r).*mlf(2,2+r,(X/a).^2,6);
yc=h+a^(-r)*(X).^(1+r).*ml((X/a).^2,2,2+r,1);
%yc=h+(1-r)*(sinh(X/a))+r*a*(cosh(X/a)-1);  solucion anterior

end

