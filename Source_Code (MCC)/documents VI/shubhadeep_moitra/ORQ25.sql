SELECT NVL(KL.REGION,CD.REGION)  REGION,
       NVL(KL.DEPO_NAME,CD.DEPO_NAME) DEPO_NAME,
      NVL(KL.CUST_ACC_NO,CD.CUST_ACC_NO) CUST_ACC_NO,
      NVL(KL.CUST_NAME,CD.CUST_NAME) CUST_NAME,
       NVL(CD.LY_VAL,0)  LY_VAL,
       NVL(CD.TY_VAL,0)  TY_VAL,
       NVL(KL.LY_VAL,0)  LY_VAL_42,
       NVL(KL.TY_VAL,0)  TY_VAL_42
FROM
       (SELECT AB.REGION  REGION,
                AB.DEPO_NAME DEPO_NAME,
                AB.CUST_ACC_NO CUST_ACC_NO,
                AB.CUST_NAME CUST_NAME,
                AB.LY_VAL    LY_VAL,
                GH.LY_VAL  TY_VAL
                FROM
                (SELECT
                            CUST_DTLS.REGION        REGION,
                            CUST_DTLS.DEPO_NAME     DEPO_NAME,
                            CUST_DTLS.CUST_ACC_NO   CUST_ACC_NO,
                            CUST_DTLS.CUST_NAME     CUST_NAME,
                            SUM(VOL_DTLS.VAL)   LY_VAL
                            FROM
                           (SELECT 
                                     SUBSTR(HAOU.ATTRIBUTE4,1,2) REGION, 
                                     SUBSTR(HAOU.NAME,5,LENGTH(HAOU.NAME)) DEPO_NAME,
                                     TO_NUMBER(RT.SEGMENT4)     TERR_CODE,
                                     HCA.ACCOUNT_NUMBER  CUST_ACC_NO,
                                     HCSUA.SITE_USE_ID    BILL_ID,
                                     HCA.ACCOUNT_NAME     CUST_NAME
                                     FROM
                                     AR.HZ_CUST_ACCOUNTS                    HCA,
                                     AR.HZ_CUST_ACCT_SITES_ALL     HCASA,
                                     AR.HZ_CUST_SITE_USES_ALL      HCSUA,
                                     HR.HR_ALL_ORGANIZATION_UNITS  HAOU,
                                     AR.RA_TERRITORIES             RT
                                     WHERE
                                     HCA.CUST_ACCOUNT_ID=HCASA.CUST_ACCOUNT_ID
                                     AND  HCASA.CUST_ACCT_SITE_ID=HCSUA.CUST_ACCT_SITE_ID
                                     AND  HCSUA.WAREHOUSE_ID=HAOU.ORGANIZATION_ID
                                     AND  HCSUA.TERRITORY_ID=RT.TERRITORY_ID
                                     AND  HCSUA.SITE_USE_CODE='BILL_TO'
                                     AND  HAOU.ATTRIBUTE1='DEPOT') CUST_DTLS,
                           (SELECT   RCTLA.INVENTORY_ITEM_ID         INV_ID, 
                                     RCTA.TRX_NUMBER                 TRX_NUMBER,
                                     RCTA.TRX_DATE                   TRX_DATE,
                                     RCTA.BILL_TO_SITE_USE_ID        BILL_ID,
                                     RCTLA.DESCRIPTION               DESCRIPTION1,
                                     RCTLA.EXTENDED_AMOUNT           VAL,
                                     MSIB.SEGMENT1             SKU
                                     FROM
                                     AR.RA_CUSTOMER_TRX_LINES_ALL    RCTLA,
                                     AR.RA_CUSTOMER_TRX_ALL          RCTA,
                                     AR.RA_CUST_TRX_TYPES_ALL        RCTTA,
                                    (
                                                      SELECT MSIB.INVENTORY_ITEM_ID
                                                     ,MSIB.SEGMENT1
                                                     ,MSIB.DESCRIPTION
                                                      FROM INV.MTL_SYSTEM_ITEMS_B     MSIB
                                                      WHERE MSIB.ORGANIZATION_ID =83
                                                      AND MSIB.SEGMENT1 NOT LIKE '%BULK%'
                                                      AND MSIB.INVENTORY_ITEM_STATUS_CODE = 'Active'
                                                      AND SUBSTR(MSIB.SEGMENT1,1,6) IN ('F00000')
                                    ) MSIB
                           WHERE    RCTA.CUSTOMER_TRX_ID=RCTLA.CUSTOMER_TRX_ID
                                    AND RCTA.CUST_TRX_TYPE_ID=RCTTA.CUST_TRX_TYPE_ID
                                    AND MSIB.INVENTORY_ITEM_ID=RCTLA.INVENTORY_ITEM_ID
                                    AND RCTLA.DESCRIPTION NOT LIKE '%B99%'
                                    AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'YYYYMM')) = 201402
                                    AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'DD')) <= 28
                                    AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'DD')) >=01
                                    AND (RCTTA.NAME LIKE '%_INVOICE'
                                    OR  RCTTA.NAME LIKE '%_CN') ) VOL_DTLS
                WHERE CUST_DTLS.BILL_ID=VOL_DTLS.BILL_ID
                GROUP BY
                CUST_DTLS.REGION,
                CUST_DTLS.DEPO_NAME,
                CUST_DTLS.CUST_ACC_NO,
                CUST_DTLS.CUST_NAME
                ORDER BY 1,2,3,4) AB,
                (SELECT
                            CUST_DTLS.REGION        REGION,
                            CUST_DTLS.DEPO_NAME     DEPO_NAME,
                            CUST_DTLS.CUST_ACC_NO   CUST_ACC_NO,
                            CUST_DTLS.CUST_NAME     CUST_NAME,
                            SUM(VOL_DTLS1.VAL)   LY_VAL
                            FROM
                                        (SELECT 
                                                        SUBSTR(HAOU.ATTRIBUTE4,1,2) REGION, 
                                                        SUBSTR(HAOU.NAME,5,LENGTH(HAOU.NAME)) DEPO_NAME,
                                                        TO_NUMBER(RT.SEGMENT4)     TERR_CODE,
                                                        HCA.ACCOUNT_NUMBER  CUST_ACC_NO,
                                                        HCSUA.SITE_USE_ID    BILL_ID,
                                                        HCA.ACCOUNT_NAME     CUST_NAME
                                                        FROM
                                                        AR.HZ_CUST_ACCOUNTS                    HCA,
                                                        AR.HZ_CUST_ACCT_SITES_ALL     HCASA,
                                                        AR.HZ_CUST_SITE_USES_ALL      HCSUA,
                                                        HR.HR_ALL_ORGANIZATION_UNITS  HAOU,
                                                        AR.RA_TERRITORIES             RT
                                                        WHERE
                                                        HCA.CUST_ACCOUNT_ID=HCASA.CUST_ACCOUNT_ID
                                                        AND  HCASA.CUST_ACCT_SITE_ID=HCSUA.CUST_ACCT_SITE_ID
                                                        AND  HCSUA.WAREHOUSE_ID=HAOU.ORGANIZATION_ID
                                                        AND  HCSUA.TERRITORY_ID=RT.TERRITORY_ID
                                                        AND  HCSUA.SITE_USE_CODE='BILL_TO'
                                                        AND  HAOU.ATTRIBUTE1='DEPOT') CUST_DTLS,
                                           (SELECT
                                                        RCTLA.INVENTORY_ITEM_ID         INV_ID, 
                                                        RCTA.TRX_NUMBER                 TRX_NUMBER,
                                                        RCTA.TRX_DATE                   TRX_DATE,
                                                        RCTA.BILL_TO_SITE_USE_ID        BILL_ID,
                                                        RCTLA.DESCRIPTION               DESCRIPTION1,
                                                        RCTLA.EXTENDED_AMOUNT           VAL,
                                                        MSIB.SEGMENT1             SKU
                                                        FROM
                                                        AR.RA_CUSTOMER_TRX_LINES_ALL    RCTLA,
                                                        AR.RA_CUSTOMER_TRX_ALL          RCTA,
                                                        AR.RA_CUST_TRX_TYPES_ALL        RCTTA,
                                                        (
                                                                SELECT MSIB.INVENTORY_ITEM_ID
                                                                ,MSIB.SEGMENT1
                                                                ,MSIB.DESCRIPTION
                                                                FROM INV.MTL_SYSTEM_ITEMS_B     MSIB
                                                                WHERE MSIB.ORGANIZATION_ID =83
                                                                AND MSIB.SEGMENT1 NOT LIKE '%BULK%'
                                                                AND MSIB.INVENTORY_ITEM_STATUS_CODE = 'Active'
                                                                AND SUBSTR(MSIB.SEGMENT1,1,6) IN ('F00000')
                                                         ) MSIB
                                                         WHERE    RCTA.CUSTOMER_TRX_ID=RCTLA.CUSTOMER_TRX_ID
                                                         AND RCTA.CUST_TRX_TYPE_ID=RCTTA.CUST_TRX_TYPE_ID
                                                         AND MSIB.INVENTORY_ITEM_ID=RCTLA.INVENTORY_ITEM_ID
                                                         AND RCTLA.DESCRIPTION NOT LIKE '%B99%'
                                                         AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'YYYYMM')) = 201403
                                                         AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'DD')) <= 31
                                                         AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'DD')) >=01
                                                         AND (RCTTA.NAME LIKE '%_INVOICE'
                                                         OR  RCTTA.NAME LIKE '%_CN') ) VOL_DTLS1
                 WHERE CUST_DTLS.BILL_ID=VOL_DTLS1.BILL_ID
                GROUP BY
                CUST_DTLS.REGION,
                CUST_DTLS.DEPO_NAME,
                CUST_DTLS.CUST_ACC_NO,
                CUST_DTLS.CUST_NAME
                ORDER BY 1,2,3,4) GH  
        WHERE AB.REGION=GH.REGION
        AND AB.DEPO_NAME=GH.DEPO_NAME
        AND AB.CUST_ACC_NO=GH.CUST_ACC_NO
        AND AB.CUST_NAME=GH.CUST_NAME) CD FULL OUTER JOIN
        (SELECT AB.REGION  REGION,
                AB.DEPO_NAME DEPO_NAME,
                AB.CUST_ACC_NO CUST_ACC_NO,
                AB.CUST_NAME CUST_NAME,
                AB.LY_VAL    LY_VAL,
                GH.LY_VAL  TY_VAL
                FROM
               (SELECT
                            CUST_DTLS.REGION        REGION,
                            CUST_DTLS.DEPO_NAME     DEPO_NAME,
                            CUST_DTLS.CUST_ACC_NO   CUST_ACC_NO,
                            CUST_DTLS.CUST_NAME     CUST_NAME,
                            SUM(VOL_DTLS.VAL)   LY_VAL
                            FROM
                            (SELECT 
                                        SUBSTR(HAOU.ATTRIBUTE4,1,2) REGION, 
                                        SUBSTR(HAOU.NAME,5,LENGTH(HAOU.NAME)) DEPO_NAME,
                                        TO_NUMBER(RT.SEGMENT4)     TERR_CODE,
                                        HCA.ACCOUNT_NUMBER  CUST_ACC_NO,
                                        HCSUA.SITE_USE_ID    BILL_ID,
                                        HCA.ACCOUNT_NAME     CUST_NAME
                                        FROM
                                        AR.HZ_CUST_ACCOUNTS                    HCA,
                                        AR.HZ_CUST_ACCT_SITES_ALL     HCASA,
                                        AR.HZ_CUST_SITE_USES_ALL      HCSUA,
                                        HR.HR_ALL_ORGANIZATION_UNITS  HAOU,
                                        AR.RA_TERRITORIES             RT
                                        WHERE
                                        HCA.CUST_ACCOUNT_ID=HCASA.CUST_ACCOUNT_ID
                                        AND  HCASA.CUST_ACCT_SITE_ID=HCSUA.CUST_ACCT_SITE_ID
                                        AND  HCSUA.WAREHOUSE_ID=HAOU.ORGANIZATION_ID
                                        AND  HCSUA.TERRITORY_ID=RT.TERRITORY_ID
                                        AND  HCSUA.SITE_USE_CODE='BILL_TO'
                                        AND  HAOU.ATTRIBUTE1='DEPOT') CUST_DTLS,
                                        (SELECT  
                                                  RCTLA.INVENTORY_ITEM_ID         INV_ID, 
                                                  RCTA.TRX_NUMBER                 TRX_NUMBER,
                                                  RCTA.TRX_DATE                   TRX_DATE,
                                                  RCTA.BILL_TO_SITE_USE_ID        BILL_ID,
                                                  RCTLA.DESCRIPTION               DESCRIPTION1,
                                                  RCTLA.EXTENDED_AMOUNT           VAL,
                                                  MSIB.SEGMENT1             SKU
                                                  FROM
                                                  AR.RA_CUSTOMER_TRX_LINES_ALL    RCTLA,
                                                  AR.RA_CUSTOMER_TRX_ALL          RCTA,
                                                  AR.RA_CUST_TRX_TYPES_ALL        RCTTA,
                                                  (
                                                                    SELECT MSIB.INVENTORY_ITEM_ID
                                                                    ,MSIB.SEGMENT1
                                                                    ,MSIB.DESCRIPTION
                                                                    FROM INV.MTL_SYSTEM_ITEMS_B     MSIB
                                                                    WHERE MSIB.ORGANIZATION_ID =83
                                                                    AND MSIB.SEGMENT1 NOT LIKE '%BULK%'
                                                                    AND MSIB.INVENTORY_ITEM_STATUS_CODE = 'Active'
                                                                    AND SUBSTR(MSIB.SEGMENT1,1,6) IN ('F00042')
                                                  ) MSIB
                                                  WHERE    RCTA.CUSTOMER_TRX_ID=RCTLA.CUSTOMER_TRX_ID
                                                  AND RCTA.CUST_TRX_TYPE_ID=RCTTA.CUST_TRX_TYPE_ID
                                                  AND MSIB.INVENTORY_ITEM_ID=RCTLA.INVENTORY_ITEM_ID
                                                  AND RCTLA.DESCRIPTION NOT LIKE '%B99%'
                                                  AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'YYYYMM')) = 201402
                                                  AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'DD')) <= 28
                                                  AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'DD')) >=01
                                                  AND (RCTTA.NAME LIKE '%_INVOICE'
                                                  OR  RCTTA.NAME LIKE '%_CN') ) VOL_DTLS
                 WHERE CUST_DTLS.BILL_ID=VOL_DTLS.BILL_ID
                 GROUP BY
                 CUST_DTLS.REGION,
                 CUST_DTLS.DEPO_NAME,
                 CUST_DTLS.CUST_ACC_NO,
                 CUST_DTLS.CUST_NAME
                 ORDER BY 1,2,3,4) AB,
                (SELECT
                              CUST_DTLS.REGION        REGION,
                              CUST_DTLS.DEPO_NAME     DEPO_NAME,
                              CUST_DTLS.CUST_ACC_NO   CUST_ACC_NO,
                              CUST_DTLS.CUST_NAME     CUST_NAME,
                              SUM(VOL_DTLS1.VAL)   LY_VAL
                              FROM
                             (SELECT 
                                                SUBSTR(HAOU.ATTRIBUTE4,1,2) REGION, 
                                                SUBSTR(HAOU.NAME,5,LENGTH(HAOU.NAME)) DEPO_NAME,
                                                TO_NUMBER(RT.SEGMENT4)     TERR_CODE,
                                                HCA.ACCOUNT_NUMBER  CUST_ACC_NO,
                                                HCSUA.SITE_USE_ID    BILL_ID,
                                                HCA.ACCOUNT_NAME     CUST_NAME
                                                FROM
                                                AR.HZ_CUST_ACCOUNTS                    HCA,
                                                AR.HZ_CUST_ACCT_SITES_ALL     HCASA,
                                                AR.HZ_CUST_SITE_USES_ALL      HCSUA,
                                                HR.HR_ALL_ORGANIZATION_UNITS  HAOU,
                                                AR.RA_TERRITORIES             RT
                                                WHERE
                                                HCA.CUST_ACCOUNT_ID=HCASA.CUST_ACCOUNT_ID
                                                AND  HCASA.CUST_ACCT_SITE_ID=HCSUA.CUST_ACCT_SITE_ID
                                                AND  HCSUA.WAREHOUSE_ID=HAOU.ORGANIZATION_ID
                                                AND  HCSUA.TERRITORY_ID=RT.TERRITORY_ID
                                                AND  HCSUA.SITE_USE_CODE='BILL_TO'
                                                AND  HAOU.ATTRIBUTE1='DEPOT') CUST_DTLS,
                                               (SELECT   RCTLA.INVENTORY_ITEM_ID         INV_ID, 
                                                RCTA.TRX_NUMBER                 TRX_NUMBER,
                                                RCTA.TRX_DATE                   TRX_DATE,
                                                RCTA.BILL_TO_SITE_USE_ID        BILL_ID,
                                                RCTLA.DESCRIPTION               DESCRIPTION1,
                                                RCTLA.EXTENDED_AMOUNT           VAL,
                                                MSIB.SEGMENT1             SKU       
                                                FROM
                                                AR.RA_CUSTOMER_TRX_LINES_ALL    RCTLA,
                                                AR.RA_CUSTOMER_TRX_ALL          RCTA,
                                                AR.RA_CUST_TRX_TYPES_ALL        RCTTA,
                                                (
                                                            SELECT 
                                                            MSIB.INVENTORY_ITEM_ID
                                                            ,MSIB.SEGMENT1
                                                            ,MSIB.DESCRIPTION
                                                            FROM INV.MTL_SYSTEM_ITEMS_B     MSIB
                                                            WHERE MSIB.ORGANIZATION_ID =83
                                                            AND MSIB.SEGMENT1 NOT LIKE '%BULK%'
                                                            AND MSIB.INVENTORY_ITEM_STATUS_CODE = 'Active'
                                                            AND SUBSTR(MSIB.SEGMENT1,1,6) IN ('F00042')
                                                ) MSIB
                                                WHERE    RCTA.CUSTOMER_TRX_ID=RCTLA.CUSTOMER_TRX_ID
                                                AND RCTA.CUST_TRX_TYPE_ID=RCTTA.CUST_TRX_TYPE_ID
                                                AND MSIB.INVENTORY_ITEM_ID=RCTLA.INVENTORY_ITEM_ID
                                                AND RCTLA.DESCRIPTION NOT LIKE '%B99%'
                                                AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'YYYYMM')) = 201403
                                                AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'DD')) <= 31
                                                AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'DD')) >=01
                                                AND (RCTTA.NAME LIKE '%_INVOICE'
                                                OR  RCTTA.NAME LIKE '%_CN') ) VOL_DTLS1
                 WHERE CUST_DTLS.BILL_ID=VOL_DTLS1.BILL_ID
                 GROUP BY
                 CUST_DTLS.REGION,
                 CUST_DTLS.DEPO_NAME,
                 CUST_DTLS.CUST_ACC_NO,
                 CUST_DTLS.CUST_NAME
                 ORDER BY 1,2,3,4) GH  
      WHERE AB.REGION=GH.REGION
      AND AB.DEPO_NAME=GH.DEPO_NAME
      AND AB.CUST_ACC_NO=GH.CUST_ACC_NO
      AND AB.CUST_NAME=GH.CUST_NAME) KL
ON CD.REGION=KL.REGION
AND CD.DEPO_NAME=KL.DEPO_NAME
AND CD.CUST_ACC_NO=KL.CUST_ACC_NO
AND CD.CUST_NAME=KL.CUST_NAME;
   

   
