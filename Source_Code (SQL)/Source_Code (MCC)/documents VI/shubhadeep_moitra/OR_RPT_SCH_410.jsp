<%@ taglib uri="/WEB-INF/lib/reports_tld.jar" prefix="rw" %> 
<%@ page language="java" import="java.io.*" errorPage="/rwerror.jsp" session="false" %>
<%@ page contentType="text/html;charset=ISO-8859-1" %>
<!--
<rw:report id="report"> 
<rw:objects id="objects">
<?xml version="1.0" encoding="WINDOWS-1252" ?>
<report name="OR_RPT_SCH_410" DTDVersion="9.0.2.0.10">
  <xmlSettings xmlTag="MODULE2" xmlPrologType="text">
  <![CDATA[<?xml version="1.0" encoding="&Encoding"?>]]>
  </xmlSettings>
  <data>
    <dataSource name="Q_1">
      <select canParse="no">
      <![CDATA[SELECT AB.REGION  REGION,
       AB.DEPO_NAME DEPO_NAME,
       AB.CUST_ACC_NO CUST_ACC_NO,
       AB.CUST_NAME CUST_NAME,
       AB.LY_VOL    LY_VOL,
       GH.LY_VOL  TY_VOL
FROM
(SELECT
CUST_DTLS.REGION        REGION,
CUST_DTLS.DEPO_NAME     DEPO_NAME,
CUST_DTLS.CUST_ACC_NO   CUST_ACC_NO,
CUST_DTLS.CUST_NAME     CUST_NAME,
SUM(VOL_DTLS.FNL_VOL)   LY_VOL
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
                  ,NVL(BPIL.BPIL_INVOICE_UOM (MSIB.INVENTORY_ITEM_ID,MSIB.SECONDARY_UOM_CODE),0) PACK_SIZE
                  ,MSIB.DESCRIPTION
              FROM INV.MTL_SYSTEM_ITEMS_B     MSIB
             WHERE MSIB.ORGANIZATION_ID =83
               AND MSIB.SEGMENT1 NOT LIKE '%BULK%'
               AND MSIB.INVENTORY_ITEM_STATUS_CODE = 'Active'
               AND SUBSTR(MSIB.SEGMENT1,1,6) IN ('F00000','F00042')
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
SUM(VOL_DTLS1.FNL_VOL)   LY_VOL
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
                  ,NVL(BPIL.BPIL_INVOICE_UOM (MSIB.INVENTORY_ITEM_ID,MSIB.SECONDARY_UOM_CODE),0) PACK_SIZE
                  ,MSIB.DESCRIPTION
              FROM INV.MTL_SYSTEM_ITEMS_B     MSIB
             WHERE MSIB.ORGANIZATION_ID =83
               AND MSIB.SEGMENT1 NOT LIKE '%BULK%'
               AND MSIB.INVENTORY_ITEM_STATUS_CODE = 'Active'
               AND SUBSTR(MSIB.SEGMENT1,1,6) IN ('F00000','F00042')
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
      AND AB.CUST_NAME=GH.CUST_NAME;
   
]]>
      </select>
      <displayInfo x="1.51038" y="1.08337" width="0.69995" height="0.19995"/>
      <group name="G_REGION">
        <displayInfo x="1.13928" y="1.78333" width="1.44214" height="2.48145"
        />
        <dataItem name="REGION" datatype="vchar2" columnOrder="11" width="8"
         defaultWidth="80000" defaultHeight="10000" columnFlags="1"
         defaultLabel="Region">
          <dataDescriptor expression="REGION" descriptiveExpression="REGION"
           order="1" width="8"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="DEPO_NAME" datatype="vchar2" columnOrder="12"
         width="944" defaultWidth="100000" defaultHeight="10000"
         columnFlags="1" defaultLabel="Depo Name">
          <dataDescriptor expression="DEPO_NAME"
           descriptiveExpression="DEPO_NAME" order="2" width="944"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="CUST_ACC_NO" datatype="vchar2" columnOrder="13"
         width="30" defaultWidth="100000" defaultHeight="10000"
         columnFlags="1" defaultLabel="Cust Acc No">
          <dataDescriptor expression="CUST_ACC_NO"
           descriptiveExpression="CUST_ACC_NO" order="3" width="30"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="CUST_NAME" datatype="vchar2" columnOrder="14"
         width="240" defaultWidth="100000" defaultHeight="10000"
         columnFlags="1" defaultLabel="Cust Name">
          <dataDescriptor expression="CUST_NAME"
           descriptiveExpression="CUST_NAME" order="4" width="240"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <formula name="CF_1" source="cf_1formula" datatype="number" width="20"
         precision="10" defaultWidth="0" defaultHeight="0" columnFlags="16"
         breakOrder="none">
          <displayInfo x="0.00000" y="0.00000" width="0.00000"
           height="0.00000"/>
        </formula>
        <dataItem name="LY_VOL" oracleDatatype="number" columnOrder="15"
         width="22" defaultWidth="20000" defaultHeight="10000" columnFlags="1"
         defaultLabel="Ly Vol">
          <dataDescriptor expression="LY_VOL" descriptiveExpression="LY_VOL"
           order="5" width="22" scale="-127"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <placeholder name="TARGET" datatype="number" width="20" precision="10"
         defaultWidth="0" defaultHeight="0" columnFlags="16">
          <displayInfo x="0.00000" y="0.00000" width="0.00000"
           height="0.00000"/>
        </placeholder>
        <dataItem name="TY_VOL" oracleDatatype="number" columnOrder="16"
         width="22" defaultWidth="20000" defaultHeight="10000" columnFlags="1"
         defaultLabel="Ty Vol">
          <dataDescriptor expression="TY_VOL" descriptiveExpression="TY_VOL"
           order="6" width="22" scale="-127"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <placeholder name="GIFT" datatype="number" width="20" precision="10"
         defaultWidth="0" defaultHeight="0" columnFlags="16">
          <displayInfo x="0.00000" y="0.00000" width="0.00000"
           height="0.00000"/>
        </placeholder>
      </group>
    </dataSource>
  </data>
  <programUnits>
    <function name="cf_1formula" returnType="number">
      <textSource>
      <![CDATA[function CF_1Formula return Number is
begin
	IF :LY_VOL>=0
  THEN
	:TARGET:=:LY_VOL+(:LY_VOL*0.05);
	ELSE
	 :TARGET:=:LY_VOL+(-(:LY_VOL*0.05));
	END IF;
	 
	IF(:TY_VOL>=:TARGET)
		THEN
		  IF
		  	:TY_VOL>=1000
		  	  THEN
		  	    :GIFT:='AIR CODITIONER';
		  ELSE 
		  	IF :TY_VOL>=500
		  	    THEN
		  	      :GIFT:='REFRIGERATOR';
		  	ELSE
		  		
		  	   IF :TY_VOL>=250
		  	     THEN
		  	       :GIFT:='COOLER';
		  	   ELSE
		  	   	   :GIFT:='NO GIFT';
		  	   END IF;
		  	 END IF;
		  END IF;
		  ELSE
		  :GIFT:='NO GIFT';
	END IF;
RETURN 0;
 end;]]>
      </textSource>
    </function>
  </programUnits>
  <reportPrivate versionFlags2="0" templateName="rwbeige"/>
  <reportWebSettings>
  <![CDATA[]]>
  </reportWebSettings>
</report>
</rw:objects>
-->

<html>

<head>
<meta name="GENERATOR" content="Oracle 9i Reports Developer"/>
<title> Your Title </title>

<rw:style id="yourStyle">
   <!-- Report Wizard inserts style link clause here -->
</rw:style>

</head>


<body>

<rw:dataArea id="yourDataArea">
   <!-- Report Wizard inserts the default jsp here -->
</rw:dataArea>



</body>
</html>

<!--
</rw:report> 
-->
