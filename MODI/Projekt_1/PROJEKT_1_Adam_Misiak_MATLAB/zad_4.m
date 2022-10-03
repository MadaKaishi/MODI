K = 2;
T1 = 5;
T2 = 8;
a1 = 0.32;
a2 = 0.45; 
a3 = -0.29;
a4 = -0.1;
T = 1.5;
syms y x1 x2 u
dx1 = -((T1+T2)/(T1*T2))*x1 + x2;
dx2 = (-1/(T1*T2))*x1 + (K/(T1*T2))*(a1*u + a2*u^2 + a3*u^3 + a4*u^4);
[x1, x2] = solve(dx1, dx2);
y = x1

%u = [-1:0.05:1];
%y = double(subs(y));
%plot(u,y);
%xlabel('u');
%ylabel('y');
%title('Charakterystyka statyczna')
%name = 'zad_4_char_stat_v2';
%print(name,'-dpng','-r400')