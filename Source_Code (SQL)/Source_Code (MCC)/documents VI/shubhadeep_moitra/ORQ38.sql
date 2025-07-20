SELECT IDRV.REGN                                                  REGN
      ,IDRV.DEPO                                                  DEPO
      ,IDRV.HCA_ACCOUNT_NUMBER                                    ACCOUNT_NUMBER 
      ,IDRV.HCA_ACCOUNT_NAME                                      ACCOUNT_NAME  
      ,NVL(BILL_TO_PRIMARY.BILL_TO_SITE_USE_ID,
       NVL(BILL_TO_SECONDARY.BILL_TO_SITE_USE_ID,
       NVL(BILL_TO_APS_APD_PRIMARY.BILL_TO_SITE_USE_ID,
       NVL(BILL_TO_APS_APD_SECONDARY.BILL_TO_SITE_USE_ID,
       IDRV.RCTA_BILL_TO_SITE_USE_ID))))                          BILL_TO 
        ,SUM(CASE
               WHEN TO_NUMBER(TO_CHAR(IDRV.INV_DATE,'YYYYDDMM'))<=20142802 AND TO_NUMBER(TO_CHAR(IDRV.INV_DATE,'YYYYDDMM'))>=20140102   THEN IDRV.FNL_VOL                
               ELSE 0
           END)                                                   LY_VOL,
          SUM(CASE
               WHEN TO_NUMBER(TO_CHAR(IDRV.INV_DATE,'YYYYDDMM'))<=20143103 AND TO_NUMBER(TO_CHAR(IDRV.INV_DATE,'YYYYDDMM'))>=20140103   THEN IDRV.FNL_VOL                
               ELSE 0
           END)                                                   TY_VOL  
