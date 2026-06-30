# ARTEPAN
This project is a web application that allows customers to register, log in, view products, place orders, and check their order history. It includes a frontend built with HTML, CSS, and JavaScript, and a backend developed in PHP that exposes APIs to interact with a MySQL database.

---

## 📦 Steps to Run the Project on XAMPP

### 1️⃣ Download and Install XAMPP
1. Go to the official XAMPP website: [https://www.apachefriends.org/index.html](https://www.apachefriends.org/index.html)
2. Download the XAMPP version compatible with your operating system (Windows, Linux, or macOS).
3. Run the installer and follow the instructions to complete the installation.
4. Once installed, open the **XAMPP Control Panel**.
5. Enable the following services by clicking the **Start** button:
   - Apache
   - MySQL

---

### 2️⃣ Download the ARTEPAN Project
1. Download the project from GitHub:
   - If you have Git installed, run the following command in your terminal or console:
     ```bash
     git clone https://github.com/NickolaiParra/ARTEPAN.git
     ```
   - If you don't have Git, go to the GitHub repository and click **Code > Download ZIP** to download it. Then extract the contents.
2. Copy or move the `ARTEPAN` folder to XAMPP's **htdocs** directory:
   `C:\xampp\htdocs\ARTEPAN`

---

### 3️⃣ Import the Database
1. Open your browser and go to **phpMyAdmin**: [http://localhost/phpmyadmin](http://localhost/phpmyadmin)
2. Click **New** and create a database named:
   **proyecto**
3. With the database selected, click **Import** in the top menu.
4. Select the `Database.sql` file located in the project folder:
   `C:\xampp\htdocs\ARTEPAN\Database.sql`
5. Leave the **Partial Import** option unchecked.
6. Click the **Import** button at the bottom.

---

### 4️⃣ PHP File Configuration
1. Open each PHP file in the project.
2. Update `"password"` to match your MySQL installation settings.
   - If you're using the default XAMPP configuration, replace `"password"` with an empty string:
     ```php
     $password = "";
     ```

---

### 5️⃣ Project Structure
- **ARTEPAN/**
  - 📂 **img/** – Folder containing all images
  - 📄 `api.php`
  - 📄 `api_detalles_pedido.php`
  - 📄 `api_guardar_pedido.php`
  - 📄 `api_pedidos.php`
  - 📄 `api_principal.php`
  - 📄 `api_productos_favoritos.php`
  - 📄 `api_ultimo_pedido_cliente.php`
  - 📄 `api_update_profile.php`
  - 📄 `Database.sql` – File with the database structure and data
  - 📄 `detalles.html`
  - 📄 `index.html` – Login page
  - 📄 `nuevo_pedido.html` – Page for creating a new order
  - 📄 `pedidos.html` – Page for viewing orders
  - 📄 `pedidos_por_anio.php`
  - 📄 `perfil.html` – Customer profile page
  - 📄 `principal.html` – Main page after login
  - 📄 `ultimos_5_pedidos_cliente.php`

---

### 6️⃣ Run the Project
1. Make sure **Apache** and **MySQL** are running in the XAMPP Control Panel.
2. Open your web browser and access the project at the following URL:
   [http://localhost/Artepan/index.html](http://localhost/Artepan/index.html)
3. To log in, you can use one of the following test accounts:

| Username   | Password         |
|------------|------------------|
| cliente1   | cliente1-123     |
| cliente2   | cliente2-123     |
| cliente3   | cliente3-123     |
| cliente4   | cliente4-123     |

---

## ⚠️ Important Notes
1. **Apache and MySQL must remain active** while using the platform.
2. If you change the MySQL root user's password, remember to update it in all PHP files.
3. The `img` folder must remain in its original location for images to display correctly on the site.
4. If a `403 Forbidden` error occurs, check the folder permissions in `htdocs` and make sure there are no spaces in the folder name.
5. If MySQL **stops immediately** when you click **Start** in the control panel, change the MySQL port in the configuration, for example to `3307`.
---
