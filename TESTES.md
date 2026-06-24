# Instruções para Execução de Testes - Voll.med API

Este documento fornece orientações sobre como executar os testes unitários e de integração deste projeto.

## 🚀 Pré-requisitos

Para executar os testes, você precisará de:

1. **Java 17** ou superior instalado.
2. **MySQL** rodando localmente (necessário para testes de repositório e integração).
3. Um banco de dados chamado `vollmed_db_test` criado no seu MySQL local.
   ```sql
   CREATE DATABASE vollmed_db_test;
   ```

## 🛠️ Executando os Testes

O projeto utiliza o **Maven Wrapper**, então você não precisa ter o Maven instalado globalmente.

### No Linux ou macOS:
```bash
./mvnw test
```

### No Windows (PowerShell ou Prompt de Comando):
```powershell
.\mvnw.cmd test
```

### Executando um teste específico:
Para rodar apenas uma classe de teste, utilize o parâmetro `-Dtest`:
```bash
./mvnw test -Dtest=ConsultaControllerTest
```

## 📊 Relatório de Cobertura (JaCoCo)

O projeto está configurado com o plugin **JaCoCo** para medir a cobertura de código.

1. Para gerar o relatório de cobertura, execute:
   ```bash
   ./mvnw test jacoco:report
   ```

2. Após a execução, o relatório em formato HTML estará disponível em:
   `target/site/jacoco/index.html`

Abra este arquivo em seu navegador para visualizar os detalhes da cobertura.

## 📝 Notas Importantes

- **Perfil de Teste**: Os testes utilizam o perfil `test` (configurado em `src/main/resources/application-test.properties`). Isso garante que eles não interfiram no seu banco de dados de desenvolvimento (`vollmed_db`).
- **Banco de Dados**: Certifique-se de que o MySQL esteja acessível em `localhost:3306` com as credenciais configuradas no projeto (ou ajuste o arquivo `application-test.properties` se necessário).
- **Mocks**: Muitos testes utilizam Mockito (`@MockBean`) para isolar as camadas de negócio e garantir que os testes sejam rápidos e independentes.
