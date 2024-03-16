# TIU LANCHES - Database
| :placard: Vitrine.Dev |     |
| -------------  | --- |
| :sparkles: Nome        | **Tiu Lanches - Database**
| :label: Tecnologias | MySQL, Terraform, GitHub Actions
| :rocket: URL         | 
| :fire: Desafio     | Tech Challenge FIAP

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

<!-- Inserir imagem com a #vitrinedev ao final do link -->
![](https://codedataops.files.wordpress.com/2023/03/slide1-7.png#vitrinedev)

# Detalhes do projeto
## Objetivo
Projeto criado para complementar o projeto principal [Tiu Lanches](https://github.com/luisferrarezi/tiulanches)

# MySQL
## Porque ele?
Optei por escolher essa base devido as razões abaixo:

- Ser um projeto pequeno, onde no momento não exige uma capacidade muito expressiva de processamento.
- Ser utilizado apenas para armazenar dados e não para execução de procedures ou functions.
- Ser seguro e confiável
- Ser gratuíto para o momento atual do projeto 

## Modelagem de dados

Segue a modelagem de como ficou a organização das tabelas e campos.

![]([https://luisferrarezi.notion.site/Modelagem-de-dados-9c30c3abc4024c06bb815341fb0b3f30](https://luisferrarezi.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F62941c71-5c2d-41d6-8c4f-a5f5b14de56c%2F1feac792-8695-4cb6-8c6d-75e908229bc8%2FUntitled.png?table=block&id=f356e806-1c5c-4ea9-829e-ed645f89b5fe&spaceId=62941c71-5c2d-41d6-8c4f-a5f5b14de56c&width=1730&userId=&cache=v2))

# Arquitetura
Este repositório é exclusivo para cuidar da estrutura necessário para a utilização do banco MySql.

É utilizado o recurso que fica disponível no Azure.

## Segurança
A branch main está bloqueada para commit direto.

É necessário ser criado um pull request para que após aprovado possa ser realizado o merge para a branch principal

## Automação
Atualmente para esta branch existem 2 níveis de automação, explicado abaixo:

- Pull Request: quando é criado um novo PR para a branch é executada uma validação para check das alterações propostas para a arquitetura via terraform
- Push: este é executado somente após o PR ter sido aprovado e executado o merge para a main, primeiro é checado que se o arquivo terraform está dentro do esperado para o HCL. Após esta validação é então solicitado para o administrador do projeto autorização para aplicar as alterações no azure. Implementei essa regra para ser mais uma nível de segurança para não se permitir que a estrutura seja alterada sem a devida supervisão.

Na azure foi criado o usuário github para que ele tenha as permissões necessárias para criar toda a estrutura para a base de dados.

## Infraestrutura
Através do Terraform é criada a estrutura do banco de dados com usuário e senha para ser utilizado pela aplicação preservando assim o usuário ROOT.

A versão do MySql utilizada é a 8.0, disponibilizado apenas 5 GB de armazenamento a princípio e foi deixado habilitado para que a própria Azure cuide da necessidade de se aumentar a capacidade dele.

### Variáveis de Ambiente
Existem variáveis de ambiente que são indispensáveis para que a estrutura seja corretamente criada:
- CLIENT_ID=<CLIENT_ID> - Esta informação está no github criado no azure
- CLIENT_SECRET=<CLIENT_SECRET> - Esta informação deve ser criada para o usuário github no azure
- DB_PASSWORD=<DB_PASSWORD> - Senha para o usuário criado para uso da aplicação
- DB_USERNAME=<DB_USERNAME> - Usuário criado para uso da aplicação
- SUBSCRIPTION_ID=<SUBSCRIPTION_ID> - Esta informação está no github criado no azure
- TENANT_ID=<TENANT_ID> - Esta informação está no github criado no azure
- TF_API_TOKEN=<TF_API_TOKEN> - Esta informação se encontra no https://app.terraform.io/ onde é necessário existir um token para que o git actions utilize os recursos da própria HashiCorp disponibiliza para criar a automação com o actions.
