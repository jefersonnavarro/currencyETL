SELECT
   x.CcyNtry.query('CtryNm').value('.', 'VARCHAR(58)') as icPais,
   x.CcyNtry.query('CcyNm').value('.', 'VARCHAR(65)') as noMoeda,
   x.CcyNtry.query('Ccy').value('.', 'CHAR(3)') as coAlfabeticoMoeda,
   x.CcyNtry.query('CcyNbr').value('.', 'CHAR(3)') as coNumericoMoeda,
   x.CcyNtry.query('CcyMnrUnts').value('.', 'VARCHAR(4)') as qtCasasDecimais
into coMoedas
FROM (

	SELECT
        CAST(x AS xml)
    FROM OPENROWSET(BULK 'c:\etl\currencyCodes\list_one.xml', SINGLE_BLOB) AS T(x)

) AS T(x)
CROSS APPLY x.nodes('ISO_4217/CcyTbl/CcyNtry') AS x (CcyNtry);

