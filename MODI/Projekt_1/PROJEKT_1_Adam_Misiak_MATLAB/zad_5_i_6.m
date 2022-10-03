clear
clc
syms u u_0
ynielin = 16/25 * u + 9/10 * u^2 - 29/50 * u^3 - 1/5 * u^4;
yzlin = 1/50*u*(-40*(u_0)^3 -87*(u_0)^2 + 90*u_0 +32) + 1/50*(30*(u_0)^4 + 58*(u_0)^3 -45*(u_0)^2);
u_0 = -0.85;
u = [-1:0.05:1];
yzlin = double(subs(yzlin));
ynielin = double(subs(ynielin));
plot(u, yzlin)
hold on;
plot(u, ynielin)

xlabel('u')
ylabel('y')
legend('y_z_l_i_n','y_n_i_e_l','Location','southeast')
name = 'zad_6_u_neg_085';
print(name,'-dpng','-r400')