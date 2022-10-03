stairs(out.y_dys.time, out.y_dys.signals.values)
hold on;
plot(out.y_ciag.time, out.y_ciag.signals.values)
xlabel('t(s)');
ylabel('y');
legend('y_d_y_s','y_c_i_a_g', 'Location', 'southeast');
name = 'zad_3_T_07';
print(name,'-dpng','-r400')
