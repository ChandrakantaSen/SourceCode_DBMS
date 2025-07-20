SELECT 
    SUBSTR(HAOU.ATTRIBUTE4,1,2) REGION,
    SUBSTR(HAOU.NAME,1,3)  DEPO_CODE,
    SUBSTR(HAOU.NAME,5,LENGTH(HAOU.NAME)) DEPO_NAME,
    LLL. CUST_ACC_NO           CUST_ACC_NO,
    LLL.CUST_NAME            CUST_NAME,
    LLL.BILL_ID              BILL_ID,
    LLL.INVOICE_ID           INVOICE_ID,
    LLL.SKU                  SKU,
    LLL.DESCRIPTION          DESCRIPTION,
    LLL.VOLUME_LIFTED        VOLUME_LIFTED
 FROM 
 HR.HR_ALL_ORGANIZATION_UNITS  HAOU,
(SELECT 
       HCA.CUST_ACCOUNT_ID  CUST_ACC_NO,
       HCA.ACCOUNT_NAME     CUST_NAME,
       HCSUA.CUST_ACCT_SITE_ID BILL_ID,
       PPP.INVOICE_ID    INVOICE_ID,
       PPP.SKU           SKU,
       PPP. DESCRIPTION   DESCRIPTION,
       PPP.VOLUME_LIFTED  VOLUME_LIFTED,
       HCSUA.WAREHOUSE_ID  WID
       FROM
        AR.HZ_CUST_ACCOUNTS         HCA,
         AR.HZ_CUST_ACCT_SITES_ALL   HCASA,
         AR.HZ_CUST_SITE_USES_ALL  HCSUA,
        (SELECT
                            DISTINCT(VOL_DTLS.INVOICE_ID)   INVOICE_ID,
                            SKU_DTLS.SKU                    SKU,
                            SKU_DTLS. DESCRIPTION           DESCRIPTION,
                            VOL_DTLS.VOLUME_LIFTED          VOLUME_LIFTED,
                            VOL_DTLS.BILL_ID                BILL_ID,
                            VOL_DTLS.BILL_CUS_ID            BILL_CUS_ID
                    FROM
                             (SELECT
                                                                RCTA.TRX_NUMBER              INVOICE_ID,
                                                                RCTLA.QUANTITY_INVOICED         VOLUME_LIFTED,
                                                                RCTLA.INVENTORY_ITEM_ID         INV_ID,
                                                                RCTA.BILL_TO_SITE_USE_ID        BILL_ID,
                                                                RCTA.BILL_TO_CUSTOMER_ID        BILL_CUS_ID
                              FROM 
                              ar.ra_customer_trx_lines_all RCTLA,
                              AR.RA_CUSTOMER_TRX_ALL  RCTA
                              WHERE  RCTA.CUSTOMER_TRX_ID=RCTLA.CUSTOMER_TRX_ID
                              AND RCTA.TRX_NUMBER='100') VOL_DTLS,
                              (SELECT 
                                                                DISTINCT(MSIB.INVENTORY_ITEM_ID)   INV_ID,
                                                                MSIB.SEGMENT1    SKU,
                                                                MSIB.DESCRIPTION DESCRIPTION
                               FROM
                              inv.mtl_system_items_b       MSIB) SKU_DTLS
                    WHERE VOL_DTLS.INV_ID=SKU_DTLS.INV_ID)PPP
                    WHERE HCA.CUST_ACCOUNT_ID=HCASA.CUST_ACCOUNT_ID
                    AND  HCASA.CUST_ACCT_SITE_ID=HCSUA.CUST_ACCT_SITE_ID
                    AND  HCSUA.SITE_USE_ID=PPP.BILL_ID
                    AND HCSUA.SITE_USE_CODE='BILL_TO') LLL
                    WHERE LLL.WID=HAOU.ORGANIZATION_ID
                    AND HAOU.ATTRIBUTE1='DEPOT'
                    ORDER BY 1,2,3,4,5,6,7;