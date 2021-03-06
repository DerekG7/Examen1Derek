CREATE PROCEDURE dbo.Puestos_Delete
 @Id_Puesto INT
  
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY
	
	DELETE FROM dbo.Puestos WHERE Id_Puesto=@Id_Puesto


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