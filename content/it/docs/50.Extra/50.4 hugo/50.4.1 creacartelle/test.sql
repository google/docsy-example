\copy (select ad_language , msgtext  from AD_CtxHelpMsg_Trl where ad_language='it_IT' and ad_ctxhelpmsg_id='1000161' ) to 'help.csv' with csv
