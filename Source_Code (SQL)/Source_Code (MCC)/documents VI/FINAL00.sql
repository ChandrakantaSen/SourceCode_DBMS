SELECT  
        DEPO_DTLS.REGION,
        DEPO_DTLS.DEPO_CODE,
        DEPO_DTLS.DEPO_NAME,
        CUST_DTLS.CUST_ACCT_NO,
        CUST_DTLS.CUST_NAME,
        CUST_DTLS.BILL_TO,
        VOL_DTLS.INVOICE_NO,
        VOL_DTLS.INVOICE_DATE,
        VOL_DTLS.SKU,
        VOL_DTLS.DESCRIPTION,
        VOL_DTLS.VOLUME
FROM
-------------------------------------------------------------------------------------------------------------
(SELECT 
        SUBSTR(HAOU.ATTRIBUTE4,1,2)         REGION,
        SUBSTR(HAOU.NAME,1,3)               DEPO_CODE,
        SUBSTR(HAOU.NAME,5)                 DEPO_NAME,
        HAOU.ORGANIZATION_ID                ORG_ID                  

FROM    HR.HR_ALL_ORGANIZATION_UNITS        HAOU  

WHERE ATTRIBUTE1 = 'DEPOT'
  AND ATTRIBUTE4 IS NOT NULL)                                        DEPO_DTLS, --OK 
--------------------------------------------------------------------------------------------------------------
(SELECT 
        HCA.CUST_ACCOUNT_ID                 CUST_ID,
        HCA.ACCOUNT_NUMBER                  CUST_ACCT_NO,             --OK 
        HCA.ACCOUNT_NAME                    CUST_NAME,                --OK 
        HCSUA.WAREHOUSE_ID                  WID,
        HCSUA.CUST_ACCT_SITE_ID             BILL_TO 
FROM 
        AR.HZ_CUST_ACCOUNTS                 HCA,
        AR.HZ_CUST_ACCT_SITES_ALL           HCASA,
        AR.HZ_CUST_SITE_USES_ALL            HCSUA

WHERE
        HCA.CUST_ACCOUNT_ID = HCASA.CUST_ACCOUNT_ID
    AND HCASA.CUST_ACCT_SITE_ID = HCSUA.CUST_ACCT_SITE_ID
    AND HCSUA.SITE_USE_CODE = 'BILL_TO')                            CUST_DTLS,  --OK  
-----------------------------------------------------------------------------------------------------------------     
(SELECT   DISTINCT
          RCTA.TRX_NUMBER                               INVOICE_NO,
          RCTA.TRX_DATE                                 INVOICE_DATE,
          MSIB.SEGMENT1                                 SKU,
          MSIB.DESCRIPTION                              DESCRIPTION,
          RCTLA.QUANTITY_INVOICED                       VOLUME,
          RCTA.BILL_TO_SITE_USE_ID                      BILL_ID, 
          MSIB.ORGANIZATION_ID                          ORG_ID
FROM
          
          AR.RA_CUSTOMER_TRX_ALL        RCTA,
          AR.RA_CUSTOMER_TRX_LINES_ALL  RCTLA,
          INV.MTL_SYSTEM_ITEMS_B        MSIB
WHERE
          RCTA.CUSTOMER_TRX_ID = RCTLA.CUSTOMER_TRX_ID
     AND  RCTLA.INVENTORY_ITEM_ID = MSIB.INVENTORY_ITEM_ID                       -- OK 
     AND  MSIB.SEGMENT1 LIKE 'F%'                                                -- SKU starts with 'F' 
)                                                                    VOL_DTLS
-------------------------------------------------------------------------------------------------------------------
WHERE
          CUST_DTLS.WID    =  DEPO_DTLS.ORG_ID
    AND   VOL_DTLS.BILL_ID =  CUST_DTLS.BILL_TO
    AND   VOL_DTLS.ORG_ID  =  DEPO_DTLS.ORG_ID
    AND   VOL_DTLS.INVOICE_NO = '1'
ORDER BY  DEPO_DTLS.REGION
