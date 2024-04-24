% Definir los tramos como funciones simbólicas
tramo_text = uicontrol("Style",'text','String', 'Ingrese tramos: ', ...
        'Position', [240,300,120,20]);
tramo_box= uicontrol('Style','edit','Position',[240,285,120,20]);

interval_text = uicontrol("Style",'text','String', 'Ingrese Intervalos: ', ...
    'Position', [240,260,120,20]);
interval1_box = uicontrol('Style','edit','Position',[240,245,120,20]);
interval2_box = uicontrol('Style','edit','Position',[240,220,120,20]);

exe_button=uicontrol('Style','pushbutton','Position',[240,175,120,20],...
    'String','Ejecutar','Callback',{@Fourier, tramo_box, interval1_box, interval2_box});

function Fourier(~, ~, tramo_box, interval1_box, interval2_box)
    t = sym('t');
    n = sym('n');

    tramo = split(get(tramo_box, 'string'), ',');
    interval1 = split(get(interval1_box, 'string'), ',');
    interval2 = split(get(interval2_box, 'string'), ',');

    tramos={str2sym(tramo(1)), str2sym(tramo(2))};
    intervalos={[str2sym(interval1(1)), str2sym(interval1(2))], ...
        [str2sym(interval2(1)), str2sym(interval2(2))]};
    a0=0; an=0; bn=0;
    
    % Definir el periodo y el omega 0
    T = 2*pi;
    w0 = 2*pi/T;
    
    % Lo siguiente debe recrearse en todos los intervalos, nuestra f son los
    % tramos
    fourier_str = '$$';
    for i = 1:length(tramos)
        a0 = a0 + 2/T * int(tramos{1,i},t,intervalos{1,i});
        an = an + 2/T * int(tramos{1,i}*cos(n*w0*t),t,intervalos{1,i});
        bn = bn + 2/T * int(tramos{1,i}*sin(n*w0*t),t,intervalos{1,i});
    end
    
    if a0 ~= 0
        a0 = simplify(a0);
        a0 = vpa(a0,4);
        fourier_str = [fourier_str char(a0/2) '+'];
    end
    
    fourier_str = [fourier_str '\sum_{n=1}^{\infty}{'];

    if an ~= 0
        an = simplify(an);
        an = vpa(an,4);
        fourier_str = [fourier_str '[' char(an) ']\cos(n\frac{2\pi} {T}) +'];
    end

    if bn ~= 0
        bn = simplify(bn);
        bn = vpa(bn,4);
        fourier_str = [fourier_str '[' char(bn) ']\sin(n\frac{2\pi} {T})}$$'];
    end

    s=0; t1=-2*T:4*T/100:T;
    for k = 1:20
        s = s + eval(subs(an, n, k))*cos(k*w0*t1) + eval(subs(bn, n, k))*sin(k*w0*t1);
    end
    
    clf;
    s1 = a0/2+s;
    plot(t1, s1);
    title(fourier_str, 'Interpreter', 'latex')
end
