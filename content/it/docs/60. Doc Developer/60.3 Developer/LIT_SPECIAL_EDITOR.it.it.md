# LIT_SPECIAL_EDITOR

Plug-in da associare SEMPRE con quello di base *SpecialEditor(org.idempiere.ui.zk.specialeditor)*



Per associare i campi per la modifica con SpecialEditor, devono avere dei requisiti:

```java
SpecialEditorWindow.java
....
[da riga 73]
GridTab tab = panel.getActiveGridTab();
		PO po = tab.getTableModel().getPO(tab.getCurrentRow());
		for (GridField field : tab.getFields()) {
			if (   field.isDisplayed(true)
				/* iDempiere Consulting
				&& !field.isAlwaysUpdateable()
				&& !field.isReadOnly()
				*/
				&& field.getDisplayType() != DisplayType.Button) {
				if (canEdit(tab, field, po)) {
					//iDempiereConsulting __ 15/10/2018
					if(field.isReadOnly()) {
						field.getVO().IsReadOnly = false;
					}
					//
					enabledFields.appendItem(field.getHeader(), field);
				}
			}
		}
.....
```

Il metodo ***canEdit*** permette di impostare o customizzare, tramite codice, i campi che si vogliono attivare alla modifica

```java
SpecialEditorWindow.java
....
[da riga 236]
private boolean canEdit(GridTab mTab, GridField mField, PO po) {
//		List<ISpecialEditCallout> callouts = findCallout(mTab.getTableName(), mField.getColumnName());
		List<ISpecialEditCallout> callouts = findCallout(mTab.getTableName());
		if (callouts != null && !callouts.isEmpty()) {
			for (ISpecialEditCallout co : callouts)
			{
				if (!co.canEdit(mTab, mField, po)) {
					return false;
				}
			}
			return true;
		}
		return false;
	}
.....
```

La gestione dei campi che si vogliono attivare, viene fatta tramite l'interfaccia java ***ISpecialEditCallout.java***; questa classe viene implementata nelle classi di gestione di modifica campi ----> una classe per ogni tabella.....

Qui di seguito una classe di esempio

```java
public class SpecialEditC_Invoice implements ISpecialEditCallout {

	@Override
	public boolean canEdit(GridTab mTab, GridField mField, PO po) {
		////
		if(po.get_TableName().equals(MInvoice.Table_Name) && 
			(mField.getColumnName().equals(MInvoice.COLUMNNAME_C_Activity_ID) || 
				mField.getColumnName().equals(MInvoice.COLUMNNAME_C_Project_ID) ||
				mField.getColumnName().equals(MInvoice.COLUMNNAME_DateAcct) ||
				mField.getColumnName().equals(MInvoice.COLUMNNAME_DateInvoiced))
		)
			return true;
		//
	
		return false;
	}
.............
.........
}
```

In questo caso, si permette allo specialEditor di applicare modifiche nella maschera/tabella Fatture/*C_Invoice* ai campi **C_Activity_ID - C_Project_ID - DateAcct - DateInvoiced**

Così si ha a disposizione l'elenco dei campi modificabili; quando viene scelto campo e inserito il valore da modificare, al momento del "OK", si avvia la modifica in step....

```java
SpecialEditorWindow.java
....
[da riga 171]
private void update(GridTab mTab, GridField mField, PO po, Object newValue) {
		// Code to call preEdit, updateEdit, postEdit
		
//		List<ISpecialEditCallout> callouts = findCallout(mTab.getTableName(), mField.getColumnName());
		List<ISpecialEditCallout> callouts = findCallout(mTab.getTableName());
		if (callouts != null && !callouts.isEmpty()) {
			ISpecialEditCallout co = callouts.get(0);

			if (!co.preEdit(mTab, mField, po)) {
				throw new AdempiereException("error in preEdit : " + co);
			} else {
				if (!co.updateEdit(mTab, mField, po, newValue)) {
					throw new AdempiereException("error in updateEdit : " + co);
				} else {
					if (!co.postEdit(mTab, mField, po)) {
						throw new AdempiereException("error in postEdit : " + co);
					} 
//					else {
//						System.out.println("yiipiiie !!!");
//					}
				}
			}
		}
	}
........
```

Anche in questo caso viene fatta con la classe interfaccia java implementata  ***ISpecialEditCallout.java***.    
Il metodo ***preEdit*** permette ad esempio di cancellare il POST di un documento 

```java
public class SpecialEditC_Invoice implements ISpecialEditCallout {
....
....
	@Override
	public boolean preEdit(GridTab mTab, GridField mField, PO po) {
//		System.out.println("preEdit " + mTab + " - " + mField + " - "+ po);
		SpecialEditorUtils.deletePosting(new MInvoice(Env.getCtx(), (Integer) mTab.getValue("C_Invoice_ID"), null));
		return true;
	}
....
....

```

Nel metodo ***updateEdit*** avviene la modifica del dato

```java
public class SpecialEditC_Invoice implements ISpecialEditCallout {
....
....
	@Override
	public boolean updateEdit(GridTab mTab, GridField mField, PO po, Object newValue) {

		//		po.set_ValueOfColumn("C_Charge_ID", newValue);
		//		po.saveEx(); it can't be done using PO as you can't save a MInvoiceLine when its parent is processed

		MInvoice il = new MInvoice(Env.getCtx(), mTab.getRecord_ID(), null);
		if(mField.getColumnName().equals(MInvoice.COLUMNNAME_C_Activity_ID))
			il.setC_Activity_ID((Integer) newValue);
		if(mField.getColumnName().equals(MInvoice.COLUMNNAME_C_Project_ID))
			il.setC_Project_ID((Integer) newValue);
		if(mField.getColumnName().equals(MInvoice.COLUMNNAME_DateAcct)) {
			il.setDateAcct((java.sql.Timestamp) newValue);
			if(il.isSOTrx())
				il.setDateInvoiced(il.getDateAcct());
		}
		if(mField.getColumnName().equals(MInvoice.COLUMNNAME_DateInvoiced)) {
			il.setDateInvoiced((java.sql.Timestamp) newValue);
		}
		
		il.saveEx();

		return true;
	}
......
......
```

Il metodo ***postEdit***  e quindi a modifica fatta e salvata, permette ad esempio di rimpostare il POST di un documento 

```java
public class SpecialEditC_Invoice implements ISpecialEditCallout {
....
....
	@Override
	public boolean postEdit(GridTab mTab, GridField mField, PO po) {
//		System.out.println("postEdit " + mTab + " - " + mField + " - "+ po);
		// Repost invoice
		SpecialEditorUtils.post(mTab, new MInvoice(Env.getCtx(), (Integer) mTab.getValue("C_Invoice_ID"), null));

		//Refresh
		SpecialEditorUtils.refresh(mTab);
		return true;
	}
....
....
```

È importante ricordarsi che ogni classe java di specialEditor creata, deve avere un componente OSGI corrispondente per farlo funzionare
![LIT_SpecialEditor_1](/opt/md/images/lit_SpecialEditor_1.png)

```xml
specialeditc_invoice.xml

<?xml version="1.0" encoding="UTF-8"?>
<scr:component xmlns:scr="http://www.osgi.org/xmlns/scr/v1.1.0" name="org.idempiere.extend.specialeditorc_invoice">
   <implementation class="it.cnet.idempiere.LIT_SpecialEditor.SpecialEditC_Invoice"/>
   <service>
      <provide interface="org.idempiere.base.ISpecialEditCallout"/>t"/>
   </service>
   <property name="tableName" type="String" value="C_Invoice"/>
</scr:component>

```

