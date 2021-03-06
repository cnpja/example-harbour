# CNPJá! - Consulta CNPJ via Harbour

Este repositório fornece um exemplo de como integrar a nossa API de consulta CNPJ a Receita Federal, Simples Nacional e Cadastro de Contribuintes via Harbour.

## Instruções

1\. Clone o repositório:

```
git clone https://github.com/cnpja/example-harbour.git
```

2\. Substitua a variável `CHAVEAPI` no arquivo `cnpja.prg` com sua Chave de API, caso ainda não tenha conta crie gratuitamente em:

[CNPJá! - Minha Conta](https://www.cnpja.com/me)

3\. Execute a CLI do xHarbour ou Harbour para criar o arquivo executável:

```
hbmake cnpja
```
ou
```
hbmk2 cnpja
```

4\. Abra o recém criado `cnpja.exe` para testar.

*Não precisa de nenhuma lib extra para compilar! ;)
