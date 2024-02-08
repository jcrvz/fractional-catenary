function [ya] = CatenaryABC(r,a,h,x,x0)
%CatenaryABC function to compute the fractional catenary curve with 
%the Atangana-Baleanu fractional derivative
%r fractional order derivative
%a the parameter of the catenary
%h the original high
%x is the vector of distance of the reference
%x0 is the initial position x0

X=x-x0;
%
%%%E = ml(z,alpha,beta,gama)
ya=h+a*((1-r)*sinh(X/a)+r*(X/a).^(1+r).*ml((X/a).^2,2,2+r,1));
%ya=h+a*(sinh(X/a)+r/(1-r)*ml((X/a).^2,2,2+r,1));
end

