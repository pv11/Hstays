-- drop table Attribute ; drop table AttributeType
if object_id('AttributeType') is null
create table AttributeType(
	Id						int not null identity(1000,1) primary key,
	HotelId					uniqueidentifier not null,
	Active					bit not null default 1,
	SortOrder				int not null default 100,

	Code					nvarchar(20) not null, 
	Description				nvarchar(100) not null,

	Deleted					bit not null default 0,

	[CreatedByUserId]		int  null ,
	[UpdatedByUserId]		int  null ,

	[CreatedOn]				datetime default getdate(),
	[LastUpdate]			datetime default getdate()

)

if not exists(select * from AttributeType)
 begin
	insert into AttributeType (HotelId,Code,Description)
	values ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'SALES-GROUP', 'Sales Group'),
	       ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'FAMILY', 'Family'),
	       ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'SUBFAMILY', 'Subfamily'),
		   ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'GROUP', 'Group')
 end

 select * from AttributeType
