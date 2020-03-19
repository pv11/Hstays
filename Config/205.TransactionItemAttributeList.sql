-- drop table TransactionItemAttributeList
if object_id('TransactionItemAttributeList') is null
create table TransactionItemAttributeList(
	Id						int not null identity(4000,1) primary key,
	
	Item_id					int not null references TransactionItem(id),
	Attribute_id			int not null references Attribute(id),
	
	Deleted					bit not null default 0,

	[CreatedByUserId]		int  null ,
	[UpdatedByUserId]		int  null ,

	[CreatedOn]				datetime default getdate(),
	[LastUpdate]			datetime default getdate()

)

-- delete from TransactionItemAttributeList
if not exists(select * from TransactionItemAttributeList)
 begin
	insert into TransactionItemAttributeList (Item_id,Attribute_id)
	values	( (select top 1 id from TransactionItem where code='ROOM'), (select top 1 a.id from Attribute a inner join AttributeType t on a.Type=t.id where t.code='SALES-GROUP' and a.code='ROOM') ),
			( (select top 1 id from TransactionItem where code='ROOM'), (select top 1 a.id from Attribute a inner join AttributeType t on a.Type=t.id where t.code='FAMILY' and a.code='F2') ),
			( (select top 1 id from TransactionItem where code='ROOM'), (select top 1 a.id from Attribute a inner join AttributeType t on a.Type=t.id where t.code='SUBFAMILY' and a.code='SF_B1') )

	insert into TransactionItemAttributeList (Item_id,Attribute_id)
	values	( (select top 1 id from TransactionItem where code='CASH'), (select top 1 a.id from Attribute a inner join AttributeType t on a.Type=t.id where t.code='FAMILY' and a.code='F1') ),
			( (select top 1 id from TransactionItem where code='CASH'), (select top 1 a.id from Attribute a inner join AttributeType t on a.Type=t.id where t.code='SUBFAMILY' and a.code='SF_C2') )



 end

 select * from TransactionItemAttributeList


 -- select top 100 a.*, t.code from Attribute a inner join AttributeType t on a.Type=t.id


 --select * from Attribute