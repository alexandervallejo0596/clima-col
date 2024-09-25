# Clima Col

Clima Col es una aplicación móvil desarrollada en Flutter que proporciona información meteorológica actual y pronósticos para tu ubicación actual. Utiliza servicios de geolocalización y una API de clima para obtener y mostrar datos precisos.

## Características

- **Clima Actual**: Muestra la temperatura actual, el nombre de la ciudad y una descripción del clima.
- **Pronóstico Completo**: Permite ver un pronóstico detallado del clima.
- **Actualización Automática**: Actualiza los datos meteorológicos cada 10 minutos.
- **Interfaz Atractiva**: Fondo personalizado y diseño intuitivo.
- 1. **Clonar el repositorio**:
 ```bash
 git clone https://github.com/tu_usuario/clima_col.git
 cd clima_col
2. **Instalar dependencias:**
flutter pub get
3. Configurar permisos
Android: Agrega los siguientes permisos en AndroidManifest.xml:
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
4.Ejecutar la aplicación:
flutter run
Uso
Al abrir la aplicación, se te pedirá permiso para acceder a tu ubicación. Una vez concedido, la aplicación mostrará el clima actual de tu ubicación. Puedes actualizar los datos manualmente o ver el pronóstico completo utilizando los botones disponibles.

Estructura del Proyecto
main.dart: Punto de entrada de la aplicación. Configura los permisos y las rutas.
home_screen.dart: Pantalla principal que muestra el clima actual.
forecast_screen.dart: Pantalla que muestra el pronóstico completo.
services/: Contiene los servicios para obtener la ubicación y los datos meteorológicos.
Dependencias
flutter
geolocator
permission_handler
shared_preferences
Contribuciones
Las imagenes de evidencia en otros dispositivos se encuentran en la carpeta assets/dispostivos.

