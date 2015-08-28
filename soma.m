function soma
pieces = {[1 2 3 4],[1 2 4],[1 2 3 5], [1 2 5 6],... 
  [1 2 4 10], [1,2,4,11], [1,2,4,13]}; % 3x3x3 = 27
col=1;
for k=1:length(pieces)
  if k==1, T1 = pieces{k};
  else,    T1 = rotations(pieces{k}); end
  for l=1:size(T1,1)
    T2=shifts(T1(l,:));
    for i=1:size(T2,1)
      c = zeros(34,1); c([T2(i,:),27+k]) = 1;
      A(:,col)=c; col=col+1;
    end
  end
end
tic, X=backtrack(A,[],1:size(A,2)), toc

function t = normal(xyz)
x=xyz(1,:);y=xyz(2,:);z=xyz(3,:);
t=sort(sub2ind([3,3,3],x-min(x)+1,y-min(y)+1,z-min(z)+1));

function T = rotations(t) 
T=[t]; l=1;
Dx=[1 0  0; 0 0 -1; 0 1 0];
Dy=[0 0 -1; 0 1  0; 1 0 0];
Dz=[0 -1 0; 1 0  0; 0 0 1];
G1={eye(3),Dz,Dz^2,Dz^3,Dy,Dy^3};
G2={eye(3),Dx,Dx^2,Dx^3};
[x,y,z]=ind2sub([3,3,3],t);
for g1=G1
  for g2=G2
    D=g1{:}*g2{:}; s=normal(D*[x;y;z]);
    if all(any(T~=repmat(s,l,1),2)), T=[T;s]; l=l+1; end
  end
end

function T = shifts(t)
T=[]; [x,y,z]=ind2sub([3,3,3],t);
for i=max(x):3
  for j=max(y):3
    for k=max(z):3
      s=sub2ind([3,3,3],x+i-max(x),y+j-max(y),z+k-max(z));
      T=[T;s];
    end
  end
end

function X = backtrack(A,x,active) 
b=~(sum(A(:,x),2));
if all(b==0),  X=x; somadraw(A,x);
else
  n = length(active); X = [];
  [egal, criticalb] = min(sum(A(b,active),2));
  bs = find(b); k = bs(criticalb);
  for w = active(find(A(k,active)==1))
    an=active(all((A(:,active) & repmat(A(:,w),1,n))==0));
    X=[X,backtrack(A,[x;w],an)];
  end
end
