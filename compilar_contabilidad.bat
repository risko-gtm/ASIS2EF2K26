:: ============================================================================
:: Compila, en orden, los componentes comunes (Consultas, Reporteador,
:: Seguridad, Navegador) y Contabilidad: la base, las 5 soluciones, el MDI y
:: Ejecucion_Contabilidad. Se detiene en el primer error.
:: Funciona desde cualquier carpeta: busca el repositorio subiendo desde el bat
:: o desde la carpeta actual, y en C:\ASIS2EF2K26. Si no lo encuentra, pide la ruta.
:: Base de datos: DSN asis22k26.
:: ============================================================================
@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul

set "MARCA=codigo\modulos\contabilidad\Bibliotecas de Contabilidad\Contabilidad\Contabilidad.sln"
set "RAIZ="
if not "%~1"=="" if exist "%~f1\%MARCA%" set "RAIZ=%~f1"
if not defined RAIZ call :subir "%~dp0."
if not defined RAIZ call :subir "%CD%"
if not defined RAIZ if exist "C:\ASIS2EF2K26\%MARCA%" set "RAIZ=C:\ASIS2EF2K26"
:pedir
if not defined RAIZ (
    set /p "RUTA=No se encontro el repositorio. Escriba su ruta: "
    if "!RUTA!"=="" exit /b 1
    for %%I in ("!RUTA!") do if exist "%%~fI\%MARCA%" set "RAIZ=%%~fI"
    goto :pedir
)

set "C=%RAIZ%\codigo\componentes"
set "M=%RAIZ%\codigo\modulos\contabilidad"
set "B=%M%\Bibliotecas de Contabilidad"

