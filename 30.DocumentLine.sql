-- drop table DocumentLine

if object_id('DocumentLine') is null
create table DocumentLine(
	Id							int not null identity(1,1) primary key,

	Document_Id					int not null references DocumentHeader(id),
	
	ItemCode					varchar(20) not null,							-- a charge, a payment, etc
	PackageCode					varchar(20)     null,							-- if any

	TransactionType				int,			
	Pieces						decimal(19,4),
	PaxPieces					int,
	UnitPrice					decimal(19,4),

	DiscountAmount				decimal(19,4),
	TotalAmount					decimal(19,4),									-- always local currency

	TransactionDate				date,
	BusinessDate				date,
	
	TaxAmount					decimal(19,4),
	TaxCode						varchar(20),
	TaxPercentage				decimal(19,4),
	TaxExemptionCode			varchar(20) null,

	ForeignUnitPrice			decimal(19,4) null,
	ForeignDiscountAmount		decimal(19,4) null,
	ForeignTotalAmount			decimal(19,4) null,									
	ForeignTaxAmount			decimal(19,4) null,

	ForeignCurrencyCode			varchar(10) null,								-- if different from local currency

	IsAutomatic					bit not null default 0,
	ExternalDescription			nvarchar(100) null,								-- example: telephone dialed
	ExternalReference			varchar(50) null,								-- avoiding duplication for interface postings
	
	IsPackage					bit,
	PackageAggregator			int null,

	PrintDescription			nvarchar(100),

	ComplimentaryStatus			int,
	IsVoid						bit not null default 0,
	VoidReson					nvarchar(100),

	RelatedTransaction_Id		int null references DocumentLine(id),			-- can point to the original transaction in case of void; or to the deposit, in case of deposit usage

	Reservation_Id				int null,
	Guest_id					int null,
	OriginalRoom_Id				int null,
	OriginalDocument_Id			int null references DocumentHeader(id),			-- useful to trace the origin of the transaction
	

	StatPriceList				varchar(20),
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


	[CreatedByUserId]			int not null references T_USER(id),
	[UpdatedByUserId]			int not null references T_USER(id),

	[CreatedByCashboxId]		int not null references T_CASHBOX(id),
	[UpdatedByCashboxId]		int not null references T_CASHBOX(id),

	[CreatedOn]					datetime default getdate(),
	[LastUpdate]				datetime default getdate()
	
)

-- select top 100 * from t_booking order by id desc