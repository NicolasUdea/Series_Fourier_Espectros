% Grafique el espectro discreto de cualquier señal introducida por consola.

% F=-1 si -pi<t<0
% F=1 si 0<t<pi
% Periódica de periodo 2*pi
f = {-1, 1};
inter = {[-pi, 0] [0, pi]};
T = 2*pi;
w0 = 2*pi/T;
t = sym('t');
n = sym('n');

a0=0;an=0;bn=0;
for k=1:length(f)
    a0= a0 + 2/T*int(f{1,k}, t, inter{1,k});
    an= an + 2/T*int(f{1,k} * cos(n*w0*t), t, inter{1,k});
    bn= bn + 2/T*int(f{1,k} * sin(n*w0*t), t, inter{1,k});
end

% Grafique el espectro. Son dos vectores(frecuencia y energía) porque 
% es discreto.
for k=0:15
    if k == 0
        frec(1,k+1)= k*w0;
        ener(1,k+1)= eval(a0);
   
    else
        frec(1,k)= k*w0;
        ener(1,k)= sqrt(eval(subs(an, n, k)^2) + eval(subs(bn, n, k)^2));
    end
end
plot(frec,ener,'*')
hold on 
plot(frec,ener)

