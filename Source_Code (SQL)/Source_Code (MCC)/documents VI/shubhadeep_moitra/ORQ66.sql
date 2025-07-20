SELECT REGN,
       TERR_CODE,
       DEPO,
       PRNT_CODE   ACCOUNT_NUMBER,
       CUST_NAME   ACCOUNT_NAME,
       CHLD_CODE   BILL_TO,
       SUM(CASE        
               WHEN TO_NUMBER(TO_CHAR(INV_DATE,'YYYYMMDD'))>=20130401
                      AND TO_NUMBER(TO_CHAR(INV_DATE,'YYYYMMDD'))<=20130430  THEN VOLUME                
               ELSE 0
           END)  LY
           ,SUM(CASE        
               WHEN TO_NUMBER(TO_CHAR(INV_DATE,'YYYYMMDD'))<=20140430
                  AND TO_NUMBER(TO_CHAR(INV_DATE,'YYYYMMDD'))>=20140401  THEN VOLUME              
               ELSE 0
           END)  TY
           ,SUM(CASE        
               WHEN TO_NUMBER(TO_CHAR(INV_DATE,'YYYYMMDD'))<=20140425
                  AND TO_NUMBER(TO_CHAR(INV_DATE,'YYYYMMDD'))>=20140401  THEN VOLUME              
               ELSE 0
           END)  TY_25
                                                
           ,SUM(CASE        
               WHEN TO_NUMBER(TO_CHAR(INV_DATE,'YYYYMMDD'))<=20140430
                  AND TO_NUMBER(TO_CHAR(INV_DATE,'YYYYMMDD'))>=20140401
                    AND PACK_SIZE IN(1,5)  THEN VOLUME              
               ELSE 0
           END)  TY_RETAIL
           ,SUM(CASE        
               WHEN TO_NUMBER(TO_CHAR(INV_DATE,'YYYYMMDD'))<=20140430
                  AND TO_NUMBER(TO_CHAR(INV_DATE,'YYYYMMDD'))>=20140401
                    AND PACK_SIZE IN(20)  THEN VOLUME               
               ELSE 0
           END)  TY_20KG   
