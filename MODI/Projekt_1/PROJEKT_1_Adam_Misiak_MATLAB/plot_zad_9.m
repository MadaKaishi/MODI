name = "Duzy sygnal u0 0.4.png";
stairs(out.yniel.time, out.yniel.signals.values)
hold on;
stairs(out.yzlin.time, out.yzlin.signals.values)
title("Duzy u " + u_0)
xlabel('t(s)');
ylabel('y');
legend('yniel','yzlin', 'Location', 'southeast');
print(name ,'-dpng','-r400') 