set "MSB=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
if not exist "%MSB%" (
    for /f "usebackq delims=" %%P in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe`) do set "MSB=%%P"
)
if not exist "%MSB%" (
    echo No se encontro MSBuild de Visual Studio 2022.
    pause
    exit /b 1
)

echo Repositorio: %RAIZ%
echo.

call :compilar "%C%\consultas\Consultas\CapaModelo_Consultas\CapaModelo_Consultas.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnActualizar_Reporteador\CapaModelo_BtnActualizar_Reporteador\CapaModelo_BtnActualizar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnBusqueda_Reporteador\CapaModelo_BtnBusqueda\CapaModelo_BtnBusqueda.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnEditar_Reporteador\CapaModelo_BtnEditar_Reporteador\CapaModelo_BtnEditar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnEliminar_Reporteador\CapaModelo_BtnEliminar_Reporteador\CapaModelo_BtnEliminar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnGuardar_Reporteador\CapaModelo_BtnGuardar_Reporteador\CapaModelo_BtnGuardar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnLimpiar_Reporteador\CapaModelo_BtnLimpiar_Reporteador\CapaModelo_BtnLimpiar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnRuta_Reporteador\CapaModelo_BtnRuta_Reporteador\CapaModelo_BtnRuta_Reporteador.csproj" || goto :fallo
call :compilar "%C%\seguridad\Seguridad\CapaModelo_Seguridad\CapaModelo_Seguridad.csproj" || goto :fallo
call :compilar "%C%\navegador\Navegador\CapaModelo_Navegador\CapaModelo_Navegador.csproj" || goto :fallo
:: Inicio de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
:: Fin de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
call :compilar "%B%\Contabilidad\CapaModelo_Contabilidad\CapaModelo_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\ActivosFijos_Contabilidad\CapaModelo_ActivosFijos_Contabilidad\CapaModelo_ActivosFijos_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\CierreContable_Contabilidad\CapaModelo_CierreContable_Contabilidad\CapaModelo_CierreContable_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\EstadosFinancieros_Contabilidad\CapaModelo_EstadosFinancieros_Contabilidad\CapaModelo_EstadosFinancieros_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\PolizasCuentas_Contabilidad\CapaModelo_PolizasCuentas_Contabilidad\CapaModelo_PolizasCuentas_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\Presupuestos_Contabilidad\CapaModelo_Presupuestos_Contabilidad\CapaModelo_Presupuestos_Contabilidad.csproj" || goto :fallo
:: Inicio de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
:: Fin de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
call :compilar "%C%\consultas\Consultas\CapaControlador_Consultas\CapaControlador_Consultas.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnActualizar_Reporteador\CapaControlador_BtnActualizar_Reporteador\CapaControlador_BtnActualizar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnBusqueda_Reporteador\CapaControlador_BtnBusqueda\CapaControlador_BtnBusqueda.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnEditar_Reporteador\CapaControlador_BtnEditar_Reporteador\CapaControlador_BtnEditar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnEliminar_Reporteador\CapaControlador_BtnEliminar_Reporteador\CapaControlador_BtnEliminar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnGuardar_Reporteador\CapaControlador_BtnGuardar_Reporteador\CapaControlador_BtnGuardar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnLimpiar_Reporteador\CapaControlador_BtnLimpiar_Reporteador\CapaControlador_BtnLimpiar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnRuta_Reporteador\CapaControlador_BtnRuta_Reporteador\CapaControlador_BtnRuta_Reporteador.csproj" || goto :fallo
call :compilar "%C%\seguridad\Seguridad\CapaControlador_Seguridad\CapaControlador_Seguridad.csproj" || goto :fallo
call :compilar "%C%\navegador\Navegador\CapaControlador_Navegador\CapaControlador_Navegador.csproj" || goto :fallo
:: Inicio de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
:: Fin de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
call :compilar "%B%\Contabilidad\CapaControlador_Contabilidad\CapaControlador_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\ActivosFijos_Contabilidad\CapaControlador_ActivosFijos_Contabilidad\CapaControlador_ActivosFijos_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\PolizasCuentas_Contabilidad\CapaControlador_PolizasCuentas_Contabilidad\CapaControlador_PolizasCuentas_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\CierreContable_Contabilidad\CapaControlador_CierreContable_Contabilidad\CapaControlador_CierreContable_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\EstadosFinancieros_Contabilidad\CapaControlador_EstadosFinancieros_Contabilidad\CapaControlador_EstadosFinancieros_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\Presupuestos_Contabilidad\CapaControlador_Presupuestos_Contabilidad\CapaControlador_Presupuestos_Contabilidad.csproj" || goto :fallo
:: Inicio de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
:: Fin de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
call :compilar "%C%\consultas\Consultas\CapaVista_Consultas\CapaVista_Consultas.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnActualizar_Reporteador\CapaVista_BtnActualizar_Reporteador\CapaVista_BtnActualizar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnBusqueda_Reporteador\CapaVista_BtnBusqueda\CapaVista_BtnBusqueda.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnEditar_Reporteador\CapaVista_BtnEditar_Reporteador\CapaVista_BtnEditar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnEliminar_Reporteador\CapaVista_BtnEliminar_Reporteador\CapaVista_BtnEliminar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnGuardar_Reporteador\CapaVista_BtnGuardar_Reporteador\CapaVista_BtnGuardar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnLimpiar_Reporteador\CapaVista_BtnLimpiar_Reporteador\CapaVista_BtnLimpiar_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\Reporteador\CapaModelo_Reporteador\CapaModelo_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\Reporteador\CapaControlador_Reporteador\CapaControlador_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\BtnRuta_Reporteador\CapaVista_BtnRuta_Reporteador\CapaVista_BtnRuta_Reporteador.csproj" || goto :fallo
call :compilar "%C%\reporteador\Reporteador\CapaVista_Reporteador\CapaVista_Reporteador.csproj" || goto :fallo
call :compilar "%C%\navegador\Navegador\CapaVista_Navegador\CapaVista_Navegador.csproj" || goto :fallo
:: Inicio de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
:: Fin de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
call :compilar "%B%\ActivosFijos_Contabilidad\CapaVista_ActivosFijos_Contabilidad\CapaVista_ActivosFijos_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\CierreContable_Contabilidad\CapaVista_CierreContable_Contabilidad\CapaVista_CierreContable_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\EstadosFinancieros_Contabilidad\CapaVista_EstadosFinancieros_Contabilidad\CapaVista_EstadosFinancieros_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\PolizasCuentas_Contabilidad\CapaVista_PolizasCuentas_Contabilidad\CapaVista_PolizasCuentas_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\Presupuestos_Contabilidad\CapaVista_Presupuestos_Contabilidad\CapaVista_Presupuestos_Contabilidad.csproj" || goto :fallo
call :compilar "%B%\Contabilidad\CapaVista_Contabilidad\CapaVista_Contabilidad.csproj" || goto :fallo
:: Inicio de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
:: Fin de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
:: Inicio de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
call :compilar "%C%\seguridad\Seguridad\CapaVista_Seguridad\CapaVista_Seguridad.csproj" || goto :fallo
:: Fin de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
call :compilar "%M%\Ejecucion_Contabilidad\Ejecucion_Contabilidad\Ejecucion_Contabilidad.csproj" || goto :fallo
:: Fin de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 07/11/2026

echo.
echo Listo. Ejecutable:
echo %M%\Ejecucion_Contabilidad\Ejecucion_Contabilidad\bin\Debug\Ejecucion_Contabilidad.exe
echo.
pause
exit /b 0

:compilar
for %%F in ("%~dp1..") do set "SOL=%%~fF\\"
:: Inicio de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
:: La propiedad extra llega por nombre de variable para no perder comillas ni ;
set "EXTRA="
if not "%~2"=="" set "EXTRA=!%~2!"
:: Sin compilador compartido ni nodos reutilizados: no deben quedarse con el log abierto
"%MSB%" "%~1" -restore -nodeReuse:false -p:UseSharedCompilation=false -p:RestorePackagesConfig=true "-p:SolutionDir=!SOL!" -p:Configuration=Debug -v:quiet -nologo !EXTRA! >"%TEMP%\compilar_contabilidad.log" 2>&1
:: Fin de cambio: Gabriel Andre Guillen Pocon - 0901-23-1998 - 11/11/2026
if errorlevel 1 (
    echo [ERROR] %~n1
    findstr /c:": error " "%TEMP%\compilar_contabilidad.log"
    exit /b 1
)
echo [OK]    %~n1
exit /b 0

:subir
set "D=%~f1"
:subir_siguiente
if exist "%D%\%MARCA%" (
    set "RAIZ=%D%"
    exit /b 0
)
for %%P in ("%D%\..") do set "P=%%~fP"
if /i "%P%"=="%D%" exit /b 0
set "D=%P%"
goto :subir_siguiente

:fallo
echo.
echo La compilacion se detuvo por un error.
pause
exit /b 1
