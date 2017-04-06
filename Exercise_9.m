syms u;
% encode the fact that u is a real number (allows simplifications)
assume(u,'real');

a = 0.4;
l = 0.4;

% create a symbolic expression for an ellipse
R = sym([-2*a*((l-cos(u/5))*cos(u/5)+(1-l)); 2*a*(l-cos(u/5))*sin(u/5); 0]);

% compute the tangent vector
T = diff(R);
% compute That.  Simplify will make sure things are in a sane form.
That = simplify(T ./ norm(T));
Nhat = simplify(diff(That)./norm(diff(That)));
speed = simplify(norm(T))
N = simplify(diff(That));
Bhat = simplify(cross(That, Nhat));
omega = simplify(cross(That,N))
figure;
% make a plot
fplot3(R(1), R(2), R(3), [0, 8*pi]);