FROM
(SELECT IDRV.REGN                                                  REGN
      ,NVL(TERR_MASTER.TERR_CODE,IDRV.TERR_CODE)                  TERR_CODE
      ,IDRV.DEPO                                                  DEPO
      ,IDRV.HCA_ACCOUNT_NUMBER                                    PRNT_CODE 
      ,IDRV.HCA_ACCOUNT_NAME                                      CUST_NAME 
      ,NVL(BILL_TO_PRIMARY.BILL_TO_SITE_USE_ID
      ,NVL(BILL_TO_SECONDARY.BILL_TO_SITE_USE_ID
      ,NVL(BILL_TO_APS_APD_PRIMARY.BILL_TO_SITE_USE_ID
      ,NVL(BILL_TO_APS_APD_SECONDARY.BILL_TO_SITE_USE_ID
      ,IDRV.RCTA_BILL_TO_SITE_USE_ID))))                          CHLD_CODE
      ,IDRV.VOLUME                                                VOLUME
      ,IDRV.INV_DATE                                              INV_DATE 
      ,IDRV.PACK_SIZE                                             PACK_SIZE
        
                                                
                                                            
  FROM
       -- ******************************* -- 
       -- TERR MASTER FOR PRIMARY BILL TO --  
       -- ******************************* -- 
       (
        SELECT DISTINCT
               TO_NUMBER(RT.SEGMENT4)     TERR_CODE,
               HCA.ACCOUNT_NUMBER         HCA_ACCOUNT_NUMBER
          FROM RA_TERRITORIES             RT,   
               MTL_PARAMETERS             MP,
               RA_SALESREP_TERRITORIES    RST,
               HZ_CUST_ACCOUNTS_ALL       HCA,
               HZ_CUST_ACCT_SITES_ALL     HCASA,
               HZ_CUST_SITE_USES_ALL      HCSUA
         WHERE MP.ORGANIZATION_CODE     = RT.SEGMENT3 
           AND RT.TERRITORY_ID          = RST.TERRITORY_ID
           AND HCA.CUST_ACCOUNT_ID      = HCASA.CUST_ACCOUNT_ID
           AND HCASA.CUST_ACCT_SITE_ID  = HCSUA.CUST_ACCT_SITE_ID
           AND HCSUA.TERRITORY_ID       = RT.TERRITORY_ID
           AND HCA.STATUS               = 'A'
           AND HCSUA.SITE_USE_CODE      = 'SHIP_TO'
           AND HCSUA.PRIMARY_FLAG       = 'Y'
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
           AND RST.END_DATE_ACTIVE IS NULL 
       )  TERR_MASTER,
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
       -- ************ -- 
       -- TRANSACTIONS --  
       -- ************ -- 
       (
           SELECT CASE
                    WHEN RDTCAV.DEPO_CODE = '103' THEN 'N1'
                    ELSE RDTCAV.REGION
                  END REGN
                 ,CASE
                       WHEN RDTCAV.DEPO_CODE = '107' THEN '027'
                       ELSE RDTCAV.DEPO_CODE
                  END DEPO_CODE
                 ,RDTCAV.TERR_CODE
                 ,RDTCAV.ACCOUNT_NUMBER HCA_ACCOUNT_NUMBER
                 ,RDTCAV.NAME           HCA_ACCOUNT_NAME
                 ,RCTA.BILL_TO_SITE_USE_ID RCTA_BILL_TO_SITE_USE_ID
                 ,RCTA.TRX_DATE            INV_DATE
                 ,RCTA.TRX_NUMBER          INV_NUMBER
                 ,RCTTA.TYPE               INV_TYPE                 
                 ,RCTTA.NAME               INV_TYPE_DESC
                 ,MSIB.SEGMENT1            SKU              
                 ,MSIB.PACK_SIZE           PACK_SIZE
                 ,MSIB.PRD_GRP
                 ,MSIB.PRD_CAT,
                 RDTCAV.DEPO             DEPO
                  -- ********** -- 
                  -- VOLUME --  
                  -- ********** -- 
                 ,CASE
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
                 ,RDTCAV.SBL_TYPE
                 ,RDTCAV.CUST_TYPE                                                  
      FROM AR.RA_CUSTOMER_TRX_LINES_ALL RCTLA, 
           -- ***** -- 
           -- MSIB -- 
           -- *** -- 
          (
            SELECT MSIB.INVENTORY_ITEM_ID
                  ,MSIB.SEGMENT1
                  ,MSIB.SECONDARY_UOM_CODE  
                  ,UPPER(NVL(BPM.PRD_GRP,'NA')) PRD_GRP 
                  ,UPPER(NVL(BPM.PRD_CAT,'NA')) PRD_CAT 
                  ,NVL(BPIL.BPIL_INVOICE_UOM (MSIB.INVENTORY_ITEM_ID,MSIB.SECONDARY_UOM_CODE),0) PACK_SIZE
              FROM INV.MTL_SYSTEM_ITEMS_B     MSIB
                  ,BPIL.BPIL_PRD_MSTR_MCC BPM
             WHERE MSIB.ORGANIZATION_ID = 102 
               AND MSIB.SEGMENT1 LIKE 'F00%'
               AND MSIB.SEGMENT1 NOT LIKE '%BULK%'
               AND MSIB.INVENTORY_ITEM_STATUS_CODE = 'Active'
               AND SUBSTR(MSIB.SEGMENT1,1,6) = BPM.PRD_CODE(+)
               AND NVL(BPIL.BPIL_INVOICE_UOM (MSIB.INVENTORY_ITEM_ID,MSIB.SECONDARY_UOM_CODE),0) IN (1,5,20,40)
          ) MSIB,
           RA_CUSTOMER_TRX_ALL       RCTA,   
           AR.RA_CUST_TRX_TYPES_ALL     RCTTA,  
           OE_ORDER_LINES_ALL        OOLA,
           OE_ORDER_HEADERS_ALL      OOHA,
           OE_TRANSACTION_TYPES_TL   OTTT,
           (
           SELECT 
                 SUBSTR(HAOU.ATTRIBUTE4,1,2) REGION, 
                 HAOU.NAME                  DEPO,
                 SUBSTR(HAOU.NAME,1,3)      DEPO_CODE,
                 TO_NUMBER(RT.SEGMENT4)     TERR_CODE,
                 HCA.ACCOUNT_NUMBER         ACCOUNT_NUMBER,
                 HCSUA.SITE_USE_ID    BILL_ID,
                 HCA.ACCOUNT_NAME     NAME,
                 CASE
             WHEN hca.account_number = '64376'
                THEN '5'
             ELSE hcasa.global_attribute10
          END cust_type,
          hca.sales_channel_code sbl_type
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
                AND  HAOU.ATTRIBUTE1='DEPOT'
                AND (SUBSTR(HAOU.NAME,1,3)) IN :RPT_DEPO) RDTCAV
     WHERE RCTA.CUSTOMER_TRX_ID            = RCTLA.CUSTOMER_TRX_ID   
       AND RCTA.CUST_TRX_TYPE_ID           = RCTTA.CUST_TRX_TYPE_ID  
       AND RCTLA.INVENTORY_ITEM_ID         = MSIB.INVENTORY_ITEM_ID
       AND RCTLA.INTERFACE_LINE_ATTRIBUTE6 = OOLA.LINE_ID
       AND OOLA.HEADER_ID                  = OOHA.HEADER_ID     
       AND OOHA.ORDER_TYPE_ID              = OTTT.TRANSACTION_TYPE_ID
       AND RDTCAV.BILL_ID               = RCTA.BILL_TO_SITE_USE_ID   
       AND RCTLA.LINE_TYPE                 = 'LINE'
       AND SUBSTR(RCTLA.DESCRIPTION,5,3)  <> 'B99'
       AND SUBSTR(RCTLA.DESCRIPTION,1,3)  <> 'JMU'
       AND RCTLA.DESCRIPTION NOT LIKE '%SPL%PCA%'
       AND (RCTTA.NAME LIKE '%_INVOICE'
        OR  RCTTA.NAME LIKE '%_CN')
       -- *************************** -- 
       -- BASED ON SCHEME REQUIREMTNS -- 
       -- *************************** -- 
      AND RDTCAV.DEPO_CODE IN (
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
                               )
       AND RDTCAV.SBL_TYPE  = '0'
       AND RDTCAV.CUST_TYPE IN ('3','5','7','55')
       AND (TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'YYYYMM'))=201404
              OR TO_NUMBER(TO_CHAR(RCTA.TRX_DATE,'YYYYMM'))=201304)
             
      )  IDRV
       --BPIL.BPIL_SUBDEALER_COUNT_MCC BSCM
 WHERE IDRV.HCA_ACCOUNT_NUMBER = TERR_MASTER.HCA_ACCOUNT_NUMBER(+)
   AND IDRV.HCA_ACCOUNT_NUMBER = BILL_TO_PRIMARY.HCA_ACCOUNT_NUMBER(+)
   AND IDRV.HCA_ACCOUNT_NUMBER = BILL_TO_SECONDARY.HCA_ACCOUNT_NUMBER(+)
   AND IDRV.HCA_ACCOUNT_NUMBER = BILL_TO_APS_APD_PRIMARY.HCA_ACCOUNT_NUMBER(+)
   AND IDRV.HCA_ACCOUNT_NUMBER = BILL_TO_APS_APD_SECONDARY.HCA_ACCOUNT_NUMBER(+)
   --AND IDRV.DEPO_CODE          = BSCM.DEPO_CODE(+)
   --AND IDRV.HCA_ACCOUNT_NUMBER = BSCM.HCA_ACCOUNT_NUMBER(+)
 -- COMMENT OLD MRP CLAUSE WHEN MENTIONED WITH OLD MRP -- 
   --AND SUBSTR(IDRV.DMG_IND,5,6) <> 'OLDMRP'
   --AND SUBSTR(IDRV.DMG_IND,5,6) <> 'DAMAGE'
   --AND SUBSTR(IDRV.DMG_IND,5,5) <> 'SCRAP'
ORDER BY 1,2,3,4,5)
GROUP BY
       REGN,
       TERR_CODE,
       DEPO,
       PRNT_CODE,   
       CUST_NAME,  
       CHLD_CODE   
ORDER BY 1,2,3,4,5;
