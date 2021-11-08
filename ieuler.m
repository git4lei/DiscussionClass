clf
axis(1.5*[-1 1 -1 1])
axis square
bg = 'blue';

I = eye(2);
A = [0 1; -1 0];
for h = [1/4 1/32]
   x = [0 1]';
   line(x(1),x(2),'marker','o','color','k')
   for t = 0:h:6*pi
      x = (I - h*A)\x;
      line(x(1),x(2),'marker','.','color',bg)
   end
   bg = [0 2/3 0];
end
title('Implicit Euler')
