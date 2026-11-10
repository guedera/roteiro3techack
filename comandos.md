# Comandos e evidências para o Roteiro 3

Execute tudo **dentro da VM Kali Linux**, na pasta deste projeto. Use somente o WebGoat local. Crie uma conta fictícia; não envie sua senha nos prints nem nos arquivos.

## 1. Preparar e comprovar o ambiente

No terminal da Kali:

```bash
cd /caminho/para/roteiro3techack
chmod +x scripts/iniciar-webgoat.sh
./scripts/iniciar-webgoat.sh
```

Troque `/caminho/para/roteiro3techack` pelo caminho real da pasta na Kali. Se o script disser que o Docker não está acessível:

```bash
sudo systemctl start docker
./scripts/iniciar-webgoat.sh
```

Depois rode:

```bash
cat /etc/os-release
sudo docker ps --filter name=webgoat-lab
sudo docker inspect --format '{{.Config.Image}}' webgoat-lab
sudo docker port webgoat-lab
curl -sS -o /dev/null -w 'HTTP %{http_code}\n' http://127.0.0.1:8080/WebGoat
mkdir -p evidencias
```

**Envie:** um print do terminal mostrando a imagem `webgoat/webgoat:v2025.3`, o container em execução, as portas `127.0.0.1:8080` e `127.0.0.1:9090` e o resultado do `curl`. Pode enviar a saída de `cat /etc/os-release` como texto. Se o `curl` mostrar `200` ou `302`, abra a página no navegador do Burp para confirmar que está funcional.

## 2. Interceptar e observar HTTP

1. Abra o Burp Suite na Kali; use **Proxy → Open browser** e acesse `http://127.0.0.1:8080/WebGoat`.
2. Em **Proxy → Intercept**, ative a interceptação, recarregue a página e tire um print da requisição capturada. Clique **Forward**.
3. Em **Proxy → HTTP history**, escolha **duas requisições de funcionalidades diferentes**. Para cada uma, abra as abas de requisição e resposta e salve o conteúdo bruto em `evidencias/` (opção **Save item** ou copiar/colar em arquivos `.txt`).

**Envie:** o print da interceptação e, para cada requisição escolhida, os arquivos ou prints que mostrem método, caminho, parâmetros, cabeçalhos, cookies, código e corpo da resposta. Identifique como `E01` e `E02`.

## 3. Login e sessão

1. Antes do login, observe no **HTTP history** se há cookie de sessão. Registre seu **nome** e se ele aparece na resposta `Set-Cookie`.
2. Registre uma conta fictícia e faça login. Salve as requisições e respostas relevantes. Na resposta, procure `Set-Cookie` e seus atributos (`HttpOnly`, `Secure`, `SameSite`, quando presentes).
3. Escolha uma requisição de uma funcionalidade autenticada no histórico e use **Send to Repeater**. Envie a versão original e salve requisição e resposta como `E03`.
4. No Repeater, remova apenas o cabeçalho `Cookie` (ou o identificador de sessão usado pela aplicação), envie de novo e salve como `E04`.
5. Faça logout no navegador. No Repeater, reenvie a requisição com o **identificador antigo** e salve como `E05`.

**Envie:** prints ou arquivos dos pares `E03`, `E04` e `E05`, com o código **e o conteúdo** das respostas. Envie também os trechos antes/depois do login que permitam comparar os identificadores de sessão. Oculte a senha. Se preferir ocultar o valor do cookie, preserve uma marca consistente que permita dizer se era o mesmo antes/depois (por exemplo, `sessao-A` e `sessao-B`).

## 4. Controle de acesso

1. Escolha uma lição como **Insecure Direct Object References** ou **Missing Function Level Access Control**.
2. Anote ou faça um print da **regra de acesso descrita pela lição**: quem deveria acessar qual recurso ou função. Usuários comuns registrados no WebGoat têm as mesmas permissões; para comparar identidades com direitos diferentes, use os usuários próprios da lição, se houver.
3. Envie ao Repeater uma requisição de acesso permitido e salve requisição/resposta como `E06`.
4. Teste sem autenticação ou com outra identidade, conforme a lição permitir, e salve como `E07`.
5. Altere um identificador ou parâmetro de recurso e salve como `E08`. Mude **uma condição por vez**, partindo de uma cópia da requisição original.

**Envie:** a regra do cenário e os pares `E06`, `E07` e `E08`. Mostre o corpo das respostas e, se a operação modifica dados, um print ou requisição posterior que comprove se a alteração ocorreu. Apenas o código HTTP não basta para concluir que houve acesso indevido.

## 5. Enviar o material para o relatório

Para cada evidência, use nomes fáceis de relacionar:

```text
evidencias/E03-sessao-original-requisicao.txt
evidencias/E03-sessao-original-resposta.txt
evidencias/E04-sem-cookie-requisicao.txt
evidencias/E04-sem-cookie-resposta.txt
```

Envie-me os prints e os pares de requisição/resposta `E01` a `E08`, junto com estas quatro informações em texto:

1. Qual lição de autorização você escolheu e qual regra ela apresenta?
2. Qual conta ou identidade fictícia foi usada em cada teste? Não envie senhas.
3. Em qual teste o resultado mais surpreendeu você?
4. Houve alguma etapa que não funcionou ou cujo resultado ficou ambíguo?

Com esse material, consigo preencher o [RELATORIO.md](RELATORIO.md), montar a matriz e escolher um caso para a investigação aprofundada. Se necessário, pedirei apenas uma evidência complementar específica.

## Encerrar

Quando terminar os testes:

```bash
sudo docker stop webgoat-lab
```
