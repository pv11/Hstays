-- drop table TaxDetail

if object_id('TaxDetail') is null
create table TaxDetail(
	Id							int not null identity(2010,1) primary key,
	Tax_Id						int not null references Tax(id),


	ValidFrom					date,
	ValidTo						date,									--exclusive date, in order to keed same logic as in reservations, etc

	Amount						decimal(19,4),	

	Notes						varchar(max) null,
	
	Deleted						bit not null default 0,

	

	[CreatedByUserId]			int  null ,
	[UpdatedByUserId]			int  null ,

	[CreatedOn]					datetime default getdate(),
	[LastUpdate]				datetime default getdate()
	
)


if not exists(select * from TaxDetail)
 begin
	insert into TaxDetail (Tax_id,ValidFrom,ValidTo,Amount)
	values ( (select top 1 id from Tax where code = 'ISE')  , '20000101', '20990101', 0),
	       ( (select top 1 id from Tax where code = 'RED')  , '20000101', '20140101', 6),
		   ( (select top 1 id from Tax where code = 'RED-RAM')  , '20140101', '20990101', 4),
		   ( (select top 1 id from Tax where code = 'RED-RAA')  , '20140101', '20990101', 5),

	       ( (select top 1 id from Tax where code = 'INT')  , '20000101', '20140101', 12.5),
		   ( (select top 1 id from Tax where code = 'INT')  , '20140101', '20990101', 13),

	       ( (select top 1 id from Tax where code = 'NOR')  , '20000101', '20140101', 25),
		   ( (select top 1 id from Tax where code = 'NOR')  , '20140101', '20990101', 23)


 end

 select * from TaxDetail



