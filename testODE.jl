using ODE

function f(t, y)
    # Extract the components of the y vector
    (x, v) = y

    # Our system of differential equations
    x_prime = v
    v_prime = -x

    # Return the derivatives as a vector
    [x_prime; v_prime]
end;

function euler(start, time)

  # calculate time step dt, assume time is evenly spaced
  dt = time[2]-time[1];

  # initialize x and v as column vectors
  x = zeros(size(time)); v = zeros(size(time));
  x[1] = start[1]; v[1] = start[2];

  for k = 2:length(time)
    x[k] = x[k-1] + dt*v[k-1];
    v[k] = v[k-1] - dt*x[k-1];
  end

  t = time;
  return t, x, v
end

function implicit_euler(start, time)

  # calculate time step dt, assume time is evenly spaced
  dt = time[2]-time[1];

  # initialize x and v as column vectors
  x = zeros(size(time)); v = zeros(size(time));
  x[1] = start[1]; v[1] = start[2];

  for k = 2:length(time)
    x[k] = (x[k-1] + dt*v[k-1])/(1+dt^2);
    v[k] = (v[k-1] - dt*x[k-1])/(1+dt^2);
  end

  t = time;
  return t, x, v
end

function symplectic_euler(start, time)

  # calculate time step dt, assume time is evenly spaced
  dt = time[2]-time[1];

  # initialize x and v as column vectors
  x = zeros(size(time)); v = zeros(size(time));
  x[1] = start[1]; v[1] = start[2];

  for k = 2:length(time)
    x[k] = x[k-1] + dt*v[k-1];
    v[k] = v[k-1] - dt*x[k];
  end

  t = time;
  return t, x, v
end


# Initial condtions -- x(0) and x'(0)
const start = [0.0; 1]

# Time vector going from 0 to 2*PI in 0.01 increments
time = 0:0.1:400*pi;

using Switch

choice = 7;

@switch choice begin
  @case 1
   t, y = ode23(f, start, time);
   x = map(y -> y[1], y);
   v = map(y -> y[2], y);
  break
  @case 2
   t, y = ode45(f, start, time);
   x = map(y -> y[1], y);
   v = map(y -> y[2], y);
  break
  @case 3
   t, y = ode78(f, start, time);
   x = map(y -> y[1], y);
   v = map(y -> y[2], y);
  break
  @case 4
    t, y = ode23s(f, start, time);
    x = map(y -> y[1], y);
    v = map(y -> y[2], y);
  break
  @case 5
    t, x, v = euler(start, time);
  break
  @case 6
    t, x, v = implicit_euler(start, time);
  break
  @case 7
    t, x, v = symplectic_euler(start, time);
  break
end

using PyPlot
PyPlot.figure()
plot(t, x, label="x(t)")
plot(t, v, label="x'(t)")
legend();

PyPlot.figure()
plot(t, x.^2+v.^2, label="x(t)^2+x'(t)^2")

PyPlot.figure()
plot(x[1:1000], v[1:1000], marker="o")
# hold(true)
# for k = 1:length(time)
#   plot(x[k], v[k], label='o');
#   pause(3)
# end
