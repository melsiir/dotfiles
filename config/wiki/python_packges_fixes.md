
# install Pillow in termux

```shell

```apt update && apt upgrade -y
apt install python make wget termux-exec clang libjpeg-turbo freetype -y
env INCLUDE="$PREFIX/include" LDFLAGS=" -lm" pip install Pillow
```

Or
LDFLAGS="-L/system/lib64/" CFLAGS="-I/data/data/com.termux/files/usr/include/" pip install Pillow

# install pyinstaller in termux

requirments

```shell

``` apt install clang libllvm binutils ldd
```
