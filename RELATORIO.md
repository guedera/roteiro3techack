# Relatório técnico — Roteiro 3: investigação web

**Aluno:** [preencher]  
**Data:** [preencher]

> Substitua os campos entre colchetes por observações reais. Não conclua que há vulnerabilidade sem mostrar a requisição, a resposta e o acesso ou efeito indevido. Guarde os arquivos citados na pasta `evidencias/`.

## 1. Ambiente

- VM e sistema: [preencher]
- Imagem Docker: `webgoat/webgoat:v2025.3` [confirmar]
- Aplicação: `http://127.0.0.1:8080/WebGoat` [confirmar acesso]
- Portas: 8080 e 9090 vinculadas a `127.0.0.1` [confirmar]
- Burp Suite e navegador usados: [preencher]
- Verificações de funcionamento e interceptação: [preencher; IDs das evidências]

## 2. Método e organização das evidências

Descreva como cada teste foi preparado, qual condição mudou no Repeater e como as respostas foram comparadas. Identifique os pares de requisição/resposta por `E01`, `E02` etc. [preencher]

## 3. Comunicação HTTP

| Campo | Requisição 1 | Requisição 2 |
|---|---|---|
| Funcionalidade | [preencher] | [preencher] |
| Método e caminho | [preencher] | [preencher] |
| Parâmetros e cabeçalhos relevantes | [preencher] | [preencher] |
| Cookies | [preencher] | [preencher] |
| Código e conteúdo da resposta | [preencher] | [preencher] |
| Evidência (requisição e resposta) | [preencher] | [preencher] |

**Comparação das finalidades:** [preencher]  
**Dados fornecidos pelo cliente e decisões do servidor:** [preencher]  
**Por que parâmetros e cabeçalhos do cliente não devem ser aceitos sem validação:** [preencher]

## 4. Autenticação e sessão

**Registro e login da conta fictícia:** [preencher; não inclua a senha no relatório]  
**Identificador de sessão antes do login:** [preencher]  
**Identificador de sessão depois do login:** [preencher]  
**Atributos dos cookies observados (`HttpOnly`, `Secure`, `SameSite`):** [preencher]  
**O que a comparação indica sobre renovação de sessão e quais verificações adicionais seriam necessárias:** [preencher]

| Condição no Repeater | Resultado esperado | Código e comportamento observado | Evidência (requisição e resposta) |
|---|---|---|---|
| Sessão autenticada original | [preencher] | [preencher] | [preencher] |
| Identificador de sessão removido | [preencher] | [preencher] | [preencher] |
| Após logout, identificador anterior | [preencher] | [preencher] | [preencher] |

**Evidências de que a requisição foi processada em sessão autenticada:** [preencher]

## 5. Autorização

**Lição e recurso escolhidos:** [preencher]  
**Regra de acesso do cenário:** [preencher]  
**Identidades, permissões e recursos de cada uma:** [preencher]

Descreva o resultado dos testes de acesso permitido, sem autenticação, por outra identidade (se a lição permitir) e após alteração de um identificador ou parâmetro. Verifique o conteúdo da resposta e se a operação ocorreu. [preencher; IDs das evidências]

**Como a aplicação pode autenticar corretamente e ainda falhar na autorização, à luz dos resultados:** [preencher]

## 6. Matriz de testes

Inclua os testes de sessão e autorização já realizados. A coluna *Evidência* deve indicar **requisição e resposta salvas**. Adicione linhas conforme necessário.

| Identidade / sessão | Recurso ou endpoint | Operação | Resultado esperado | Resultado observado | Evidência | Classificação |
|---|---|---|---|---|---|---|
| [usuário autorizado] | [preencher] | [operação permitida] | [preencher] | [preencher] | [E...] | [preencher] |
| [usuário sem permissão] | [preencher] | [operação negada] | [preencher] | [preencher] | [E...] | [preencher] |
| Sem autenticação | [preencher] | [preencher] | [preencher] | [preencher] | [E...] | [preencher] |
| [identidade] | [recurso com parâmetro alterado] | [preencher] | [preencher] | [E...] | [preencher] |

Use apenas estas classificações: **comportamento esperado**, **configuração inadequada**, **vulnerabilidade confirmada** ou **resultado inconclusivo**.

## 7. Investigação aprofundada

1. **Hipótese e motivo:** [preencher]
2. **Metodologia:** requisição base, alteração planejada e condição de controle. [preencher]
3. **Resultado esperado se o controle funcionar:** [preencher]
4. **Resultado observado e evidências:** [preencher; IDs de requisição e resposta]
5. **Relação entre a alteração e o comportamento:** [preencher]
6. **Conclusão e classificação:** [preencher; indique limitações ou explicações alternativas]
7. **Recomendação, se aplicável:** [preencher]

## 8. Conclusões

Resuma o que os testes demonstraram, quais resultados permaneceram inconclusivos e quais recomendações são sustentadas pelas evidências. [preencher]

## 9. Índice das evidências

| ID | Arquivo da requisição | Arquivo da resposta | Teste ou conclusão sustentada |
|---|---|---|---|
| E01 | [preencher] | [preencher] | [preencher] |
