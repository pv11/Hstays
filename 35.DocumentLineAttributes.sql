-- drop table DocumentLine

if object_id('DocumentLineAttributes') is null
create table DocumentLineAttributes(
	Id							int not null identity(1,1) primary key,

	DocumentLine_Id				int not null references DocumentLine(id),	

	
	StatPriceList				varchar(20),			-- move to differnet table
	StatProfitCenter			varchar(20),
	StatFamily					varchar(20),
	StatSubFamily				varchar(20),
	StatChargeGroup				varchar(20),
	StatSegment					varchar(20),
	StatSubSegment				varchar(20),
	StatDistributionChannel		varchar(20),

	StatGuestNationality		varchar(20),
	
	RevenueAccount1				varchar(50),
	RevenueAccount2				varchar(50),
	RevenueAccount3				varchar(50),

	TaxAccount1					varchar(50),
	TaxAccount2					varchar(50),
	TaxAccount3					varchar(50),

	IsValid						bit not null default 1,    -- in case of multiple records (histrory, etc) for teh same DocumentLine_Id, only 1 can be valid

	[CreatedByUserId]			int not null references T_USER(id),
	
	[CreatedOn]					datetime default getdate()
	
	
)

-- select top 100 * from t_booking order by id desc