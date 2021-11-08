clf
axis(1.5*[-1 1 -1 1])
axis square
bg = 'blue';

for h = [1/4 1/32]
   x = 0;
   y = 1;
   line(x,y,'marker','o','color','k')
   for t = 0:h:10*pi
      line(x,y,'marker','.','color',bg)
      x = x + h*y;
      y = y - h*x;
   end
   bg = [0 2/3 0];
end
title('Original')
