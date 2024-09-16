CREATE PROCEDURE RetornaIdadeFuncionario
    @CPF VARCHAR(11)
AS
BEGIN
    DECLARE @DataNascimento DATE;
    DECLARE @Idade INT;

    -- Obtém a data de nascimento com base no CPF fornecido
    SELECT @DataNascimento = DataNascimento
    FROM Funcionarios
    WHERE CPF = @CPF;

    -- Calcula a idade com base na data de nascimento
    IF @DataNascimento IS NOT NULL
    BEGIN
        SET @Idade = DATEDIFF(YEAR, @DataNascimento, GETDATE());

        -- Ajusta a idade caso a data de aniversário ainda não tenha ocorrido este ano
        IF (MONTH(@DataNascimento) > MONTH(GETDATE())) OR
           (MONTH(@DataNascimento) = MONTH(GETDATE()) AND DAY(@DataNascimento) > DAY(GETDATE()))
        BEGIN
            SET @Idade = @Idade - 1;
        END;

        -- Retorna a idade
        SELECT @Idade AS Idade;
    END
    ELSE
    BEGIN
        -- Caso o CPF não seja encontrado
        PRINT 'CPF não encontrado.';
    END
END;
