# Descarga: https://git-scm.com/download/win

# Tutorial: https://try.github.io

# plugin eclipse: https://www.eclipse.org/egit/

# Más info: https://git-scm.com/docs


Se descarga una consola de git. Pinchando en el enlace del escritorio se abre. Luego se va a la carpeta que se quiera con:

    cd "C:\carpeta1\carpeta2\carpeta3"

Y ahi ya se usan los comandos.

#Uso: 

Para guardar cambios:

    git commit -a

Para subir cambios:

    git push
    
Para recibir cambios:

    git pull
    
Para mirar lo que se ha cambiado:

    git log
    
Para crear rama (commit es el número del cambio):

    git checkout -b COMMIT

Para añadir ficheros:

    git add NOMBREFICHERO
    git add * (para todos los ficheros de la carpeta)

Para quitar ficheros:

    git rm NOMBREFICHERO

Crearos una cuenta y hacer un fork del repositorio (Arriba a la derecha, donde pone fork).
Luego desde la consola de git poneis:

    git clone https://github.com/USUARIO/REPO.git
    
Ejemplo:

    git clone https://github.com/jaimejimbo/ifcwebgrupo.git
    
Y asi lo teneis en local.

