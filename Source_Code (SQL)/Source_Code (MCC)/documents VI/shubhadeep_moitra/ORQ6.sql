--SELECT NVL(BPIL.BPIL_INVOICE_UOM (MSIB.INVENTORY_ITEM_ID,MSIB.SECONDARY_UOM_CODE),0) PACK_SIZE
--FROM
--MTL_SYSTEM_ITEMS_B     MSIB
--INV.MTL_UOM_CONVERSIONS MOC
--INV.MTL_UOM_CLASS_CONVERSIONS mucc


 
 SELECT
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
  AR.RA_CUSTOMER_TRX_LINES_ALL RCTLA,
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
               AND SUBSTR(MSIB.SEGMENT1,1,6) IN ('F00074','F00446','F00438')
          ) MSIB,
           RA_CUSTOMER_TRX_ALL       RCTA,   
           RA_CUST_TRX_TYPES_ALL     RCTTA
WHERE
       RCTA.CUSTOMER_TRX_ID                = RCTLA.CUSTOMER_TRX_ID   
       AND RCTA.CUST_TRX_TYPE_ID           = RCTTA.CUST_TRX_TYPE_ID  
       AND RCTLA.INVENTORY_ITEM_ID         = MSIB.INVENTORY_ITEM_ID;