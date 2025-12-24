
### **Project Overview**

This project is a set of scripts that automatically configure a Linux desktop environment (likely GNOME-based) with themes, wallpapers, fonts, icons, and other customizations.

---

### **Step 1: Download and Run `boot.sh`**

The first command you mentioned is:

```bash
curl https://raw.githubusercontent.com/CodeCompasss/codekub/main/boot.sh | bash
```

* **Purpose:** Downloads `boot.sh` directly from GitHub and executes it.
* **What it does:** This script likely:

  1. Prepares the environment.
  2. Downloads other scripts (`install.sh` and additional resources).
  3. Starts the installation/configuration process.

---

### **Step 2: Run `install.sh`**

After booting, the main installation happens via `install.sh`.

* **Steps in `install.sh`:**

  1. Installs necessary tools (`gum` for interactive CLI prompts).
  2. Performs identification/setup of the system (like OS detection, dependencies check).
  3. Presents user choices:

     * Some options can be disabled (like the first choice you mentioned).
     * Installs terminal tools and desktop tools as needed.

---

### **Step 3: Configure Desktop**

Once the scripts finish installing, the system is customized:

* **Wallpaper and Theme:**

  * Default theme: `Tokyo Night`.
  * Default wallpaper: found in `theme` folder, file name: `background image`.

* **Desktop Folder:**

  * Contains important configuration files:

    * Sets desktop icons.
    * Configures dock.
    * Sets GNOME startup applications.

* **Appearance Settings (via Omkaun / Omaksu app):**

  * Font size and font family.
  * Header and other UI tweaks.
we are makse sl bootls.sh file use main odefault so we need to chagne for deve otehre wise you dev scipt chagne nwont apper remove the .config / omukub  maywork