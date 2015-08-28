function grayscott
m = 150; L = 2; tau = 0.1; u = ones(m,m); v = zeros(m,m);
[xx, yy] = meshgrid(linspace(0,L,m));
u(m/2+(1:20), m/2+(1:20)) = 1/2+0.1*(rand(20,20)-1);
v(m/2+(1:20), m/2+(1:20)) = 1/4+0.05*(rand(20,20)-1);
for k=0:1000000
  [du,dv] = f(u, v); u = u+tau*du; v = v+tau*dv;
  if mod(k,50)==0, contourf(xx,yy,u,linspace(0.1,0.9,4))
    title(['time t=',num2str(tau*k)]);
    axis equal; axis square; axis tight; axis off; drawnow
  end
end

function [du,dv]=f(u,v)
m = 150; ip = [2:m,1]; im = [m,1:m-1]; Du = 2e-5; Dv = 1e-5; 
L = 2; h = L/m; F = 0.03;  k =0.055; r = u.*v.^2; 
diffu = Du/h^2*(u(ip,:)+u(im,:)+u(:,ip)+u(:,im)-4*u);
diffv = Dv/h^2*(v(ip,:)+v(im,:)+v(:,ip)+v(:,im)-4*v);
du = diffu - r + F*(1-u); dv = diffv + r - (F+k)*v;
