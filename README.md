## Homelab

Ambiente provisionado utilizando **`(Infra As Code)`** com **Terraform** e **Docker**.
*(Projeto desenvolvido para fins de estudo e prática)*.

**Setup:**

```bash
$ sh ./validate_requirements.sh
```

## Configuração

Após validar as ferramentas, você deverá configurar o ambiente para gerar as imagens Docker utilizando `Makefile`.

```bash
$ make build-all
```

Acesse o diretório `terraform` e execute o comando abaixo para inicializar o Terraform.

```bash
$ terraform init
```
Será criado um arquivo `terraform.tfstate` para armazenar o estado da infraestrutura, também será criado um diretório `.terraform` com os plugins necessários para o Terraform e um arquivo `terraform.lock.hcl` com as versões dos plugins.

Agora você poderá executar o comando abaixo para visualizar o plano de execução da infraestrutura.

```bash
$ terraform plan
```
Após analisar o plano de execução, você poderá executar o comando abaixo para provisionar a infraestrutura.

```bash
$ terraform apply #Sera solicitado a confirmação da execução ou
$ terraform apply --auto-approve #Executa sem solicitar confirmação
```
Feito isso, aguardar a execução do Terraform e a infraestrutura estará pronta para uso.

## Recursos provisionados

<details>
<summary><strong>IMAGES</strong></summary>

```hcl
- homelab-frontend;
- homelab-backend; 
- homelab-sql
```
</details>
<details>
<summary><strong>CONTAINERS</strong></summary>

```hcl
- homelab-frontend;
- homelab-backend;
- homelab-sql
```
</details>
<details>
<summary><strong>NETWORKS</strong></summary>

```hcl
- sql-network(bridge);
- frontend-network;

# Redes em modo bridge para manter a comunicação entre os containers.
# A rede frontend-network é a única rede que permite o acesso externo.
```
</details>   
<details>
<summary><strong>VOLUMES</strong></summary>

```hcl
- sql-data;	
- sql-logs;
- sql-init

# Volumes criados para persistir os dados dos containers.
```
</details>

### Endpoints

- [http://localhost](http://localhost:80) - **Frontend** (Acesso visível externamente);
- [http://homelab-backend:3001](http://homelab-backend:3001) - **Backend**(Acesso restrito a rede interna sql-network);
- [http://homelab-sql:5432](http://homelab-sql:5432) - **Backend**(Acesso restrito a rede interna sql-network);

Caso queira destruir a infraestrutura, execute o comando abaixo **(ATENÇÃO AO EXECUTAR A AÇÃO)**.

```bash
$ terraform destroy #Sera solicitado a confirmação da execução ou
$ terraform destroy --auto-approve #Executa sem solicitar confirmação
```

**Sigo a disposição em caso de dúvidas** 
- [Linkedin](https://www.linkedin.com/in/sr1bramos/)
- [E-mail](mailto:brunoramos013@gmail.com)
