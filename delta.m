function Dval = delta(t,tau,A,k)

Hval = A/(1+exp(-k*(t-tau)));
Dval = k*Hval*(1-Hval/A);
end

