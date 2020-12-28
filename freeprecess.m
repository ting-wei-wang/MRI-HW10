function [Afp,Bfp]=freeprecess(T,T1,T2,df)

 phi = 2*pi*df*T/1000;	% Resonant precession, radians.
 E1 = exp(-T/T1);	
 E2 = exp(-T/T2);

 Afp = [E2 0 0;0 E2 0;0 0 E1]*zrot(phi);
 Bfp = [0 0 1-E1]';
end
