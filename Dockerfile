#Puxa a imagem do openjdk (java8 instlalado num Debian 10)
FROM openjdk:8

#adiciona um usuário chamado "aluno" (importante para que você consiga editar arquivos criados pelo contêiner)
RUN useradd -ms /bin/bash aluno
WORKDIR /home/aluno

#copia todos os conteúdos desta pasta (onde este Dockerfile está) na pasta de usuário aluno (do contêiner)
ADD Sleep.java /home/aluno

#eventuais programas/utilitários que você queira instalar no container devem ser feitos aqui