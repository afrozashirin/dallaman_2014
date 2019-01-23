function Hval = hill(t,tau,A,k)

Hval = A/(1+exp(-k*(t-tau)));
end

