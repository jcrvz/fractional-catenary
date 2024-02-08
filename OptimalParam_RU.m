% =========================================================================
% Finding optimal parameters in a right-unbounded region
% =========================================================================
function [muj,hj,Nj] = OptimalParam_RU (t, phi_s_star_j, pj, log_epsilon)
% Evaluation of the starting values for sq_phi_star_j
sq_phi_s_star_j = sqrt(phi_s_star_j) ;
if phi_s_star_j > 0
    phibar_star_j = phi_s_star_j*1.01 ;
else
    phibar_star_j = 0.01 ;
end
sq_phibar_star_j = sqrt(phibar_star_j) ;
% Definition of some constants
f_min = 1 ; f_max = 10 ; f_tar = 5 ;
% Iterative process to look for fbar in [f_min,f_max]
stop = 0 ;
while ~stop
    phi_t = phibar_star_j*t ; log_eps_phi_t = log_epsilon/phi_t ;
    Nj = ceil(phi_t/pi*(1 - 3*log_eps_phi_t/2 + sqrt(1-2*log_eps_phi_t))) ;
    A = pi*Nj/phi_t ;
    sq_muj = sq_phibar_star_j*abs(4-A)/abs(7-sqrt(1+12*A)) ;
    fbar = ((sq_phibar_star_j-sq_phi_s_star_j)/sq_muj)^(-pj) ;
    stop = (pj < 1.0e-14) || (f_min < fbar && fbar < f_max) ;
    if ~stop
        sq_phibar_star_j = f_tar^(-1/pj)*sq_muj + sq_phi_s_star_j ;
        phibar_star_j = sq_phibar_star_j^2 ;
    end
end
muj = sq_muj^2 ;
hj = (-3*A - 2 + 2*sqrt(1+12*A))/(4-A)/Nj ;
% Adjusting integration parameters to keep round-off errors under control
log_eps = log(eps) ; threshold = (log_epsilon - log_eps)/t ;
if muj > threshold
    if abs(pj) < 1.0e-14 , Q = 0 ; else Q = f_tar^(-1/pj)*sqrt(muj) ; end
    phibar_star_j = (Q + sqrt(phi_s_star_j))^2 ;
    if phibar_star_j < threshold
        w = sqrt(log_eps/(log_eps-log_epsilon)) ;
        u = sqrt(-phibar_star_j*t/log_eps) ;
        muj = threshold ;
        Nj = ceil(w*log_epsilon/2/pi/(u*w-1)) ;
        hj = sqrt(log_eps/(log_eps - log_epsilon))/Nj ;
    else
        Nj = +Inf ; hj = 0 ;
    end
end
end