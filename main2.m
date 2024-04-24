% Definir los tramos como funciones simbólicas
tramo_text = uicontrol("Style",'text','String', 'Ingrese tramos: ', ...
        'Position', [240,300,120,20]);
tramo_box= uicontrol('Style','edit','Position',[240,285,120,20]);

interval_text = uicontrol("Style",'text','String', 'Ingrese Intervalos: ', ...
    'Position', [240,260,120,20]);
interval1_box = uicontrol('Style','edit','Position',[240,245,120,20]);
interval2_box = uicontrol('Style','edit','Position',[240,220,120,20]);

exe_button=uicontrol('Style','pushbutton','Position',[240,175,120,20],...
    'String','Ejecutar','Callback',{@Espectro, tramo_box, ...
    interval1_box, interval2_box, tramo_text, interval_text, exe_button});

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
