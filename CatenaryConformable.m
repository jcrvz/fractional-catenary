function [yconf] = CatenaryConformable(r,a,h,x,x0)
%CatenaryCaputo function to compute the fractional catenary curve with 
%the caputo fractional derivative
%r fractional order derivative
%a the parameter of the catenary
%h the original high
%x is the vector of distance of the reference
%x0 is the initial position x0


X=x-x0;
yconf=h+a*gamma(2-r)*((X/a).^(2-r).*sinh(X/a).*ml((X/a).^2,2,3-r,1)-(X/a).^(3-r).*cosh(X/a).*ml((X/a).^2,2,4-r,1));
end