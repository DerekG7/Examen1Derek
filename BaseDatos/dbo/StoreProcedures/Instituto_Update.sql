create PROCEDURE [dbo].[Instituto_Update]
@Id_Institucion int,
@Codigo VARCHAR(250),
@Nombre  VARCHAR(250),
@Telefono  VARCHAR(250),
@Estado BIT

AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY

       UPDATE Institucion
       SET
       Codigo=@Codigo,
       Nombre=@Nombre,
       Telefono=@Telefono,
       Estado=@Estado
       WHERE 
           Id_Institucion=@Id_Institucion

       COMMIT TRANSACTION TRASA

          SELECT 0 AS CodeError, '' AS MsgError
    END TRY

    BEGIN CATCH
          SELECT 
                 ERROR_NUMBER() AS CodeError, 
                 ERROR_MESSAGE() AS MsgError
           ROLLBACK TRANSACTION TRASA    
    END CATCH

  END