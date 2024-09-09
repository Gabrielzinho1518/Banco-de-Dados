-- 1.1. Declara��o de Vari�veis
DECLARE @NomeProduto VARCHAR(50);
DECLARE @QuantidadeEstoque INT;
DECLARE @PrecoProduto DECIMAL(10,2);

-- 1.2. Atribui��o de Valores
SET @NomeProduto = 'Smartphone';
SET @QuantidadeEstoque = 30;
SET @PrecoProduto = 799.99;

-- 1.3. Exibi��o de Valores usando PRINT
PRINT 'Nome do Produto: ' + @NomeProduto;
PRINT 'Quantidade em Estoque: ' + CAST(@QuantidadeEstoque AS VARCHAR);
PRINT 'Pre�o do Produto: R$ ' + CAST(@PrecoProduto AS VARCHAR);

-- 1.3. Exibi��o de Valores usando SELECT
SELECT @NomeProduto AS NomeProduto, 
       @QuantidadeEstoque AS QuantidadeEstoque, 
       @PrecoProduto AS PrecoProduto;

-- 1.4. C�lculo utilizando Vari�veis
DECLARE @ValorUnitario DECIMAL(10,2);
DECLARE @Quantidade INT;
DECLARE @ValorTotal DECIMAL(10,2);

SET @ValorUnitario = @PrecoProduto;
SET @Quantidade = @QuantidadeEstoque;
SET @ValorTotal = @ValorUnitario * @Quantidade;

-- Exibi��o do Valor Total usando PRINT
PRINT 'Valor Total do Estoque: R$ ' + CAST(@ValorTotal AS VARCHAR);

-- Exibi��o do Valor Total usando SELECT
SELECT @ValorTotal AS ValorTotalEstoque;

-- EXERCICIO 2:

SELECT CAST(GETDATE() AS VARCHAR(10)) AS DataConvertida;

SELECT CONVERT(INT, 12345.67) AS NumeroInteiro;

DECLARE @NumeroDecimal DECIMAL(10,2);
DECLARE @NumeroInteiro INT;

-- Atribuindo valores
SET @NumeroDecimal = 1234.56;
SET @NumeroInteiro = 1234;

-- Convertendo decimal para inteiro usando CAST
SELECT CAST(@NumeroDecimal AS INT) AS DecimalParaInteiro;

-- Convertendo inteiro para decimal usando CONVERT
SELECT CONVERT(DECIMAL(10,2), @NumeroInteiro) AS InteiroParaDecimal;

DECLARE @DataNascimento VARCHAR(10);
SET @DataNascimento = '06/05/2003';

-- Convertendo para o tipo DATE utilizando CONVERT
SELECT CONVERT(DATE, @DataNascimento, 103) AS DataConvertida;

-- EXERCICIO 3:

DECLARE @Idade INT
SET @Idade = 20  -- Atribua um valor inteiro

IF @Idade >= 18
    PRINT 'Maior de Idade'
ELSE
    PRINT 'Menor de Idade'

	DECLARE @NotaFinal INT
SET @NotaFinal = 85  -- Atribua um valor entre 0 e 100

IF @NotaFinal >= 90
    PRINT 'Aprovado com Excel�ncia'
ELSE IF @NotaFinal >= 70 AND @NotaFinal < 90
    PRINT 'Aprovado'
ELSE IF @NotaFinal >= 50 AND @NotaFinal < 70
    PRINT 'Em Recupera��o'
ELSE
    PRINT 'Reprovado'

	DECLARE @Ano INT
SET @Ano = 2024  -- Atribua um valor para o ano

IF (@Ano % 4 = 0 AND @Ano % 100 != 0) OR @Ano % 400 = 0
    PRINT 'Ano Bissexto'
ELSE
    PRINT 'Ano Comum'

-- EXERCICIO 4:
DECLARE @Contador INT
SET @Contador = 1  -- Inicializa a vari�vel

WHILE @Contador <= 10
BEGIN
    PRINT @Contador  -- Exibe o valor da vari�vel
    SET @Contador = @Contador + 1  -- Incrementa o valor
END

DECLARE @Valor INT
SET @Valor = 100  -- Inicializa a vari�vel

WHILE @Valor >= 50
BEGIN
    PRINT @Valor  -- Exibe o valor da vari�vel
    SET @Valor = @Valor - 5  -- Subtrai 5 a cada itera��o
END

DECLARE @Indice INT, @PrecoLimite DECIMAL(10, 2)
SET @Indice = 1  -- Inicializa o �ndice
SET @PrecoLimite = 100  -- Define o limite de pre�o

WHILE @Indice <= (SELECT COUNT(*) FROM Produtos)  -- Continua at� o �ltimo produto
BEGIN
    DECLARE @PrecoAtual DECIMAL(10, 2), @NomeProduto NVARCHAR(100)
    
    -- Obt�m o pre�o e nome do produto com base no �ndice
    SELECT @PrecoAtual = Preco, @NomeProduto = Nome
    FROM Produtos
    WHERE ProdutoId = @Indice
    
    -- Verifica se o pre�o do produto � maior que 100
    IF @PrecoAtual > @PrecoLimite
    BEGIN
        PRINT @NomeProduto  -- Exibe o nome do produto
    END

    SET @Indice = @Indice + 1  -- Incrementa o �ndice
END

DECLARE @Numero INT
SET @Numero = 2  -- Inicializa a vari�vel

WHILE @Numero <= 1000
BEGIN
    PRINT @Numero  -- Exibe o valor atual
    SET @Numero = @Numero * 2  -- Dobra o valor a cada itera��o
END

-- EXERCICIO 5:
CREATE PROCEDURE CalcularDesconto
    @PrecoOriginal DECIMAL(10, 2),  -- Par�metro de entrada: pre�o original do produto
    @Quantidade INT,                -- Par�metro de entrada: quantidade comprada
    @PrecoFinal DECIMAL(10, 2) OUTPUT  -- Par�metro de sa�da: pre�o final com desconto
AS
BEGIN
    DECLARE @Desconto DECIMAL(10, 2)  -- Vari�vel para armazenar o valor do desconto
    SET @Desconto = 0  -- Inicializa o desconto em 0

    -- Condicional para verificar quantidade comprada
    IF @Quantidade > 10
    BEGIN
        SET @Desconto = 0.10  -- Aplica 10% de desconto se a quantidade for maior que 10
    END
    ELSE IF @Quantidade >= 5
    BEGIN
        SET @Desconto = 0  -- Nenhum desconto para quantidade entre 5 e 10
    END
    ELSE
    BEGIN
        DECLARE @Contador INT
        SET @Contador = 2  -- Come�a a contar a partir de 2 (porque 1 unidade n�o recebe desconto adicional)

        -- Loop para aplicar 1% de desconto adicional por unidade acima de 1
        WHILE @Contador <= @Quantidade
        BEGIN
            SET @Desconto = @Desconto + 0.01  -- Adiciona 1% de desconto
            SET @Contador = @Contador + 1  -- Incrementa o contador
        END
    END

    -- Calcula o pre�o final
    SET @PrecoFinal = @PrecoOriginal - (@PrecoOriginal * @Desconto)

    -- Exibe o pre�o final
    PRINT 'Pre�o Final com Desconto: ' + CAST(@PrecoFinal AS VARCHAR(10))
END

