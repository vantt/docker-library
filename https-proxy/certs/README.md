# Self Signed Certificate Creation
## Create certificate using mkcert
```
export CAROOT=$(pwd)

./mkcert -key-file mio.key -cert-file mio.crt event.mio "*.event.mio" anphabe.com "*.anphabe.com"  anphabe.mio "*.anphabe.mio" symfony.mio "*.symfony.mio" survey.mio "*.survey.mio" 127.0.0.1 ::1

```

## 2. Install rootCA using mkcert
For linux
```
./linux_mkcert_install.sh
```
For window
```
Run window_mkcert_install.bat
```