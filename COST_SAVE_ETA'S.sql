/****** Script for SelectTopNRows command from SSMS  ******/
SELECT DISTINCT
		CONCAT(TRIM(E.CD_EQUIPMENT_OWNER), TRIM(E.[NO_CONVEYANCE])) AS CONTAINER
     --, A.CD_SHIP_FROM
	 --,A.CD_PLANT
	 --, E.CD_ACT_RECEIVE_LOC
	 -- ,D.REGION
	  --,E.DT_SHIPPED
	  ,E.DT_EXPECTED_ARRVL
	  --,concat(trim(P.no_part_prefix),trim(P.no_part_base),trim(P.no_part_suffix),trim(P.no_part_control)) as part
  FROM DPE_FORD_CRCT001_ASN A
  JOIN DPE_FORD_CRCT002_ASN_PART P
  ON A.CD_PLANT = P.CD_PLANT
  AND A.NO_CONVEYANCE = P.NO_CONVEYANCE
  AND A.CD_DUP_CONVEYANCE = P.CD_DUP_CONVEYANCE
  AND A.NO_ASN = P.NO_ASN

  JOIN DPE_FORD_CRCT004_CONVYNCE E
  ON A.CD_PLANT = E.CD_PLANT
  AND A.NO_CONVEYANCE = E.NO_CONVEYANCE
  AND A.NO_BILL_OF_LADING = E.NO_BILL_OF_LADING
  
  
  
  JOIN DPE_FORD_CUCT001_COMP_LOC C
  ON P.CD_SHIP_FROM = C.CD_COMP_LOC
  
  JOIN LLP_FORD_Country_Region D
  ON C.CD_COUNTRY = D.COUNTRYCODE
  
  WHERE 
  --E.DT_SHIPPED LIKE '2023-10%'
  --AND
   E.[CD_MODE_TRANSPRTN] LIKE '%O%'
  AND c.cd_country <> '92'
  AND c.cd_country <> '94'
  AND c.cd_country <> '95'
  AND D.region IN ('AP', 'AF')
  --AND E.NO_CONVEYANCE LIKE '%4330307%'
  AND A.CD_SHIP_FROM IN ('DZDQA', 'GKZJE', 'GPZFA', 'C232M', 'CGPBA')
  AND E.DT_EXPECTED_ARRVL > '2023-12-11'
  AND E.CD_ACT_RECEIVE_LOC = 'AL3DC'
  AND concat(trim(P.no_part_prefix),trim(P.no_part_base),trim(P.no_part_suffix),trim(P.no_part_control)) IN ('NL1T18B955FE', 'FT4E6B280EC', 'FT4E6B281EC', 'MB3B5H258AB', 'N1WT19J254EC', 'N1WT19J289HE', 'MB3B5M211AC', 'LB5T19A390AA', 'KT4T19K351AC', 'MR3T19K351AA', 'JL7T19K351AB', 'NB3V5H258AA', 'NB3V5M211AA', 'JR3T19K351DC', 'PR3T19K351AA', 'LC5T19A390AB', 'NC4T19C175AB')