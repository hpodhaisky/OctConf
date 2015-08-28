lsystem('F[+F][-F][++F][--F]', 0.6, pi/5, pi/8, 4); axis off; axis tight
print('-depsc2', '-S550,500', '/tmp/lsystem.eps')
system('ps2pdf -DEPSCrop /tmp/lsystem.eps img/lsystem1.pdf')


#lsystem('F[+F]F[-F][F]', 1, pi/6, pi/6, 3); axis off; axis tight
#print('-depsc2', '-S400,400', '/tmp/lsystem.eps')
#system('ps2pdf -DEPSCrop /tmp/lsystem.eps img/lsystem2.pdf')


#lsystem('FF-[-F+F+F]+[+F-F-F]',0.7,pi/6, pi/6, 3);  axis off; axis tight
#print('-depsc2', '-S400,400', '/tmp/lsystem.eps')
#system('ps2pdf -DEPSCrop /tmp/lsystem.eps img/lsystem3.pdf')

#lsystem('F-F++F-F', 1, pi/3, pi/3, 5);
#title('F-F++F-F'); axis off; axis tight
#print('-depsc2', '-S400,400', '/tmp/lsystem.eps')
#system('ps2pdf -DEPSCrop /tmp/lsystem.eps img/lsystem4.pdf')

