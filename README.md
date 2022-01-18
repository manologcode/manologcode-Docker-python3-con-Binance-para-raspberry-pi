# Docker python3 con Binance para raspberry pi

Contenedor docker ideal para correr aplicacion de traiding en Python. A un servidor o en una rapsberry pi, la imagen se compilada para las plataformas de linux/arm64

la imagen esta copilado sobre la rapberrry pi

copiar la los archivos para construirla.

    scp Dockerfile pi@192.168.1.200:~/binance/
    scp app/requirements.txt pi@192.168.1.200:~/binance/


para crear la imagen y subirla al repositorio

    docker build --no-cache --pull . -t manologcode/pybinace_pi

   
    docker push manologcode/pybinace_pi


    docker run -it -d --rm --name=pybinance -p 5000:5000 -v $PWD/app:/app manologcode/pybinace_pi




para compilar las imágenes estoy usando una github action para que cree automáticamente la imagen en varias arquitecturas y docker buildx una función en desarrollo de docker.

## arrancar el contenedor

    docker run -it --rm --name=pybinance -v $PWD/app:/app manologcode/pybinace_pi bash 



