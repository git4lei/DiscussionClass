#
# [Y,isConverged]=newton4euler(f,x,y,Y,h)
# evaluate Newton's method for back_euler

# Modified From Sussmanm, http://www.math.pitt.edu/~sussmanm/2071Spring09/lab03/index.html#TheBackwardEulerMethod

function newton4euler(f,fy,t,y,Y,h)

TOL = 1.e-6;
MAXITS = 10;

isConverged= false;  # starts out FALSE
for n=1:MAXITS
  fValue = f(t, Y);
  fPartial = fy(t, Y);
  F = y + h * fValue - Y;
  dFdY = h * fPartial - 1;
  increment=dFdY\F;

  Y = Y - increment;
  if norm(increment,Inf) < TOL*norm(Y,Inf)
    isConverged= true;  # turns TRUE here
    return
  end
end

return Y, isConverged
end
