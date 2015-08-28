rule = [30, 90, 110]; n = 150;
for r = rule
  M=zeros(n,2*n); M(1,n) = 1;
  for i=2:n
    for j=2:2*n-1
      M(i,j)=bitget(r, 1+M(i-1,j-1:j+1)*[4 2 1]'); 
    end
  end
  spy(M,5); axis off; axis tight;
end
