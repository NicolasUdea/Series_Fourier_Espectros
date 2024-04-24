% Menú inicial
menu_text = uicontrol("Style",'text','String', 'Seleccione una opción: ', ...
        'Position', [240,300,120,20]);
fourier_button = uicontrol('Style','pushbutton','Position',[240,285,120,20],...
    'String','Ecuación de Fourier');
espectro_button = uicontrol('Style','pushbutton','Position',[240,260,120,20],...
    'String','Espectro');

% Establecer las funciones de callback después de que todos los botones estén definidos
set(fourier_button, 'Callback', {@show_fourier, menu_text, fourier_button, espectro_button});
set(espectro_button, 'Callback', {@show_espectro, menu_text, fourier_button, espectro_button});

function show_fourier(~, ~, menu_text, fourier_button, espectro_button)
    % Ocultar el menú inicial
    clf;
    
    % Mostrar la interfaz de la Ecuación de Fourier
    tramo_text = uicontrol("Style",'text','String', 'Ingrese tramos: ', ...
            'Position', [240,300,120,20]);
    tramo_box= uicontrol('Style','edit','Position',[240,285,120,20]);

    interval_text = uicontrol("Style",'text','String', 'Ingrese Intervalos: ', ...
        'Position', [240,260,120,20]);
    interval1_box = uicontrol('Style','edit','Position',[240,245,120,20]);
    interval2_box = uicontrol('Style','edit','Position',[240,220,120,20]);

    exe_button=uicontrol('Style','pushbutton','Position',[240,175,120,20],...
        'String','Ejecutar');

    back_button = uicontrol('Style','pushbutton','Position',[240,150,120,20],...
        'String','Regresar');

    % Establecer las funciones de callback después de que todos los botones estén definidos
    set(exe_button, 'Callback', {@Fourier, tramo_box, interval1_box, interval2_box});
    set(back_button, 'Callback', {@back_to_menu, tramo_text, tramo_box, interval_text, interval1_box, interval2_box, exe_button, back_button});
end

function show_espectro(~, ~, menu_text, fourier_button, espectro_button)
    % Ocultar el menú inicial
    clf;
    
    % Mostrar la interfaz del Espectro
    tramo_text = uicontrol("Style",'text','String', 'Ingrese tramos: ', ...
            'Position', [240,300,120,20]);
    tramo_box= uicontrol('Style','edit','Position',[240,285,120,20]);

    interval_text = uicontrol("Style",'text','String', 'Ingrese Intervalos: ', ...
        'Position', [240,260,120,20]);
    interval1_box = uicontrol('Style','edit','Position',[240,245,120,20]);
    interval2_box = uicontrol('Style','edit','Position',[240,220,120,20]);

    exe_button=uicontrol('Style','pushbutton','Position',[240,175,120,20],...
        'String','Ejecutar');

    back_button = uicontrol('Style','pushbutton','Position',[240,150,120,20],...
        'String','Regresar');

    % Establecer las funciones de callback después de que todos los botones estén definidos
    set(exe_button, 'Callback', {@Espectro, tramo_box, interval1_box, interval2_box, tramo_text, interval_text, exe_button});
    set(back_button, 'Callback', {@back_to_menu, tramo_text, tramo_box, interval_text, interval1_box, interval2_box, exe_button, back_button});
end

function back_to_menu(~, ~, tramo_text, tramo_box, interval_text, interval1_box, interval2_box, exe_button, back_button)
    % Ocultar la interfaz actual
    clf;
    
    % Mostrar el menú inicial
    menu_text = uicontrol("Style",'text','String', 'Seleccione una opción: ', ...
            'Position', [240,300,120,20]);
    fourier_button = uicontrol('Style','pushbutton','Position',[240,285,120,20],...
        'String','Ecuación de Fourier','Callback',{@show_fourier, menu_text, fourier_button, espectro_button});
    espectro_button = uicontrol('Style','pushbutton','Position',[240,260,120,20],...
        'String','Espectro','Callback',{@show_espectro, menu_text, fourier_button, espectro_button});
end

% Aquí van las funciones Fourier y Espectro
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

function Espectro(~, ~, tramo_box, interval1_box, interval2_box, ...
    tramo_text, interval_text, exe_button)
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
    
    for i = 1:length(tramos)
        a0 = a0 + 2/T * int(tramos{1,i},t,intervalos{1,i});
        an = an + 2/T * int(tramos{1,i}*cos(n*w0*t),t,intervalos{1,i});
        bn = bn + 2/T * int(tramos{1,i}*sin(n*w0*t),t,intervalos{1,i});
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
    clf;
    plot(frec,ener,'*')
    hold on 
    plot(frec,ener)
end
