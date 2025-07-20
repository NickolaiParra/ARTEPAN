# ARTEPAN

Este proyecto es una aplicación web que permite a los clientes registrarse, iniciar sesión, visualizar productos, crear pedidos y consultar el historial de sus pedidos. Incluye un frontend con HTML, CSS y JavaScript, y un backend desarrollado en PHP que expone APIs para interactuar con una base de datos MySQL.

---

## 📦 Pasos para ejecutar el proyecto en XAMPP

### 1️⃣ Descargar e instalar XAMPP

1. Accede a la página oficial de XAMPP: [https://www.apachefriends.org/index.html](https://www.apachefriends.org/index.html)
2. Descarga la versión de XAMPP compatible con tu sistema operativo (Windows, Linux o macOS).
3. Ejecuta el instalador y sigue las instrucciones para completar la instalación.
4. Una vez instalado, abre **XAMPP Control Panel**.
5. Activa los siguientes servicios haciendo clic en el botón **Start**:
   - Apache
   - MySQL

---

### 2️⃣ Descargar el proyecto ARTEPAN

1. Descarga el proyecto desde GitHub:
   - Si tienes Git instalado, ejecuta el siguiente comando en tu terminal o consola:  
     ```bash
     git clone https://github.com/NickolaiParra/ARTEPAN.git
     ```
   - Si no tienes Git, accede al repositorio en GitHub y haz clic en **Code > Download ZIP** para descargarlo. Luego extrae el contenido.
2. Copia o mueve la carpeta `ARTEPAN` al directorio **htdocs** de XAMPP:  
   `C:\xampp\htdocs\ARTEPAN`

---

### 3️⃣ Importar la base de datos

1. Abre tu navegador y accede a **phpMyAdmin**: [http://localhost/phpmyadmin](http://localhost/phpmyadmin)
2. Haz clic en **New** y crea una base de datos con el nombre:  
   **proyecto**
3. Con la base de datos seleccionada, haz clic en **Import** en el menú superior.
4. Selecciona el archivo `Database.sql` que se encuentra en la carpeta del proyecto:  
   `C:\xampp\htdocs\ARTEPAN\Database.sql`
5. Deja la opción **Parcial Import** desmarcada.
6. Haz clic en el botón **Import** de la parte inferior.

---

### 4️⃣ Configuración de archivos PHP

1. Abre cada archivo PHP del proyecto.
2. Actualiza `"password"` para que coincida con la configuración de tu instalación de MySQL.
   - Si estás usando la configuración por defecto de XAMPP, reemplaza `"password"` con una cadena vacía:  
     ```php
     $password = "";
     ```

---

### 5️⃣ Estructura del proyecto
- **ARTEPAN/**
  - 📂 **img/** – Carpeta que contiene todas las imágenes
  - 📄 `api.php`
  - 📄 `api_detalles_pedido.php`
  - 📄 `api_guardar_pedido.php`
  - 📄 `api_pedidos.php`
  - 📄 `api_principal.php`
  - 📄 `api_productos_favoritos.php`
  - 📄 `api_ultimo_pedido_cliente.php`
  - 📄 `api_update_profile.php`
  - 📄 `Database.sql` – Archivo con la estructura y datos de la base de datos
  - 📄 `detalles.html`
  - 📄 `index.html` – Página de inicio de sesión
  - 📄 `nuevo_pedido.html` – Página para crear un nuevo pedido
  - 📄 `pedidos.html` – Página para consultar pedidos
  - 📄 `pedidos_por_anio.php`
  - 📄 `perfil.html` – Página de perfil del cliente
  - 📄 `principal.html` – Página principal después del login
  - 📄 `ultimos_5_pedidos_cliente.php`

  
---

### 6️⃣ Ejecutar el proyecto

1. Asegúrate de que **Apache** y **MySQL** estén activados en el Panel de Control de XAMPP.
2. Abre tu navegador web y accede al proyecto con la siguiente URL:  
   [http://localhost/Artepan/index.html](http://localhost/Artepan/index.html)
3. Para iniciar sesión, puedes utilizar uno de los siguientes usuarios de prueba:

| Usuario    | Contraseña      |
|------------|------------------|
| cliente1   | cliente1-123     |
| cliente2   | cliente2-123     |
| cliente3   | cliente3-123     |
| cliente4   | cliente4-123     |

---

## ⚠️ Notas importantes

1. **Apache y MySQL deben permanecer activos** mientras usas la plataforma.  
2. Si cambias la contraseña del usuario root en MySQL, recuerda actualizarla en todos los archivos PHP.  
3. La carpeta `img` debe permanecer en su ubicación original para que las imágenes se muestren correctamente en la web.  
4. Si surge un error `403 Forbidden`, revisa los permisos de la carpeta en `htdocs` y asegúrate de que no haya espacios en el nombre de la carpeta.  
5. Si al intentar iniciar MySQL con el botón *Start* en el panel de control **se detiene inmediatamente**, cambia el puerto de MySQL en la configuración, por ejemplo a `3307`.  

---

