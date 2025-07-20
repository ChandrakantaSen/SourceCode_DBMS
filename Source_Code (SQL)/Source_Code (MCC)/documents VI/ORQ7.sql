SELECT
    SUBSTR(HAOU.ATTRIBUTE4,1,2) REGION, 
    HCA.ACCOUNT_NUMBER  CUST_ACC_NO,
    RT.
     HCSUA.SITE_USE_ID    BILL_ID,
    HCA.ACCOUNT_NAME     CUST_NAME



(SELECT   RCTLA.INVENTORY_ITEM_ID         INV_ID, 
         RCTA.TRX_NUMBER                 TRX_NUMBER,
         RCTA.TRX_DATE                   TRX_DATE,
         RCTA.BILL_TO_SITE_USE_ID        BILL_ID,
         RCTLA.DESCRIPTION               DESCRIPTION1,
         MSIB.SEGMENT1             SKU,
         CASE
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
FROM
        AR.RA_CUSTOMER_TRX_LINES_ALL    RCTLA,
         AR.RA_CUSTOMER_TRX_ALL          RCTA,
         AR.RA_CUST_TRX_TYPES_ALL        RCTTA,
         (
            SELECT MSIB.INVENTORY_ITEM_ID
                  ,MSIB.SEGMENT1
                  ,MSIB.SECONDARY_UOM_CODE  
                  ,UPPER(NVL(BPM.PRD_GRP,'NA')) PRD_GRP 
                  ,UPPER(NVL(BPM.PRD_CAT,'NA')) PRD_CAT 
                  ,NVL(BPIL.BPIL_INVOICE_UOM (MSIB.INVENTORY_ITEM_ID,MSIB.SECONDARY_UOM_CODE),0) PACK_SIZE
                  ,MSIB.DESCRIPTION
              FROM MTL_SYSTEM_ITEMS_B     MSIB
                  ,BPIL.BPIL_PRD_MSTR_MCC BPM
             WHERE MSIB.ORGANIZATION_ID = 102
               AND MSIB.SEGMENT1 NOT LIKE '%BULK%'
               AND MSIB.INVENTORY_ITEM_STATUS_CODE = 'Active'
               AND SUBSTR(MSIB.SEGMENT1,1,6) = BPM.PRD_CODE(+)
               AND SUBSTR(MSIB.SEGMENT1,1,6) IN ('F00017','F00034')
          ) MSIB
WHERE    RCTA.CUSTOMER_TRX_ID=RCTLA.CUSTOMER_TRX_ID
         AND RCTA.CUST_TRX_TYPE_ID=RCTTA.CUST_TRX_TYPE_ID
         AND MSIB.INVENTORY_ITEM_ID=RCTLA.INVENTORY_ITEM_ID)
