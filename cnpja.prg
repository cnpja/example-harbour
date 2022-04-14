PROCEDURE Main(cCNPJA)
// Escolha o CNPJ a ser pesquisado
IF EMPTY(cCNPJA)
   cCNPJA="33000167000101"
ENDIF
CLS
// Coloque aqui sua Chave de API
CHAVEAPI="b031b946-a23e-4e09-84e9-ffaeb0329393-1a474681-82b1-44b7-a193-4a5a39b562a8"

// Cria um objeto para requisicao HTTP
? "Buscando CNPJ " + cCNPJA + "..."
http := CreateObject("MSXML2.ServerXMLHTTP")
http:Open("GET", "https://api.cnpja.com/office/" + cCNPJA, .F.)

// Adiciona sua Chave de API nos headers
http:SetRequestHeader("Authorization", CHAVEAPI)

// Envia e imprime a resposta
http:send()

// DEFINE VARIµVEL DO TIPO HASH VAZIA
hCNPJA := HASH()

// RESOLVE ACENTUA€ÇO GRµFICA DA LINGUA PORTUGUESA
JSONCNPJ := HB_AnsiToOem(http:responseText)

// DECODIFICA JSON
// hb_jsondecode( response, @hCNPJA )
hCNPJA := JSontoHash(JSONCNPJ)

? "DADOS DA EMPRESA"
? "CNPJ: "+TRANSFORM(cCNPJA, "@R 99.999.999/9999-99")
? "NOME: "+hCNPJA["company"]["name"]
? "Endere‡o: "+ hCNPJA["address"]["street"]+", "+hCNPJA["address"]["number"]
? "Complemento: "+IIF(!EMPTY(hCNPJA["address"]["details"]), hCNPJA["address"]["details"], "")
? "Bairro: "+ hCNPJA["address"]["district"]
? "Cidade: "+ hCNPJA["address"]["city"]
? "UF: "+ hCNPJA["address"]["state"]
? "CEP: "+TRANSFORM(hCNPJA["address"]["zip"], "@R 99999-999")
?
? "CONTATOS"
nTELS := LEN(hCNPJA["phones"])
FOR X=1 TO nTELS
	cTEL := hCNPJA["phones"][X]["area"] + hCNPJA["phones"][X]["number"]
	IF LEN(cTEL)=10
		cTEL := TRANSFORM(cTEL, "@R (99) 9999-9999")
	ELSE
		cTEL := TRANSFORM(cTEL, "@R (99) 99999-9999")
	ENDIF
	? cTEL
NEXT X

nEMAILS := LEN(hCNPJA["emails"])
FOR X=1 TO nEMAILS
	? "Email: "+hCNPJA["emails"][X]["address"]
NEXT	

Function JSontoHash( cStringJson )
/***
* Converte string formato Json em Hash
*/
Local hJson := {=>}
cStringJson := StrTran( cStringJson,':[','=>{')
cStringJson := StrTran( cStringJson,'":"','" => "')
cStringJson := StrTran( cStringJson,'[','{')
cStringJson := StrTran( cStringJson,']','}')
cStringJson := StrTran( cStringJson,'":null','"=>nil')
cStringJson := StrTran( cStringJson,'":true' ,'"=>.t.' )
cStringJson := StrTran( cStringJson,'":false','"=>.f.')
cStringJson := StrTran( cStringJson,'":','"=>')
cStringJson := StrTran( cStringJson,"\/","/" )
hJSon := &( cStringJson )
Return hJson



