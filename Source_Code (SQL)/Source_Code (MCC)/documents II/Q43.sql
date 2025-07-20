SELECT
       SUBSTR(HAOU.ATTRIBUTE4,1,2) REGION,
       SUBSTR(HAOU.NAME,1,3)  DEPO_CODE,
       SUBSTR(HAOU.NAME,5,LENGTH(HAOU.NAME)) DEPO_NAME,
       HCA.CUST_ACCOUNT_ID  CUST_ACC_NO,
       HCA.ACCOUNT_NAME     CUST_NAME,
       HCSUA.CUST_ACCT_SITE_ID BILL_ID,
       KKK.INVOICE_ID,
       KKK. SKU,
       KKK. DESCRIPTION,
       KKK.VOLUME_LIFTED
 FROM
  AR.HZ_CUST_ACCOUNTS         HCA,
         AR.HZ_CUST_ACCT_SITES_ALL   HCASA,
         AR.HZ_CUST_SITE_USES_ALL  HCSUA,
         HR.HR_ALL_ORGANIZATION_UNITS HAOU,
         
(SELECT
                            DISTINCT(VOL_DTLS.INVOICE_ID)   INVOICE_ID,
                            SKU_DTLS.SKU                    SKU,
                            SKU_DTLS. DESCRIPTION           DESCRIPTION,
                            VOL_DTLS.VOLUME_LIFTED          VOLUME_LIFTED,
                            VOL_DTLS.BILL_ID,
                            VOL_DTLS.BILL_CUS_ID            BILL_CUS_ID
                    FROM
                             (SELECT
                                                                RCTA.TRX_NUMBER                 INVOICE_ID,
                                                                RCTLA.QUANTITY_INVOICED         VOLUME_LIFTED,
                                                                RCTLA.INVENTORY_ITEM_ID         INV_ID,
                                                                RCTA.BILL_TO_SITE_USE_ID        BILL_ID,
                                                                RCTA.BILL_TO_CUSTOMER_ID        BILL_CUS_ID
                              FROM 
                              ar.ra_customer_trx_lines_all RCTLA,
                              AR.RA_CUSTOMER_TRX_ALL  RCTA
                              WHERE  RCTA.CUSTOMER_TRX_ID=RCTLA.CUSTOMER_TRX_ID
                              and RCTA.TRX_NUMBER='1') VOL_DTLS,
                              (SELECT 
                                                                MSIB.INVENTORY_ITEM_ID   INV_ID,
                                                                MSIB.SEGMENT1    SKU,
                                                                MSIB.DESCRIPTION DESCRIPTION
                               FROM
                              inv.mtl_system_items_b       MSIB) SKU_DTLS
                    WHERE VOL_DTLS.INV_ID=SKU_DTLS.INV_ID
                    )KKK
                    
      WHERE HCA.CUST_ACCOUNT_ID=HCASA.CUST_ACCOUNT_ID
      AND  HCASA.CUST_ACCT_SITE_ID=HCSUA.CUST_ACCT_SITE_ID
      AND  HCA.CUST_ACCOUNT_ID=KKK.BILL_CUS_ID
      AND HAOU.ORGANIZATION_ID=HCSUA.WAREHOUSE_ID
      AND  HCSUA.SITE_USE_CODE='BILL_TO'
      AND HAOU.ATTRIBUTE1='DEPOT';
             
                    
                    
                   