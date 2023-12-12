SELECT DISTINCT
      REPLACE(S.SHIPMENT_GID, 'ILS.', '') AS SHIPMENT_GID
	  , R.SHIPMENT_REFNUM_VALUE AS CASS_SENT_DATE
    , ST.ACTUAL_ARRIVAL
    , REPLACE(SSLP.INVOLVED_PARTY_CONTACT_GID, 'FORD.', '') AS "PLACE_OF_RECEIPT"
	, REPLACE(SSLD.INVOLVED_PARTY_CONTACT_GID, 'FORD.', '') AS "PLACE_OF_DELIVERY"
FROM [GLOGOWNERNA04PRD].[SHIPMENT_T] S
LEFT JOIN [GLOGOWNERNA04PRD].[SHIPMENT_REFNUM_T] R
    ON S.SHIPMENT_GID = R.SHIPMENT_GID
    AND R.SHIPMENT_REFNUM_QUAL_GID = 'ILS.CASS_SENT_DATE' 
JOIN [GLOGOWNERNA04PRD].[SHIPMENT_REFNUM_T] R2
	ON S.SHIPMENT_GID = R2.SHIPMENT_GID
	AND S.TRANSPORT_MODE_GID LIKE '%ILS.OCEAN%'
JOIN [GLOGOWNERNA04PRD].[SHIPMENT_STOP_T] ST
    ON S.SHIPMENT_GID = ST.SHIPMENT_GID
    AND ST.STOP_NUM = '2'
JOIN [GLOGOWNERNA04PRD].[SHIPMENT_REFNUM_T] R1
ON S.SHIPMENT_GID = R1.SHIPMENT_GID
AND R1.SHIPMENT_REFNUM_QUAL_GID = 'ILS.COR'
AND R1.SHIPMENT_REFNUM_VALUE = 'FMAPNA'
LEFT JOIN [GLOGOWNERNA04PRD].[SHIPMENT_INVOLVED_PARTY_T] SSLP
ON S.SHIPMENT_GID = SSLP.SHIPMENT_GID
AND SSLP.INVOLVED_PARTY_QUAL_GID LIKE 'ILS.SSL_PICKUP'
LEFT JOIN [GLOGOWNERNA04PRD].[SHIPMENT_INVOLVED_PARTY_T] SSLD
ON S.SHIPMENT_GID = SSLD.SHIPMENT_GID
AND SSLD.INVOLVED_PARTY_QUAL_GID LIKE 'ILS.SSL_DROPOFF'
WHERE SUBSTRING(S.DEST_LOCATION_GID, 6, 2) IN ('US', 'MX', 'CA')
	AND S.DOMAIN_NAME = 'ILS'
    AND YEAR(ST.ACTUAL_ARRIVAL) IN (2023, 2022)
	AND R.SHIPMENT_REFNUM_QUAL_GID IS NULL;