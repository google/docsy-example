# Rule

---

- - <http://ayaz-ahmed.blogspot.it/2011/04/adempiere-callout-implemetation.html>
  - <http://wiki.adempiere.net/index.php/Rule_Engine_Implementation>
  - <http://wiki.adempiere.net/Script_ModelValidatorLogin>
  - <http://wiki.adempiere.net/Script_ModelValidator>

- - <http://wiki.idempiere.net/en/Script_Process>
  - <http://wiki.adempiere.net/Callout>

```
  http://www.adempiere.com/Callout
```

- - <http://wiki.idempiere.net/en/Script_Callout>

- - <http://wiki.adempiere.net/Script_Process>
  - <http://wiki.adempiere.net/Script_ModelValidatorLogin>
  - <http://wiki.adempiere.net/Examples:_Callout_and_Process_in_Groovy>

<https://groups.google.com/forum/#!msg/idempiere/8oB5JBpuhzc/32GxSmUuphQJ>

- - only adempiere <http://www.adempiere.com/Script_Editor_Tool>

<http://www.adempiere.com/Examples:_Callout_and_Process_in_Groovy>

[![ContextVariables.png](http://192.168.178.102/images/thumb/8/8a/ContextVariables.png/700px-ContextVariables.png)](http://192.168.178.102/index.php/File:ContextVariables.png)

Contents  [[hide](http://192.168.178.102/index.php/Rule#)] [1 RULE](http://192.168.178.102/index.php/Rule#RULE)[1.1 **beanshell:task_EDI_SafetyFromId_BP**](http://192.168.178.102/index.php/Rule#beanshell:task_EDI_SafetyFromId_BP)[1.2 **groovy:Closed_to_Drafted**](http://192.168.178.102/index.php/Rule#groovy:Closed_to_Drafted)[1.3 beanshell:asset_Withdrawal_amount](http://192.168.178.102/index.php/Rule#beanshell:asset_Withdrawal_amount)[1.4 **beanshell:asset_WithdrawalLine_imp_old**](http://192.168.178.102/index.php/Rule#beanshell:asset_WithdrawalLine_imp_old)

## RULE

### **beanshell:task_EDI_SafetyFromId_BP**

*Callout che mi consente di far partire un task da un Button* :

[![Rule EDI.png](http://192.168.178.102/images/thumb/2/2b/Rule_EDI.png/900px-Rule_EDI.png)](http://192.168.178.102/index.php/File:Rule_EDI.png)

### **groovy:Closed_to_Drafted**

*Processo che mi consente di riportare un documento da Closed a Drafted* :

[![Rule ReopenDocument.png](http://192.168.178.102/images/thumb/6/66/Rule_ReopenDocument.png/700px-Rule_ReopenDocument.png)](http://192.168.178.102/index.php/File:Rule_ReopenDocument.png)

### beanshell:asset_Withdrawal_amount

JSR 223 Scripting APIs import it.cnet.idempiere.model.X_A_Asset_WithdrawalLine; import org.compiere.model.MAsset; import java.math.BigDecimal;

if(A_Tab.getValue("A_Asset_ID") != null) {

```
  MAsset asset = new MAsset(A_Ctx, A_Tab.getValue("A_Asset_ID"),null);
  BigDecimal count = new BigDecimal(asset.getLastMaintenanceUnit());
  count = count.multiply(A_Tab.getValue("CashAmt"));
  A_Tab.setValue("DrawerAmt", count);
  asset = null;
```

} result="";

### **beanshell:asset_WithdrawalLine_imp_old**

import it.cnet.idempiere.model.MContractLine; import java.math.BigDecimal;

if(A_Tab.getValue("a_countout") != null) {

```
  MContractLine contractLine = new MContractLine(A_Ctx, 0, null) ;
  MContractLine contrLineAsset = null;
  contrLineAsset = contractLine.getLineFromAsset(A_Tab.getValue("A_Asset_ID"));
  BigDecimal networkRate= contrLineAsset.getNetworkRate();
  BigDecimal customerRate= contrLineAsset.getCustomerRate();
  
  A_Tab.setValue("NetworkRate", networkRate);
  A_Tab.setValue("CustomerRate", customerRate);
  A_Tab.setValue("BaseValue", contrLineAsset.getBaseValue());
  A_Tab.setValue("DetractValue", contrLineAsset.getDetractValue());
```

//difference countin and countout

```
  BigDecimal countIN_DIFF = A_Tab.getValue("a_countin").subtract(contrLineAsset.geta_countin());
  BigDecimal countOUT_DIFF = A_Tab.getValue("a_countout").subtract(contrLineAsset.geta_countout());
  A_Tab.setValue("a_countinDiff", countIN_DIFF);
  A_Tab.setValue("a_countoutDiff", countOUT_DIFF);
```

// //grossProfit

```
  BigDecimal grossProfit = countIN_DIFF.subtract(countOUT_DIFF);
  A_Tab.setValue("a_grossprofit", grossProfit);
```

// //taxPreu

```
  BigDecimal taxPreu = countIN_DIFF.multiply(new BigDecimal(0.127));
  A_Tab.setValue("a_taxpreu", taxPreu);
```

// //taxAams

```
  BigDecimal taxAams = countIN_DIFF.multiply(new BigDecimal(0.008));
  A_Tab.setValue("a_taxaams", taxAams);
```

// //netProfit

```
  BigDecimal netProfit = grossProfit.subtract(taxPreu).subtract(taxAams);
  A_Tab.setValue("a_netprofit", netProfit);
```

// //networkCost

```
  BigDecimal networkCost = countIN_DIFF.multiply(networkRate);
  A_Tab.setValue("a_networkcost", networkCost);
```

// //profitBPartner

```
  BigDecimal profitBPartner = countIN_DIFF.multiply(customerRate);
  A_Tab.setValue("a_profit_bpartner", profitBPartner);
```

//

```
  contrLineAsset.seta_countin(A_Tab.getValue("a_countin"));
  contrLineAsset.seta_countout(A_Tab.getValue("a_countout"));
  contrLineAsset.saveEx();
  contractLine = null;
  contrLineAsset = null;
```

} result 