CREATE PROCEDURE dbo.Puestos_Insert
    
	@Nombre varchar(250),
	@Salario varchar(250),	
	@Estado BIT
	
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY

		
		INSERT INTO dbo.Puestos
		(
	     Nombre
	    , Salario
	    , Estado 		
		)
		VALUES
		( 
		  @Nombre 
	    , @Salario	     
	    , @Estado 
		
		)


		COMMIT TRANSACTION TRASA
		
		SELECT 0 AS CodeError, '' AS MsgError



	END TRY

	BEGIN CATCH
		SELECT 
				ERROR_NUMBER() AS CodeError
			,	ERROR_MESSAGE() AS MsgError

			ROLLBACK TRANSACTION TRASA
	END CATCH


END