> [!NOTE]
> Una nota
# Interfaz de Fourier y Espectro

Este código MATLAB proporciona una interfaz gráfica de usuario (GUI) para calcular y visualizar la serie de Fourier y el espectro de una función.

## ¿Qué hace el código?

El código crea una interfaz gráfica de usuario con dos botones: 'Ecuación de Fourier' y 'Espectro'. Al hacer clic en uno de estos botones, se abre una nueva interfaz donde el usuario puede ingresar los tramos e intervalos de la función. Luego, al hacer clic en el botón 'Ejecutar', se calcula y se muestra la serie de Fourier o el espectro de la función, dependiendo de la opción seleccionada.

## ¿Cómo lo hace?

El código utiliza la función `uicontrol` de MATLAB para crear los elementos de la interfaz gráfica de usuario, como botones y campos de texto. Las funciones de callback se definen para cada botón, que se ejecutan cuando se hace clic en el botón. Estas funciones de callback realizan las operaciones necesarias, como calcular la serie de Fourier o el espectro, y actualizar la interfaz gráfica de usuario.

## ¿Cómo usarlo?

1. Abra MATLAB y navegue hasta el directorio donde se encuentra el archivo 'interfaz.m'.
2. Ejecute el archivo 'interfaz.m'. Se abrirá una interfaz gráfica de usuario con dos botones: 'Ecuación de Fourier' y 'Espectro'.
3. Haga clic en uno de los botones. Se abrirá una nueva interfaz donde puede ingresar los tramos e intervalos de la función.
4. Ingrese los tramos e intervalos de la función en los campos de texto correspondientes.
5. Haga clic en el botón 'Ejecutar'. Se calculará y mostrará la serie de Fourier o el espectro de la función, dependiendo de la opción que haya seleccionado.
6. Para volver al menú principal, haga clic en el botón 'Regresar'.

Por favor, tenga en cuenta que este código está diseñado para trabajar con funciones que se pueden dividir en tramos y que son periódicas.
