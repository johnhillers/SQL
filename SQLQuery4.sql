SELECT
      S.SHIPMENT_GID
	, R.SHIPMENT_REFNUM_VALUE AS "BOL"
	, LD.SHIPMENT_REFNUM_VALUE AS "PORT_OF_LOADING"
	, DIS.SHIPMENT_REFNUM_VALUE AS "PORT_OF_DISCHARGE"
	, RCP.SHIPMENT_REFNUM_VALUE AS "PLACE_OF_RECEIPT"
	, DLV.SHIPMENT_REFNUM_VALUE AS "PLACE_OF_DELIVERY"
	, SSLP.INVOLVED_PARTY_CONTACT_GID AS "SSL_PICKUP"
	, SSLD.INVOLVED_PARTY_CONTACT_GID AS "SSL_DROPOFF"
    , ST.ACTUAL_ARRIVAL AS "END_TIME"
FROM [GLOGOWNERNA04PRD].[SHIPMENT_REFNUM_T] R
JOIN [GLOGOWNERNA04PRD].[SHIPMENT_T] S
ON R.SHIPMENT_GID = S.SHIPMENT_GID
AND R.SHIPMENT_REFNUM_QUAL_GID = 'ILS.BILL_OF_LADING_NUMBER'
AND S.TRANSPORT_MODE_GID LIKE '%ILS.OCEAN%' 
LEFT JOIN [GLOGOWNERNA04PRD].[SHIPMENT_S_EQUIPMENT_JOIN_T] A
ON R.SHIPMENT_GID = A.SHIPMENT_GID
LEFT JOIN [GLOGOWNERNA04PRD].[SHIPMENT_REFNUM_T] DIS
ON R.SHIPMENT_GID = DIS.SHIPMENT_GID
AND DIS.SHIPMENT_REFNUM_QUAL_GID LIKE '%PORT_OF_DISCHARGE%'
LEFT JOIN [GLOGOWNERNA04PRD].[SHIPMENT_REFNUM_T] LD
ON R.SHIPMENT_GID = LD.SHIPMENT_GID
AND LD.SHIPMENT_REFNUM_QUAL_GID LIKE '%PORT_OF_LOADING%'
LEFT JOIN [GLOGOWNERNA04PRD].[SHIPMENT_REFNUM_T] RCP
ON S.SHIPMENT_GID = RCP.SHIPMENT_GID
AND RCP.SHIPMENT_REFNUM_QUAL_GID LIKE '%PLACE_OF_RECEIPT%'
LEFT JOIN [GLOGOWNERNA04PRD].[SHIPMENT_REFNUM_T] DLV
ON S.SHIPMENT_GID = DLV.SHIPMENT_GID
AND DLV.SHIPMENT_REFNUM_QUAL_GID LIKE '%PLACE_OF_DELIVERY%'
LEFT JOIN [GLOGOWNERNA04PRD].[SHIPMENT_INVOLVED_PARTY_T] SSLP
ON S.SHIPMENT_GID = SSLP.SHIPMENT_GID
AND SSLP.INVOLVED_PARTY_QUAL_GID LIKE 'ILS.SSL_PICKUP'
LEFT JOIN [GLOGOWNERNA04PRD].[SHIPMENT_INVOLVED_PARTY_T] SSLD
ON S.SHIPMENT_GID = SSLD.SHIPMENT_GID
AND SSLD.INVOLVED_PARTY_QUAL_GID LIKE 'ILS.SSL_DROPOFF'
JOIN GLOGOWNERNA04PRD.SHIPMENT_STOP_T ST
ON S.SHIPMENT_GID = ST.SHIPMENT_GID
    AND ST.STOP_NUM = '2'
WHERE SUBSTRING(S.DEST_LOCATION_GID, 6, 2) in ('US', 'MX', 'CA')
AND RCP.SHIPMENT_REFNUM_VALUE IS NULL