/*
Hash completo:
(Se precisar de mais alguma informação daqui é só seguir o exemplo lá em cima)
{"updated":"2022-04-13T13:55:05Z","taxId":"33000167000101","alias":"PETROBRAS - EDISE","founded":"1966-09-28","head":true,
"company":{"id":33000167,"name":"PETROLEO BRASILEIRO S A PETROBRAS",
	"jurisdiction":"Uniao",
	"equity":205431960490.52,
"nature":{"id":2038,"text":"Sociedade de Economia Mista"},
	"size":{"id":5,"acronym":"DEMAIS","text":"Demais"},
	"members":[{"since":"2021-04-22",
"person":{"id":"15401349-187c-4277-b58f-80582031ea89",
	"name":"Salvador Dahan",
	"type":"NATURAL",
	"taxId":"***672828**",
	"age":"41-50"},
	"role":{"id":10,"text":"Diretor"}},
	{"since":"2021-05-10",
"person":{"id":"202833c8-2b47-4da5-89c6-04d46b4f84e9",
	"name":"Claudio Rogerio Linassi Mastella",
	"type":"NATURAL","taxId":"***834870**",
	"age":"51-60"},
	"role":{"id":10,"text":"Diretor"}},
	{"since":"2021-05-10",
"person":{"id":"47c730b0-0328-4f7e-b313-86a91246cc68","name":"Fernando Assumpcao Borges","type":"NATURAL","taxId":"***382706**","age":"61-70"},"role":{"id":10,"text":"Diretor"}},{"since":"2021-05-10",
"person":{"id":"87cde6b6-d09f-49dc-886d-018ac2d2bca7","name":"Joao Henrique Rittershaussen","type":"NATURAL","taxId":"***522316**","age":"51-60"},"role":{"id":10,"text":"Diretor"}},{"since":"2021-05-10",
"person":{"id":"8d842fd9-9621-46db-ba91-9d4d30075784","name":"Rodrigo Costa Lima e Silva","type":"NATURAL","taxId":"***807425**","age":"41-50"},"role":{"id":10,"text":"Diretor"}},{"since":"2021-12-14",
"person":{"id":"a0b8db2b-3f3a-45e8-90fe-3e288608f6e9","name":"Rafael Chaves Santos","type":"NATURAL","taxId":"***445330**","age":"41-50"},"role":{"id":10,"text":"Diretor"}},{"since":"2021-05-10",
"person":{"id":"ad4ce3e1-3372-4e58-a7a0-ebde5f087566","name":"Rodrigo Araujo Alves","type":"NATURAL","taxId":"***100396**","age":"31-40"},"role":{"id":10,"text":"Diretor"}},{"since":"2021-05-13",
"person":{"id":"b9ec6bf7-9220-4dcb-81b8-629bc50c8b63","name":"Joaquim Silva e Luna","type":"NATURAL","taxId":"***864767**","age":"71-80"},"role":{"id":16,"text":"Presidente"}},{"since":"2019-10-23",
"person":{"id":"e105ed7c-4563-4989-bb9c-c4bd6c8be0c8","name":"Nicolas Simone","type":"NATURAL","taxId":"***136328**","age":"41-50"},"role":{"id":10,"text":"Diretor"}}]},"statusDate":"2005-11-03",
"status":{"id":2,"text":"Ativa"},
"address":{"municipality":3304557,
	"street":"Avenida Republica do Chile",
	"number":"65",
	"details":null,
	"district":"Centro",
	"city":"Rio de Janeiro",
	"state":"RJ",
	"zip":"20031170",
	"country":{"id":76,"name":"Brasil"}},
"phones":[{"area":"21","number":"32248091"},
	  {"area":"21","number":"32244477"}],
"emails":[{"address":"atendimentofiscossco@petrobras.com.br",
"domain":"petrobras.com.br"}],
"mainActivity":{"id":1921700,"text":"Fabrica‡Æo de produtos do refino de petr¢leo"},
"sideActivities":[{"id":600001,"text":"Extra‡Æo de petr¢leo e g s natural"},
{"id":3520401,"text":"Produ‡Æo de g s; processamento de g s natural"},
{"id":4681801,"text":"Com‚rcio atacadista de  lcool carburante, biodiesel, gasolina e demais derivados de petr¢leo, exceto lubrificantes, nÆo realizado por transportador re"}]}
*/
