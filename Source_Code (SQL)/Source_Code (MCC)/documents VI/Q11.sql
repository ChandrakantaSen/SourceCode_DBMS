SELECT 
        RCTLA.INVENTORY_ITEM_ID      IID,
        MSIB.SEGMENT1               SKU,
        RCTLA.QUANTITY_INVOICED     VOLUME,
        RCTLA.DESCRIPTION           DESCRIPTION
FROM
        inv.mtl_system_items_b          MSIB,
        ar.ra_customer_trx_lines_all    RCTLA,
        AR.RA_CUSTOMER_TRX_ALL          RCTA
WHERE
        RCTLA.INVENTORY_ITEM_ID = MSIB.INVENTORY_ITEM_ID;
    --AND RCTA.CUSTOMER_TRX_ID = RCTLA.CUSTOMER_TRX_ID;
    
   
SELECT SKU_DTLS.SKU,
       CUST_DES.VOLUME,
       CUST_DES.DESCRIPTION
       FROM
 (SELECT 
     DISTINCT(MSIB.INVENTORY_ITEM_ID )  IID,
     MSIB.SEGMENT1    SKU
    FROM inv.mtl_system_items_b          MSIB) SKU_DTLS,
    
    (SELECT
     RCTLA.QUANTITY_INVOICED     VOLUME,
     RCTLA.DESCRIPTION           DESCRIPTION,
     RCTLA.INVENTORY_ITEM_ID     IID
     FROM
   ar.ra_customer_trx_lines_all    RCTLA) CUST_DES
   WHERE SKU_DTLS.IID=CUST_DES.IID;