SELECT IDRV.REGN                                                  REGN
      ,IDRV.DEPO_CODE                                             DEPO_CODE
      ,IDRV.DEPO_NAME                                             DEPO_NAME 
      ,IDRV.TERR_CODE                                             TERR_CODE
      ,IDRV.HCA_ACCOUNT_NUMBER                                    PRNT_CODE 
      ,IDRV.HCA_ACCOUNT_NAME                                      CUST_NAME  
      ,SUM(CASE
               WHEN SUBSTR(IDRV.SKU,1,6) ='F00000' AND TO_NUMBER(TO_CHAR(IDRV.INV_DATE,'YYYYDDMM'))<=20142802 AND TO_NUMBER(TO_CHAR(IDRV.INV_DATE,'YYYYDDMM'))>=20140102   THEN IDRV.FNL_VOL                
               ELSE 0
           END)                                                   LY_VOL_F00000,
          SUM(CASE
               WHEN SUBSTR(IDRV.SKU,1,6) ='F00000' AND TO_NUMBER(TO_CHAR(IDRV.INV_DATE,'YYYYDDMM'))<=20143103 AND TO_NUMBER(TO_CHAR(IDRV.INV_DATE,'YYYYDDMM'))>=20140103   THEN IDRV.FNL_VOL                
               ELSE 0
           END)                                                   LY_VOL_F00000,
           SUM(CASE
               WHEN SUBSTR(IDRV.SKU,1,6) ='F00042' AND TO_NUMBER(TO_CHAR(IDRV.INV_DATE,'YYYYDDMM'))<=20142802 AND TO_NUMBER(TO_CHAR(IDRV.INV_DATE,'YYYYDDMM'))>=20140102   THEN IDRV.FNL_VOL                
               ELSE 0
           END)                                                   LY_VOL_F00042,
           SUM(CASE
               WHEN SUBSTR(IDRV.SKU,1,6) ='F00042' AND TO_NUMBER(TO_CHAR(IDRV.INV_DATE,'YYYYDDMM'))<=20143103 AND TO_NUMBER(TO_CHAR(IDRV.INV_DATE,'YYYYDDMM'))>=20140103   THEN IDRV.FNL_VOL                
               ELSE 0
           END)                                                   LY_VOL_F00042,
           SUM(IDRV.FNL_VOL)                                      FNL_VOL                                                                 
        FROM
       (
               SELECT CASE
                    WHEN RDTCAV.DEPO_CODE = '103' THEN 'N1'
                    ELSE RDTCAV.REGION
                  END REGN
                 ,CASE
                       WHEN RDTCAV.DEPO_CODE = '107' THEN '027'
                       ELSE RDTCAV.DEPO_CODE
                  END DEPO_CODE
                 ,CASE
                       WHEN RDTCAV.DEPO_NAME = '107:Jammu-3' THEN '027:Jammu'
                       ELSE RDTCAV.DEPO_NAME
                  END DEPO_NAME
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
                 SUBSTR(HAOU.NAME,1,3) DEPO_CODE,
                 SUBSTR(HAOU.NAME,5,LENGTH(HAOU.NAME)) DEPO_NAME,
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
GROUP BY IDRV.REGN 
        ,IDRV.DEPO_CODE                                              
        ,IDRV.DEPO_NAME                                           
        ,IDRV.TERR_CODE            
        ,IDRV.HCA_ACCOUNT_NUMBER                                  
        ,IDRV.HCA_ACCOUNT_NAME                                     
ORDER BY 1,2,3,4,5;