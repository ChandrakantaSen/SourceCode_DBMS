SELECT MSIB.INVENTORY_ITEM_ID
                  ,MSIB.SEGMENT1
                  ,MSIB.SECONDARY_UOM_CODE  
                  ,UPPER(NVL(BPM.PRD_GRP,'NA')) PRD_GRP 
                  ,UPPER(NVL(BPM.PRD_CAT,'NA')) PRD_CAT 
                  ,NVL(BPIL.BPIL_INVOICE_UOM (MSIB.INVENTORY_ITEM_ID,MSIB.SECONDARY_UOM_CODE),0) PACK_SIZE
                  ,MSIB.DESCRIPTION
              FROM INV.MTL_SYSTEM_ITEMS_B     MSIB
                  ,BPIL.BPIL_PRD_MSTR_MCC BPM
             WHERE MSIB.ORGANIZATION_ID = 102
               AND MSIB.SEGMENT1 NOT LIKE '%BULK%'
               AND MSIB.SEGMENT1 LIKE 'F00%'
               AND MSIB.INVENTORY_ITEM_STATUS_CODE = 'Active'
               AND SUBSTR(MSIB.SEGMENT1,1,6) = BPM.PRD_CODE(+)
               AND SUBSTR(MSIB.SEGMENT1,1,6) IN ('F00074','F00446','F00438')