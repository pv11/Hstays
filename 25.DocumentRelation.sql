-- drop table DocumentRelation

if object_id('DocumentRelation') is null
create table DocumentRelation(
	Id							int not null identity(1,1),

	SourceDocumentHeader_Id		int not null references DocumentHeader(id),
	TargetDocumentHeader_Id		int not null references DocumentHeader(id),

	SourceDocumentUsedAmount	decimal(19,4),
	SourceDocumentNewBalance	decimal(19,4),

	TargetDocumentUsedAmount	decimal(19,4),
	TargetDocumentNewBalance	decimal(19,4),

	LinkType					int,										-- to be defined. example: 1=Credit Note;2=Paymet Receipt
	OperationDescription		nvarchar(100)
	
)

