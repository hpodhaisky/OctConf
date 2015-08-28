k=20; n=400;
self  = reshape(1:n*n,n,n);
left  = self(:,[n,1:n-1]);
right = self(:,[2:n,1]);
up    = self([n,1:n-1],:);
down  = self([2:n,1],:);
Z     = floor(k*rand(n,n));
h     = imagesc(Z); axis square; tic;   

for gen = 1:10000
  G = mod(Z(self)+1,k);
  i = (G==Z(down))|(G==Z(up))|(G==Z(left))|(G==Z(right));
  Z(i)=G(i); set(h, 'cdata', Z); e = toc;
  title(sprintf('%d (%5.4g fps)',gen, gen/e)); drawnow
end
