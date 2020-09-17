select
   x.CcyNtry.query('CtryNm').value('.', 'VARCHAR(42)') as icPais,
   x.CcyNtry.query('CcyNm').value('.', 'VARCHAR(40)') as noMoeda,
   x.CcyNtry.query('Ccy').value('.', 'CHAR(3)') as coAlfabeticoMoeda,
   x.CcyNtry.query('CcyNbr').value('.', 'CHAR(3)') as coNumericoMoeda,
   x.CcyNtry.query('WthdrwlDt').value('.', 'VARCHAR(18)') as validade
into coMoedasHistorico
FROM (

	SELECT
        CAST(x AS xml)
    FROM OPENROWSET(BULK 'c:\etl\currencyCodes\list_three.xml', SINGLE_BLOB) AS T(x)

) AS T(x)
CROSS APPLY x.nodes('ISO_4217/HstrcCcyTbl/HstrcCcyNtry') AS x (CcyNtry);

