CREATE OR REPLACE TRIGGER TRG_INC_UPD_TBJPRONT_BJ
BEFORE INSERT OR UPDATE ON AD_TBJPRONT FOR EACH ROW
DECLARE

BEGIN

    IF INSERTING OR UPDATING THEN

        /* INCLUI NOME DO COLABORADOR */
        SELECT 
        TRIM(LTRIM(TRANSLATE(FUN.NOMEFUNC, '1234567890', ' '), ' ')) NOMEFUNC
        INTO :NEW.NOMEFUNC FROM TFPFUN FUN WHERE CODEMP = :NEW.CODEMP AND CODFUNC = :NEW.CODFUNC;

        /* INCLUI CPF DO COLABORADOR */
        SELECT FUN.CPF INTO :NEW.CPF FROM TFPFUN FUN WHERE FUN.CODEMP = :NEW.CODEMP AND CODFUNC = :NEW.CODFUNC;

        /* INCLUI CARGO DO COLABORADOR */
        SELECT FUN.CODCARGO INTO :NEW.CODCARGO FROM TFPFUN FUN WHERE FUN.CODEMP = :NEW.CODEMP AND CODFUNC = :NEW.CODFUNC;

        IF :NEW.CPF != :OLD.CPF THEN

            RAISE_APPLICATION_ERROR(-20101, 'Não é permitido alterar funcionário, somente empresa contratante.');

        END IF;

        -- IF :NEW.CODCARGO != :OLD.CODCARGO THEN

        --     INSERT INTO AD_TBJPRONTALTCARG (CODCARGO)

        -- END IF;

    END IF;

END;
