function [w_n] = computeNaturalFreq(zetta,w_b)

w_n = (1/(sqrt(1-2*zetta^2+sqrt(4*zetta^4-4*zetta^2+2))))*w_b;

end