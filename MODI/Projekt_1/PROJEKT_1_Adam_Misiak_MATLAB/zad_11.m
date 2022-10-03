syms z u_0 T
z = 1;
A = [(-T*(T1+T2)/(T1*T2))+1 T; -T/(T1*T2) 1];
B = [0 ; ((T*K)/(T1*T2))*(a1 + a2*2*u_0 + a3*3*(u_0)^2 + a4*4*(u_0)^3)];
C = [1 0];
D = 0;
G = C*((z*eye(2) - A)^-1)*B +D;
%u_0 = [-1:0.05:1];
%G = double(subs(G));
%plot(u_0, G);
%xlabel('u_0')
%ylabel('K(u_0)')
%print('K_od_u','-dpng','-r400') 