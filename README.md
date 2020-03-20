# TesteDelphi
Teste de Delphi para a Softplan

Os aqruivos baixados pelo Download serão armazenados na pasta 'C:\Downloads\', portanto o sistema verifica se a pasta existe ele já baixa os arquivos para esta pasta, caso contrário ele vai criar a pasta e depois baixar os arquivos. 

Caso um arquivo com o mesmo nome já exista na pasta C:\Downloads\ o sistema vai apagar o arquivo existente e depois baixar o novo arquivo. 

A tabela utilizada já está incluída no projeto, porém segue abaixo o script utilizado para criação da tabela "LogDownload"

CREATE TABLE [LogDownload](
  [Codigo] NUMBER(22) PRIMARY KEY NOT NULL UNIQUE, 
  [URL] VARCHAR2(600) NOT NULL, 
  [DataInicio] DATE NOT NULL, 
  [DataFim] DATE);

CREATE INDEX [idxCodigo] ON [LogDownload]([Codigo]); 