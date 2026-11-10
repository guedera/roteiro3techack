# Roteiro 3 — Investigação web

Este repositório apoia a atividade do PDF **Roteiro 3 - Investigação web.pdf**. Execute os testes **na sua VM Kali Linux**, com WebGoat, Burp Suite Community Edition e o navegador integrado do Burp. O enunciado pede **um relatório técnico** e **uma demonstração prática**.

## 1. Iniciar o laboratório

Na Kali, com Docker instalado e em execução:

```bash
chmod +x scripts/iniciar-webgoat.sh
./scripts/iniciar-webgoat.sh
```

Se aparecer a mensagem de que o serviço Docker não está acessível, inicie-o na Kali com `sudo systemctl start docker` e execute o script novamente.

O script cria ou reinicia `webgoat-lab` com a imagem exigida `webgoat/webgoat:v2025.3`. As portas 8080 e 9090 ficam publicadas apenas em `127.0.0.1`. Se já existir um container com esse nome, mas com imagem ou portas diferentes, o script para e informa o problema; não remove dados.

Para conferir ou diagnosticar:

```bash
sudo docker ps --filter name=webgoat-lab
sudo docker logs --tail 30 webgoat-lab
```

No Burp, use **Proxy → Open browser** e acesse `http://127.0.0.1:8080/WebGoat`. O WebWolf, usado por algumas lições, fica em `http://127.0.0.1:9090/WebWolf`.

## 2. Confirmar a interceptação

1. Em **Proxy → Intercept**, ative **Intercept is on**.
2. Acesse o WebGoat no navegador integrado. A requisição deve aparecer no Burp; clique **Forward**.
3. Em **Proxy → HTTP history**, localize a requisição e sua resposta. O *Intercept* normalmente captura a requisição; o código e o corpo da resposta aparecem no histórico ou no Repeater.
4. Desative a interceptação para navegar normalmente.

## 3. Executar os testes

Use a pasta `evidencias/` para salvar os pares de requisição e resposta relevantes do Burp, pela opção **Save item** ou copiando o conteúdo bruto. Use nomes como `E01-login-requisicao.txt` e `E01-login-resposta.txt`. Registre no relatório o ID, a condição alterada, o esperado e o observado. O histórico temporário do Burp não substitui os arquivos de evidência.

Siga esta sequência:

1. **HTTP:** escolha duas requisições de funcionalidades diferentes e compare método, caminho, parâmetros, cabeçalhos, cookies, código e conteúdo da resposta.
2. **Autenticação:** crie uma conta fictícia no WebGoat. Salve mensagens antes e depois do login; compare o identificador de sessão e os atributos dos cookies (`HttpOnly`, `Secure`, `SameSite`, quando presentes).
3. **Sessão:** envie uma requisição autenticada ao Repeater. Teste a original, a mesma sem o identificador de sessão e, após logout, a mesma com o identificador antigo.
4. **Autorização:** use uma lição como *Insecure Direct Object References* ou *Missing Function Level Access Control*. Anote primeiro a regra de acesso. Teste acesso permitido, acesso sem autenticação, outra identidade se a lição oferecer usuários próprios e alteração de identificador ou parâmetro. Confira o corpo da resposta e se a operação ocorreu.
5. **Matriz e investigação:** preencha a matriz do relatório com ao menos um caso permitido, um negado, um sem autenticação e um com parâmetro alterado. Escolha um comportamento para investigar em profundidade.

Para usar o Repeater: no **HTTP history**, clique com o botão direito em uma requisição → **Send to Repeater**; abra **Repeater**, edite somente a condição planejada e clique **Send**. Preserve a requisição original para comparação. Dois usuários registrados no WebGoat principal têm as mesmas permissões; quando precisar de papéis diferentes, use os usuários próprios de uma lição.

Classifique cada resultado como **comportamento esperado**, **configuração inadequada**, **vulnerabilidade confirmada** ou **resultado inconclusivo**. Uma mudança no código HTTP não comprova, sozinha, uma vulnerabilidade. Um identificador de sessão aparentemente inalterado após login também exige verificações adicionais antes de concluir fixação de sessão.

## 4. Escrever o relatório

Preencha [RELATORIO.md](RELATORIO.md) com observações reais e associe cada conclusão aos arquivos em `evidencias/`. O modelo inclui todos os tópicos pedidos: ambiente, método, HTTP, autenticação e sessão, autorização, matriz, investigação aprofundada, conclusões e recomendações.

O enunciado não determina um formato de arquivo. Se precisar entregar em PDF, converta o relatório preenchido com uma ferramenta Markdown e confira a formatação antes de enviar.

Para saber exatamente quais comandos rodar na Kali e quais prints e arquivos me enviar para completar o relatório, siga [comandos.md](comandos.md).

## 5. Preparar a demonstração

Na VM Kali, deixe WebGoat e Burp abertos. Ensaie interceptar uma requisição, encaminhá-la, enviá-la ao Repeater, alterar **uma** condição de autenticação/sessão/autorização e explicar o resultado usando a requisição e a resposta salvas. O professor poderá pedir que você mude uma condição do teste.

## Encerrar e retomar

```bash
sudo docker stop webgoat-lab
```

Para retomar, execute `./scripts/iniciar-webgoat.sh` novamente. Mantenha os testes restritos à VM Kali.
