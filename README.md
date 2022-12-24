<p align="center">
<img src="https://img.shields.io/badge/Language-TypeScript-3178c6.svg?style=flat-square" alt="TypeScript" />
<img src="https://img.shields.io/badge/Framework-VueJs-e023e.svg?style=flat-square" alt="VueJS" />
<img src="https://img.shields.io/badge/Code_style-prettier-ff69b4.svg?style=flat-square" alt="Prettier" />
<img src="https://img.shields.io/badge/Ionic-3880ff.svg?style=flat-square" alt="Ionic" />
<img src="https://img.shields.io/badge/Capacitor-1E90FF.svg?style=flat-square" alt="Ionic" />
<img src="https://img.shields.io/badge/Electron-87CEFA.svg?style=flat-square" alt="Ionic" />
</p>
# How to create a multi platforme app with ionic/capacitor/electron and vuejs

> :warning: This method is allowed for work in a mac M1
> Before create your project be sure to had the **ionic cli** by running ``` ionic --version ```
> To install run : 
>```bash 
>npm install -g @ionic/cli
>```
>
> :warning: You need to install Android Studio for build the app

**1) Create a project with the ionic cli**
```bash
ionic start myProjectName tabs --type=vue --capacitor
```
> <g>*Note: You can choose another template for starting : tabs, blank, sidemenu*</g> 

**2) Go to our project and add the depencie for electron**
```bash
cd myProjectName
npm i @capacitor-community/electron
```
**3) Build your app**
```bash
ionic build
```
**4) Use capacitor to create the Electron project**
```bash
npx cap add @capacitor-community/electron
```
**5) Go to the new directory, build the app and run the dev-server**
```bash
cd electron
npm run build
npm run electron:start-live
```
**6) Build the excecutable for desktop**
```bash
npm run electron:make
```
> *Note: If no publisher is defined delete in* ```electron-builder.config.json```
>```json
>"publish": {
>    "provider": "github"
>},
>```

> :boom: case error :
>
> ```bash 
> Exit code: ENOENT. spawn /usr/bin/python ENOENT  failedTask=build > stackTrace=Error: Exit code: ENOENT. spawn /usr/bin/python ENOENT
>```
>
> Update your ```package.json```
>```json
>"devDependencies": {
>    "electron": "^18.0.0",
>    "electron-builder": "^23.0.3",
>    "npm": "^8.8.0",
>    "node-cmd": "^5.0.0",
>    "electron-rebuild": "^3.2.7",
>    "typescript": "~4.3.5"
>  },
>```

**7) Add the build Android**
On the root directory run :
```bash
ionic capacitor add android
```

**8) Build the APK**
On the root directory run :
```bash
npx cap copy && npx cap sync
```
You can now open the Android app by running :
```bash
npx cap open android
```

**9) We can now create new commands on the root directory**
```json
"scripts": {
    "android:open": "npx cap open android",
    "capacitor:build": "npx cap copy && npx cap sync",
    "build:all": "npm run build && npm run capacitor:build && npm run android:open && cp -r ./dist ./electron/app && npm --prefix ./electron run build && npm --prefix ./electron run electron:make"
  },
```
That build the project, create the APK in the ```./android```directory, open Android Studio for build the app, build the Electron app and create a ```.dmg```package in ```./electron/dist``` 

> :warning: You can add this error by opening the new app
> ```bash
> Unhandled Promise Rejection Error: ENOENT: no such file or directory, open '/Applications/test-project.app/Contents/> > Resources/app-update.yml'
>```
> I work to resolve it. I take any ideas that come

:white_check_mark: Now enjoy and work to your multi-platform app!! :rocket:

## Run the app in Docker
if you have Docker you can run the app in it with this commands:
```bash
docker build -t image-name .