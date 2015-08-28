function datacompression(file)
A = double(imread(file));
[m,n] = size(A);
[U,S,V] = svd(A);           
St = zeros(size(S)); 
for i = 1 : min(m,n)
    St(i,i) = S(i,i);       
    At = U*St*V';           % reconstruction using
    imagesc(At);axis equal; % just a few singular values 
    title(sprintf('i = %d',i)); 
end
