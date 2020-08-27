\copy (select '1' as lvl, '/'||
replace(replace(i2.value||'.'||i2.name2, ',', ''), '/', '') as dir, 
COALESCE (replace(replace(i1.name2, ',', ''), '/', ''), 
replace(replace(i1.Name, ',', ''), '/', ''), 'missing name') as name, 
replace(replace(regexp_replace(i1.help, E'[\n\r]+', '', 'g'),',' ,''), ',', '&#44') as help 
from lit_infodoc i1 
inner join ad_treenode t1 on i1.lit_infodoc_id=t1.node_id 
inner join ad_treenode t2 on t1.parent_id=t2.node_id 
inner join lit_infodoc i2 on t2.node_id=i2.lit_infodoc_id 
where i1.issummary='N' 
and i1.help is not null 
and i1.ad_client_id=0 
and t1.ad_tree_id=1000010 
and t2.ad_tree_id=1000010 
and t2.parent_id=0 
union 
select '2', '/'||
replace(replace(i3.value||'.'||i3.name2, ',', ''), '/', '')||'/'||
replace(replace(i2.value||'.'||i2.name2, ',', ''), '/', ''), 
COALESCE (replace(replace(i1.name2, ',', ''), '/', ''), 
replace(replace(i1.Name, ',', ''), '/', ''), 'missing name'), 
replace(replace(regexp_replace(i1.help, E'[\n\r]+', '', 'g'),',' ,''), ',', '&#44') 
from lit_infodoc i1 
inner join ad_treenode t1 on i1.lit_infodoc_id=t1.node_id 
inner join ad_treenode t2 on t1.parent_id=t2.node_id 
inner join ad_treenode t3 on t2.parent_id=t3.node_id 
inner join lit_infodoc i2 on t2.node_id=i2.lit_infodoc_id 
inner join lit_infodoc i3 on t3.node_id=i3.lit_infodoc_id 
where i1.issummary='N' 
and  i1.help is not null 
and  i1.ad_client_id=0 
and t1.ad_tree_id=1000010 
and t2.ad_tree_id=1000010 
and t3.ad_tree_id=1000010 
and t3.parent_id=0 
union 
select '3', '/'||
replace(replace(i4.value||'.'||i4.name2, ',', ''), '/', '')||'/'||
replace(replace(i3.value||'.'||i3.name2, ',', ''), '/', '')||'/'||
replace(replace(i2.value||'.'||i2.name2, ',', ''), '/', ''), 
COALESCE (replace(replace(i1.name2, ',', ''), '/', ''), 
replace(replace(i1.Name, ',', ''), '/', ''), 'missing name'), 
replace(replace(regexp_replace(i1.help, E'[\n\r]+', '', 'g'),',' ,''), ',', '&#44') 
from lit_infodoc i1 
inner join ad_treenode t1 on i1.lit_infodoc_id=t1.node_id 
inner join ad_treenode t2 on t1.parent_id=t2.node_id 
inner join ad_treenode t3 on t2.parent_id=t3.node_id 
inner join ad_treenode t4 on t3.parent_id=t4.node_id 
inner join lit_infodoc i2 on t2.node_id=i2.lit_infodoc_id 
inner join lit_infodoc i3 on t3.node_id=i3.lit_infodoc_id 
inner join lit_infodoc i4 on t4.node_id=i4.lit_infodoc_id 
where i1.issummary='N' 
and i1.help is not null 
and i1.ad_client_id=0 
and t1.ad_tree_id=1000010 
and t2.ad_tree_id=1000010 
and t3.ad_tree_id=1000010 
and t4.ad_tree_id=1000010 
and t4.parent_id=0 
union 
select '4', '/'||
replace(replace(i5.value||'.'||i5.name2, ',', ''), '/', '')||'/'||
replace(replace(i4.value||'.'||i4.name2, ',', ''), '/', '')||'/'||
replace(replace(i3.value||'.'||i3.name2, ',', ''), '/', '')||'/'||
replace(replace(i2.value||'.'||i2.name2, ',', ''), '/', ''), 
COALESCE (replace(replace(i1.name2, ',', ''), '/', ''), 
replace(replace(i1.Name, ',', ''), '/', ''), 'missing name'), 
replace(replace(regexp_replace(i1.help, E'[\n\r]+', '', 'g'),',' ,''), ',', '&#44') 
from lit_infodoc i1 
inner join ad_treenode t1 on i1.lit_infodoc_id=t1.node_id 
inner join ad_treenode t2 on t1.parent_id=t2.node_id 
inner join ad_treenode t3 on t2.parent_id=t3.node_id 
inner join ad_treenode t4 on t3.parent_id=t4.node_id 
inner join ad_treenode t5 on t4.parent_id=t5.node_id 
inner join lit_infodoc i2 on t2.node_id=i2.lit_infodoc_id 
inner join lit_infodoc i3 on t3.node_id=i3.lit_infodoc_id 
inner join lit_infodoc i4 on t4.node_id=i4.lit_infodoc_id 
inner join lit_infodoc i5 on t5.node_id=i5.lit_infodoc_id 
where i1.issummary='N' 
and i1.help is not null 
and i1.ad_client_id=0 
and t1.ad_tree_id=1000010 
and t2.ad_tree_id=1000010 
and t3.ad_tree_id=1000010 
and t4.ad_tree_id=1000010 
and t5.ad_tree_id=1000010 
and t5.parent_id=0 
union 
select '5', '/'||
replace(replace(i6.value||'.'||i6.name, ',', ''), '/', '')||'/'||
replace(replace(i5.value||'.'||i5.name2, ',', ''), '/', '')||'/'||
replace(replace(i4.value||'.'||i4.name2, ',', ''), '/', '')||'/'||
replace(replace(i3.value||'.'||i3.name2, ',', ''), '/', '')||'/'||
replace(replace(i2.value||'.'||i2.name2, ',', ''), '/', ''), 
COALESCE (replace(replace(i1.name2, ',', ''), '/', ''), 
replace(replace(i1.Name, ',', ''), '/', ''), 'missing name'), 
replace(replace(regexp_replace(i1.help, E'[\n\r]+', '', 'g'),',' ,''), ',', '&#44') 
from lit_infodoc i1 
inner join ad_treenode t1 on i1.lit_infodoc_id=t1.node_id 
inner join ad_treenode t2 on t1.parent_id=t2.node_id 
inner join ad_treenode t3 on t2.parent_id=t3.node_id 
inner join ad_treenode t4 on t3.parent_id=t4.node_id 
inner join ad_treenode t5 on t4.parent_id=t5.node_id 
inner join ad_treenode t6 on t5.parent_id=t6.node_id 
inner join lit_infodoc i2 on t2.node_id=i2.lit_infodoc_id 
inner join lit_infodoc i3 on t3.node_id=i3.lit_infodoc_id 
inner join lit_infodoc i4 on t4.node_id=i4.lit_infodoc_id 
inner join lit_infodoc i5 on t5.node_id=i5.lit_infodoc_id 
inner join lit_infodoc i6 on t6.node_id=i6.lit_infodoc_id 
where  i1.issummary='N' 
and i1.help is not null 
and i1.ad_client_id=0 
and t1.ad_tree_id=1000010 
and t2.ad_tree_id=1000010 
and t3.ad_tree_id=1000010 
and t4.ad_tree_id=1000010 
and t5.ad_tree_id=1000010 
and t6.ad_tree_id=1000010 
and t6.parent_id=0 order by lvl, dir) to 'listahelp.csv' with csv
