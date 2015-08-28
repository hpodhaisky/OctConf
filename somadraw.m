function somadraw(A,u)
Vertices = [ 0 0 0;  0 0 1;  0 1 0;  0 1 1
             1 0 0;  1 0 1;  1 1 0;  1 1 1 ];
Faces = [1 2 6 5;  1 2 4 3;  1 3 7 5;
         2 4 8 6;  3 4 8 7;  5 6 8 7 ];
cm = jet(7); view(3); axis([0 3 0 3 0 3]);
axis equal; axis off; cla
for k=u'
  f=(1:7)*A(28:end,k);
  for i = find(A(1:27,k))';
   [x,y,z]=ind2sub([3,3,3],i);
    patch('Vertices',0.9*Vertices+repmat([x y z]-1,8,1), ...
     'Faces',Faces,'EdgeColor','k',...
     'FaceVertexCData',cm(f,:),'FaceColor','flat');
  end, drawnow
end
