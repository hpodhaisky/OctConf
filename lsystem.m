function lsystem(rule, scale, phi, psi, depth)
G = F(rule, scale, phi, psi, depth, 0, 0, 1j, []);
plot(real(G), imag(G))

function [G,x,dx,k] = F(r, s, phi, psi, gen, k, x, dx, G)
if gen==0, seg = [x, x+dx]; G = [G, seg]; x = seg(2);
else
  while k < length(r)
    k = k + 1;
    switch r(k)
    case 'F'; [G,x,dx,~] = F(r,s,phi,psi,gen-1,0,x,dx,G);
    case '+'; dx = exp(phi*1j) * dx;
    case '-'; dx = exp(-psi*1j) * dx;
    case '['; [G,~,~,k]  = F(r,s,phi,psi,gen,k,x,s*dx,G);
    case ']'; G = [G, nan]; break; 
    end
  end
end
