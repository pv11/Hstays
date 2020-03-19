-- drop table Tax

if object_id('Tax') is null
create table Tax(
	Id							int not null identity(2000,1) primary key,
	HotelId						uniqueidentifier not null,

	Code						nvarchar(100) not null, 
	Description					nvarchar(100) not null,

	ValidForCountryCode			varchar(10) not null,					-- country code (Alpha-3)
	
	SortOrder					int not null default 100,
	Notes						varchar(max) null,
	IsActive					bit not null default 1,
	Deleted						bit not null default 0,

	SaftCode					varchar(20) null,

	[CreatedByUserId]			int  null ,
	[UpdatedByUserId]			int  null ,

	[CreatedOn]					datetime default getdate(),
	[LastUpdate]				datetime default getdate()
	
)


if not exists(select * from Tax)
 begin
	insert into Tax (HotelId,Code,Description,ValidForCountryCode,SaftCode)
	values ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'ISE', 'Isento', 'PT','ISE'),
	       ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'RED', 'Reduzido', 'PT','RED'),
	       ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'INT', 'Intermédio', 'PT','INT'),
		   ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'NOR', 'Normal', 'PT','NOR')
 end

 select * from Tax

