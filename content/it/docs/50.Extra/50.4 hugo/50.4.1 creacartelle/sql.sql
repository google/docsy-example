\copy (select '1' as lvl, '/' as dir, replace(replace(i1.value||'.'||i1.Name2, ',', ''), '/', '') as subdir 
from ad_treenode t1 
inner join lit_infodoc i1 on t1.node_id=i1.lit_infodoc_id 
where t1.ad_tree_ID=1000010 
and t1.parent_id=0 
and i1.issummary='Y' 

union 
select '2', replace('/'||i1.value||'.'||i1.Name2, ',', ''), 
replace(replace(i2.value||'.'||i2.Name2, ',', ''), '/', '') 
from ad_treenode t1 
inner join ad_treenode t2 on t1.node_id=t2.parent_id 
inner join lit_infodoc i1 on t1.node_id=i1.lit_infodoc_id 
inner join lit_infodoc i2 on t2.node_id=i2.lit_infodoc_id 
where t1.ad_tree_ID=1000010 
and t2.ad_tree_ID=1000010 
and t1.parent_id=0 and i2.issummary='Y' 

union 
select '3', replace('/'||i1.value||'.'||i1.Name2||'/'||i2.value||'.'||i2.Name2, ',', ''), 
replace(replace(i3.value||'.'||i3.Name2, ',', ''), '/', '') 
from ad_treenode t1 
inner join ad_treenode t2 on t1.node_id=t2.parent_id 
inner join ad_treenode t3 on t2.node_id=t3.parent_id 
inner join lit_infodoc i1 on t1.node_id=i1.lit_infodoc_id 
inner join lit_infodoc i2 on t2.node_id=i2.lit_infodoc_id 
inner join lit_infodoc i3 on t3.node_id=i3.lit_infodoc_id 
where t1.ad_tree_ID=1000010 
and t2.ad_tree_ID=1000010 
and t3.ad_tree_ID=1000010 
and t1.parent_id=0 
and i3.issummary='Y' 

union 
select '4', replace('/'||i1.value||'.'||i1.name2||'/'||i2.value||'.'||i2.name2||'/'||i3.value||'.'||i3.name2, ',', ''), 
replace(replace(i4.value||'.'||i4.Name2, ',', ''), '/', '') 
from ad_treenode t1 
inner join ad_treenode t2 on t1.node_id=t2.parent_id 
inner join ad_treenode t3 on t2.node_id=t3.parent_id 
inner join ad_treenode t4 on t3.node_id=t4.parent_id 
inner join lit_infodoc i1 on t1.node_id=i1.lit_infodoc_id 
inner join lit_infodoc i2 on t2.node_id=i2.lit_infodoc_id 
inner join lit_infodoc i3 on t3.node_id=i3.lit_infodoc_id 
inner join lit_infodoc i4 on t4.node_id=i4.lit_infodoc_id 
where t1.ad_tree_ID=1000010 
and t2.ad_tree_ID=1000010 
and t3.ad_tree_ID=1000010 
and t4.ad_tree_ID=1000010 
and t1.parent_id=0 
and i4.issummary='Y' 

union 
select '5', replace('/'||i1.value||'.'||i1.name2||'/'||i2.value||'.'||i2.name2||'/'||i3.value||'.'||i3.name2||'/'||i4.value||'.'||i4.name2, ',', ''), replace(replace(i5.value||'.'||i5.Name2, ',', ''), '/', '') 
from ad_treenode t1 
inner join ad_treenode t2 on t1.node_id=t2.parent_id 
inner join ad_treenode t3 on t2.node_id=t3.parent_id 
inner join ad_treenode t4 on t3.node_id=t4.parent_id 
inner join ad_treenode t5 on t4.node_id=t5.parent_id 
inner join lit_infodoc i1 on t1.node_id=i1.lit_infodoc_id 
inner join lit_infodoc i2 on t2.node_id=i2.lit_infodoc_id 
inner join lit_infodoc i3 on t3.node_id=i3.lit_infodoc_id 
inner join lit_infodoc i4 on t4.node_id=i4.lit_infodoc_id 
inner join lit_infodoc i5 on t5.node_id=i5.lit_infodoc_id 
where t1.ad_tree_ID=1000010 
and t2.ad_tree_ID=1000010 
and t3.ad_tree_ID=1000010 
and t4.ad_tree_ID=1000010 
and t5.ad_tree_ID=1000010 
and t1.parent_id=0 
and i5.issummary='Y' order by lvl, dir, subdir ) to 'cartelle.csv' with csv
