## java8 e postgres dockerizado ##

### Pré-requisitos ###

- Ter instalado na máquina Docker e Docker Compose.
 - Docker: https://docs.docker.com/engine/install/
 - Docker Compose: https://docs.docker.com/compose/install/

*Atenção* Se estiver usando Linux (espero que esteja) não esqueça de adicionar o grupo docker e seu usuário a ele:
https://docs.docker.com/engine/install/linux-postinstall/


- Ter algum cliente Postgres instalado

### Construindo e subindo os containers ###

No diretório com o `Dockerfile` e o `docker-compose.yml`

```
$ docker-compose build
```

Isso irá puxar a imagem openjdk:8 (Java 8 instalado num Debian 10 do dockerhub https://hub.docker.com/ (verifique para mais imagens legais))

Em seguida:

```
$ docker-compose up
```

Isso irá puxar a imagem Postgres e iniciar o servidor Postgres. Vale a pena dar uma lida nas linhas de log que vão aparecendo, pois indicam como o Postgres está sendo configurado.

Se tudo deu certo você deve ler uma mensagem do log do container de desenvolvimento "Sleeping", e do container do Postgres "database system is ready to accept connections".

Vamos primeiro tentar conectar ao Postgres. Usando seu cliente Postgres (eu uso pgAdmin3) na máquina local, inicie uma nova conexão usando o usuário, senha e nome do banco do serviço `db_postgres` descritos em `docker-compose.yml` (você pode alterá-los como quiser). Porque estamos fazendo o *port binding* `5432:5432`, o seu `localhost:5432` estará sendo escutado pelo `localhost:5432` deste container e, portanto, você pode cadastrar host: `localhost` e port: `5432`.

Dessa maneira, você deve ser capaz de se conectar e utilizar o banco a partir de sua máquina hospedeira.
A essa altura você provavelmente já conseguirá fazer EPs com Java etc. na sua máquina hospedeira, indicando as credenciais que acabamos de descrever.

Mas se você não deseja nem ter que instalar Java em sua máquina, você pode usar o container de desenvolvimento. Para isso, abra outro terminal e se conecte a ele com

```
$ docker exec -it --user aluno aluno_dev bash
```

Explorando com `$ ls` você verificará que está na pasta do volume dentro do container que está ligada a esta pasta (a pasta onde está o Dockerfile).

Experimente criar um arquivo usando o file system do computador hospedeiro e `$ ls` novamente no container: você verá que este arquivo estará lá. Isso é muito útil para o desenvolvimento, pois você poderá editar seus arquivos de código fonte usando um editor na máquina hospedeira e executá-lo dentro do container sem ter que ficar transferindo os arquivos a cada modificação.

O caminho oposto também acontece: experimente criar um arquivo de dentro do container com:

```
aluno@465dfd5: ~$ touch this
```

Um aqruivo `this` aparecerá em seu file system. Escreva algo nele e salve. No container:

```
aluno@465dfd5: ~$ cat this
```

### Conexão de container a container ###

Para se conectar ao servidor Postgres do outro container, todas as credenciais continuam as mesmas, mas terá que utilizar como host o container que roda o serviço db_postgres. Para isso você pode usa o valor da chave `container_name` do serviço descrito no `docker-compose.yml` (originalmente `postgres_container`)(Teoricamente também pode usar o IP local da rede Docker que vai ser algo como `127.25.0.X`).


### Informações extras ###

Para listar os containers:

```
$ docker ps -a
```

Eventualmente você vai querer apagar containers e imagens. Deve conseguir alguma ajuda aqui:
https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes
(ou em outros lugares apontados pelo Google)