FROM                             
   -- *************** -- 
       -- PRIMARY BILL TO --  
       -- *************** -- 
       (
        SELECT DISTINCT
               HCA.ACCOUNT_NUMBER         HCA_ACCOUNT_NUMBER
              ,HCSUA.BILL_TO_SITE_USE_ID  BILL_TO_SITE_USE_ID
          FROM HZ_CUST_ACCOUNTS_ALL       HCA,
               HZ_CUST_ACCT_SITES_ALL     HCASA,
               HZ_CUST_SITE_USES_ALL      HCSUA,
               AR.HZ_LOCATIONS               HL,       
               HZ_PARTY_SITES             HPS       
         WHERE HCA.CUST_ACCOUNT_ID      = HCASA.CUST_ACCOUNT_ID
           AND HCASA.CUST_ACCT_SITE_ID  = HCSUA.CUST_ACCT_SITE_ID
           AND HCA.STATUS               = 'A'
           AND HCASA.PARTY_SITE_ID      = HPS.PARTY_SITE_ID          
           AND HPS.LOCATION_ID          = HL.LOCATION_ID               
           AND HCSUA.SITE_USE_CODE      = 'SHIP_TO'
           AND HCSUA.PRIMARY_FLAG       = 'Y'
           AND HCSUA.STATUS             = 'A'
           AND HCSUA.WAREHOUSE_ID       IN (SELECT ORGANIZATION_ID  FROM MTL_PARAMETERS WHERE ORGANIZATION_CODE IN (
                                                                                                                     SELECT CASE
                                                                                                                                WHEN :RPT_DEPO = '107' THEN 'XXX'
                                                                                                                                ELSE :RPT_DEPO
                                                                                                                           END  DEPO_CODE FROM DUAL
                                                                                                                     UNION 
                                                                                                                     SELECT CASE
                                                                                                                                WHEN :RPT_DEPO = '027' THEN '107'
                                                                                                                                WHEN :RPT_DEPO = '107' THEN 'XXX'
                                                                                                                                ELSE :RPT_DEPO
                                                                                                                           END  DEPO_CODE FROM DUAL
                                                                                                                   ))
           AND HCSUA.CUST_ACCT_SITE_ID <= (SELECT MAX(CUST_ACCT_SITE_ID) FROM HZ_CUST_ACCT_SITES_ALL)
           AND HCA.SALES_CHANNEL_CODE   =  '0'
           AND HCASA.GLOBAL_ATTRIBUTE10 <> '4'
           AND HCASA.GLOBAL_ATTRIBUTE10 <> '6'
           AND UPPER(HL.ADDRESS1) NOT LIKE '%COLORBANK%'
           AND UPPER(HL.ADDRESS1) NOT LIKE '%DAMAGE%'
           AND UPPER(HL.ADDRESS1) LIKE '%MAPD%'
       ) BILL_TO_PRIMARY,
       -- ***************** -- 
       -- SECONDARY BILL TO --  
       -- ***************** -- 
       (
        SELECT HCA.ACCOUNT_NUMBER             HCA_ACCOUNT_NUMBER
              ,MIN(HCSUA.BILL_TO_SITE_USE_ID) BILL_TO_SITE_USE_ID
          FROM HZ_CUST_ACCOUNTS_ALL       HCA,
               HZ_CUST_ACCT_SITES_ALL     HCASA,
               HZ_CUST_SITE_USES_ALL      HCSUA,
               HZ_LOCATIONS               HL,       
               HZ_PARTY_SITES             HPS       
         WHERE HCA.CUST_ACCOUNT_ID      = HCASA.CUST_ACCOUNT_ID
           AND HCASA.CUST_ACCT_SITE_ID  = HCSUA.CUST_ACCT_SITE_ID
           AND HCA.STATUS               = 'A'
           AND HCASA.PARTY_SITE_ID      = HPS.PARTY_SITE_ID          
           AND HPS.LOCATION_ID          = HL.LOCATION_ID               
           AND HCSUA.SITE_USE_CODE      = 'SHIP_TO'
           AND HCSUA.STATUS             = 'A'
           AND HCSUA.WAREHOUSE_ID       IN (SELECT ORGANIZATION_ID  FROM MTL_PARAMETERS WHERE ORGANIZATION_CODE IN (
                                                                                                                     SELECT CASE
                                                                                                                                WHEN :RPT_DEPO = '107' THEN 'XXX'
                                                                                                                                ELSE :RPT_DEPO
                                                                                                                           END  DEPO_CODE FROM DUAL
                                                                                                                     UNION 
                                                                                                                     SELECT CASE
                                                                                                                                WHEN :RPT_DEPO = '027' THEN '107'
                                                                                                                                WHEN :RPT_DEPO = '107' THEN 'XXX'
                                                                                                                                ELSE :RPT_DEPO
                                                                                                                           END  DEPO_CODE FROM DUAL
                                                                                                                   ))
           AND HCSUA.CUST_ACCT_SITE_ID <= (SELECT MAX(CUST_ACCT_SITE_ID) FROM HZ_CUST_ACCT_SITES_ALL)
           AND HCA.SALES_CHANNEL_CODE   =  '0'
           AND HCASA.GLOBAL_ATTRIBUTE10 <> '4'
           AND HCASA.GLOBAL_ATTRIBUTE10 <> '6'
           AND UPPER(HL.ADDRESS1) NOT LIKE '%COLORBANK%'
           AND UPPER(HL.ADDRESS1) NOT LIKE '%DAMAGE%'
           AND UPPER(HL.ADDRESS1) LIKE '%MAPD%'
         GROUP BY HCA.ACCOUNT_NUMBER  
       ) BILL_TO_SECONDARY,
       --*********************-- 
       -- PRIMARY BILL TO APD -- 
       --*********************-- 
       (
        SELECT DISTINCT
               HCA.ACCOUNT_NUMBER         HCA_ACCOUNT_NUMBER
              ,HCSUA.BILL_TO_SITE_USE_ID  BILL_TO_SITE_USE_ID
          FROM HZ_CUST_ACCOUNTS_ALL       HCA,
               HZ_CUST_ACCT_SITES_ALL     HCASA,
               HZ_CUST_SITE_USES_ALL      HCSUA,
               HZ_LOCATIONS               HL,       
               HZ_PARTY_SITES             HPS       
         WHERE HCA.CUST_ACCOUNT_ID      = HCASA.CUST_ACCOUNT_ID
           AND HCASA.CUST_ACCT_SITE_ID  = HCSUA.CUST_ACCT_SITE_ID
           AND HCA.STATUS               = 'A'
           AND HCASA.PARTY_SITE_ID      = HPS.PARTY_SITE_ID          
           AND HPS.LOCATION_ID          = HL.LOCATION_ID               
           AND HCSUA.SITE_USE_CODE      = 'SHIP_TO'
           AND HCSUA.PRIMARY_FLAG       = 'Y'
           AND HCSUA.STATUS             = 'A'
           AND HCSUA.WAREHOUSE_ID       IN (SELECT ORGANIZATION_ID  FROM MTL_PARAMETERS WHERE ORGANIZATION_CODE IN (
                                                                                                                     SELECT CASE
                                                                                                                                WHEN :RPT_DEPO = '107' THEN 'XXX'
                                                                                                                                ELSE :RPT_DEPO
                                                                                                                           END  DEPO_CODE FROM DUAL
                                                                                                                     UNION 
                                                                                                                     SELECT CASE
                                                                                                                                WHEN :RPT_DEPO = '027' THEN '107'
                                                                                                                                WHEN :RPT_DEPO = '107' THEN 'XXX'
                                                                                                                                ELSE :RPT_DEPO
                                                                                                                           END  DEPO_CODE FROM DUAL
                                                                                                                   ))
           AND HCSUA.CUST_ACCT_SITE_ID <= (SELECT MAX(CUST_ACCT_SITE_ID) FROM HZ_CUST_ACCT_SITES_ALL)
           AND HCA.SALES_CHANNEL_CODE   =  '0'
           AND HCASA.GLOBAL_ATTRIBUTE10 <> '4'
           AND HCASA.GLOBAL_ATTRIBUTE10 <> '6'
           AND UPPER(HL.ADDRESS1) NOT LIKE '%COLORBANK%'
           AND UPPER(HL.ADDRESS1) NOT LIKE '%DAMAGE%'
           AND UPPER(HL.ADDRESS1) LIKE '%APD%'
       ) BILL_TO_APS_APD_PRIMARY,
       --***********************-- 
       -- SECONDARY BILL TO APD -- 
       --***********************-- 
       (
        SELECT HCA.ACCOUNT_NUMBER             HCA_ACCOUNT_NUMBER
              ,MIN(HCSUA.BILL_TO_SITE_USE_ID) BILL_TO_SITE_USE_ID
          FROM HZ_CUST_ACCOUNTS_ALL       HCA,
               HZ_CUST_ACCT_SITES_ALL     HCASA,
               HZ_CUST_SITE_USES_ALL      HCSUA,
               HZ_LOCATIONS               HL,       
               HZ_PARTY_SITES             HPS       
         WHERE HCA.CUST_ACCOUNT_ID      = HCASA.CUST_ACCOUNT_ID
           AND HCASA.CUST_ACCT_SITE_ID  = HCSUA.CUST_ACCT_SITE_ID
           AND HCA.STATUS               = 'A'
           AND HCASA.PARTY_SITE_ID      = HPS.PARTY_SITE_ID          
           AND HPS.LOCATION_ID          = HL.LOCATION_ID               
           AND HCSUA.SITE_USE_CODE      = 'SHIP_TO'
           AND HCSUA.STATUS             = 'A'
           AND HCSUA.WAREHOUSE_ID       IN (SELECT ORGANIZATION_ID  FROM MTL_PARAMETERS WHERE ORGANIZATION_CODE IN (
                                                                                                                     SELECT CASE
                                                                                                                                WHEN :RPT_DEPO = '107' THEN 'XXX'
                                                                                                                                ELSE :RPT_DEPO
                                                                                                                           END  DEPO_CODE FROM DUAL
                                                                                                                     UNION 
                                                                                                                     SELECT CASE
                                                                                                                                WHEN :RPT_DEPO = '027' THEN '107'
                                                                                                                                WHEN :RPT_DEPO = '107' THEN 'XXX'
                                                                                                                                ELSE :RPT_DEPO
                                                                                                                           END  DEPO_CODE FROM DUAL
                                                                                                                   ))
           AND HCSUA.CUST_ACCT_SITE_ID <= (SELECT MAX(CUST_ACCT_SITE_ID) FROM HZ_CUST_ACCT_SITES_ALL)
           AND HCA.SALES_CHANNEL_CODE   =  '0'
           AND HCASA.GLOBAL_ATTRIBUTE10 <> '4'
           AND HCASA.GLOBAL_ATTRIBUTE10 <> '6'
           AND UPPER(HL.ADDRESS1) NOT LIKE '%COLORBANK%'
           AND UPPER(HL.ADDRESS1) NOT LIKE '%DAMAGE%'
           AND UPPER(HL.ADDRESS1) LIKE '%APD%'
         GROUP BY HCA.ACCOUNT_NUMBER  
       ) BILL_TO_APS_APD_SECONDARY,
       (
               SELECT 
                 RDTCAV.REGION      REGN,
                 RDTCAV.DEPO
                 ,RDTCAV.TERR_CODE
                 ,RDTCAV.ACCOUNT_NUMBER HCA_ACCOUNT_NUMBER
                 ,RDTCAV.CUST_NAME           HCA_ACCOUNT_NAME
                 ,RCTA.BILL_TO_SITE_USE_ID RCTA_BILL_TO_SITE_USE_ID
                 ,RCTA.TRX_DATE            INV_DATE
                 ,RCTA.TRX_NUMBER          INV_NUMBER
                 ,RCTTA.TYPE               INV_TYPE                 
                 ,RCTTA.NAME               INV_TYPE_DESC
                 ,MSIB.SEGMENT1            SKU              
                 ,MSIB.PACK_SIZE, 
                 RCTA.BILL_TO_SITE_USE_ID  RCTA_BILL_TO_SITE_USE_ID,              
                  -- ********** -- 
                  -- VOLUME --  
          -- ********** -- 
                 CASE
                    WHEN SUBSTR(RCTLA.DESCRIPTION,6,15) = 'MANUAL_DISCOUNT' THEN 0
                    ELSE
                      CASE
                        WHEN RCTTA.TYPE = 'CM' THEN MSIB.PACK_SIZE * NVL(RCTLA.QUANTITY_CREDITED,0)
                        ELSE MSIB.PACK_SIZE * NVL(RCTLA.QUANTITY_INVOICED,0)
                      END
                  END VOLUME
                  -- ********** -- 
                  -- FNL_VOL --  
                  -- ********** -- 
                 ,CASE
                     WHEN SUBSTR(RCTLA.DESCRIPTION,6,15) = 'MANUAL_DISCOUNT' THEN 0
                     ELSE
                         CASE
                           WHEN (MSIB.SECONDARY_UOM_CODE = 'L' 
                             OR  MSIB.SECONDARY_UOM_CODE = 'ML') 
                            AND  RCTTA.TYPE = 'CM' 
                           THEN  MSIB.PACK_SIZE * NVL(RCTLA.QUANTITY_CREDITED,0)
                           WHEN (MSIB.SECONDARY_UOM_CODE <> 'L' 
                            AND  MSIB.SECONDARY_UOM_CODE <> 'ML') 
                            AND  RCTTA.TYPE = 'CM' 
                           THEN (MSIB.PACK_SIZE * NVL(RCTLA.QUANTITY_CREDITED,0))/2.8
                           WHEN (MSIB.SECONDARY_UOM_CODE = 'L' 
                             OR  MSIB.SECONDARY_UOM_CODE = 'ML') 
                            AND  RCTTA.TYPE <> 'CM' 
                           THEN  MSIB.PACK_SIZE * NVL(RCTLA.QUANTITY_INVOICED,0)
                           WHEN (MSIB.SECONDARY_UOM_CODE <> 'L' 
                            AND  MSIB.SECONDARY_UOM_CODE <> 'ML') 
                            AND  RCTTA.TYPE <> 'CM' 
                           THEN (MSIB.PACK_SIZE * NVL(RCTLA.QUANTITY_INVOICED,0))/2.8
                         END
                  END FNL_VOL
                  -- ********** -- 
                  -- DMG_IND --  
                  -- ********** -- 
               FROM AR.RA_CUSTOMER_TRX_LINES_ALL RCTLA, 
           -- ***** -- 
           -- MSIB -- 
           -- *** -- 
          (
            SELECT MSIB.INVENTORY_ITEM_ID
                  ,MSIB.SEGMENT1
                  ,MSIB.SECONDARY_UOM_CODE  
                  ,NVL(BPIL.BPIL_INVOICE_UOM (MSIB.INVENTORY_ITEM_ID,MSIB.SECONDARY_UOM_CODE),0) PACK_SIZE
              FROM INV.MTL_SYSTEM_ITEMS_B     MSIB
             WHERE MSIB.ORGANIZATION_ID = 83 
               AND MSIB.SEGMENT1 NOT LIKE '%BULK%'
               AND MSIB.INVENTORY_ITEM_STATUS_CODE = 'Active'
               AND SUBSTR(MSIB.SEGMENT1,1,6) IN ('F00000','F00042')
          ) MSIB,
           RA_CUSTOMER_TRX_ALL       RCTA,   
           AR.RA_CUST_TRX_TYPES_ALL     RCTTA,  
           (
           SELECT 
                 SUBSTR(HAOU.ATTRIBUTE4,1,2) REGION, 
                 HAOU.NAME                  DEPO,
                 TO_NUMBER(RT.SEGMENT4)     TERR_CODE,
                 HCA.ACCOUNT_NUMBER         ACCOUNT_NUMBER,
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
                AND  HAOU.ATTRIBUTE1='DEPOT') RDTCAV
     WHERE RCTA.CUSTOMER_TRX_ID            = RCTLA.CUSTOMER_TRX_ID   
       AND RCTA.CUST_TRX_TYPE_ID           = RCTTA.CUST_TRX_TYPE_ID  
       AND RCTLA.INVENTORY_ITEM_ID         = MSIB.INVENTORY_ITEM_ID
       AND RDTCAV.BILL_ID               = RCTA.BILL_TO_SITE_USE_ID   
       AND SUBSTR(RCTLA.DESCRIPTION,5,3)  <> 'B99'
       AND SUBSTR(RCTLA.DESCRIPTION,1,3)  <> 'JMU'
       AND RCTLA.DESCRIPTION NOT LIKE '%SPL%PCA%'
       AND (RCTTA.NAME LIKE '%_INVOICE'
        OR  RCTTA.NAME LIKE '%_CN')
       -- *************************** -- 
       -- BASED ON SCHEME REQUIREMTNS -- 
       -- *************************** --  
       AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'YYYYMM')) = 201403
       AND TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'DD')) <= 31
     )  IDRV
     WHERE
   IDRV.HCA_ACCOUNT_NUMBER = BILL_TO_PRIMARY.HCA_ACCOUNT_NUMBER(+)
   AND IDRV.HCA_ACCOUNT_NUMBER = BILL_TO_SECONDARY.HCA_ACCOUNT_NUMBER(+)
   AND IDRV.HCA_ACCOUNT_NUMBER = BILL_TO_APS_APD_PRIMARY.HCA_ACCOUNT_NUMBER(+)
   AND IDRV.HCA_ACCOUNT_NUMBER = BILL_TO_APS_APD_SECONDARY.HCA_ACCOUNT_NUMBER(+)
   GROUP BY 1,2,3,4,5;