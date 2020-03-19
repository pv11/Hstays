
-- drop table Attribute

if object_id('Attribute') is null
create table Attribute(
	Id						int not null identity(1050,1) primary key,
	HotelId					uniqueidentifier not null,
	Active					bit not null default 1,

	[Type]					int not null references AttributeType(id),

	Code					nvarchar(100) not null, 
	Description				nvarchar(100) not null,

	IsChildrenOf			int null references Attribute(id),			-- allow hierarquies

	Notes					varchar(max),

	SortOrder				int not null default 100,
	Deleted					bit not null default 0,

	[CreatedByUserId]		int   null ,
	[UpdatedByUserId]		int   null ,

	[CreatedOn]				datetime default getdate(),
	[LastUpdate]			datetime default getdate()

)

if not exists(select * from Attribute)
 begin
	insert into Attribute (HotelId,[Type],IsChildrenOf, Code,Description)
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='SALES-GROUP'), null, 'ROOM','Room Revenue'
	UNION
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='SALES-GROUP'), null, 'FB','Food & Beverage'
	UNION
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='SALES-GROUP'), null, 'SPA','Spa & Thermal'
	UNION
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='SALES-GROUP'), null, 'SPORT','Sports'
	UNION
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='SALES-GROUP'), null, 'ETC','Other'

	insert into Attribute (HotelId,[Type],IsChildrenOf, Code,Description)
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='FAMILY'), (select top 1 id from Attribute where Code='ROOM'), 'F1','Family 1'
	UNION
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='FAMILY'), (select top 1 id from Attribute  where Code='ETC'), 'F2','Family 2'
	UNION
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='FAMILY'), (select top 1 id from Attribute  where Code='ETC'), 'F2','Family 3'


	insert into Attribute (HotelId,[Type],IsChildrenOf, Code,Description)
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='SUBFAMILY'), (select top 1 id from Attribute  where Code='F1'), 'SF_A1','Subfamily A1'
	UNION
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='SUBFAMILY'), (select top 1 id from Attribute  where Code='F1'), 'SF_A2','Subfamily A2'
	UNION
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='SUBFAMILY'), (select top 1 id from Attribute  where Code='F2'), 'SF_B1','Subfamily B1'
	UNION
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='SUBFAMILY'), (select top 1 id from Attribute  where Code='F2'), 'SF_B2','Subfamily B2'
	UNION
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='SUBFAMILY'), (select top 1 id from Attribute  where Code='F3'), 'SF_C1','Subfamily C1'
	UNION
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='SUBFAMILY'), (select top 1 id from Attribute  where Code='F4'), 'SF_C2','Subfamily C2'


	insert into Attribute (HotelId,[Type],IsChildrenOf, Code,Description)
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='GROUP'), null, 'G1','Group 1'
	UNION
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='GROUP'), null, 'G2','Group 2'
	UNION
	select 'D348E3AF-D306-41D6-AB7F-840B1BC96819',(select top 1 id from AttributeType where code='GROUP'), null, 'G3','Group 3'

 end

select * from Attribute

/*
	values ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'SALES-GROUP', 'Sales Group'),
	       ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'FAMILY', 'Family'),
	       ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'SUBFAMILY', 'Subfamily'),
		   ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'GROUP', 'Group')

		   */