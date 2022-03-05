/*
Script de implementación para Examen1

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Examen1"
:setvar DefaultFilePrefix "Examen1"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Modificando Procedimiento [dbo].[Departamento_Get]...';


GO
ALTER PROCEDURE [dbo].[Departamento_Get]
	@Id_Departamento INT= null

AS
BEGIN
  SET NOCOUNT ON

SELECT 
		Id_Departamento,
		Descripcion,
		Ubicacion,
		Estado
FROM Departamentos
WHERE (@Id_Departamento IS NULL OR Id_Departamento=@Id_Departamento)

END
GO
PRINT N'Modificando Procedimiento [dbo].[Departamento_Update]...';


GO
ALTER PROCEDURE [dbo].[Departamento_Update]
@Id_Departamento INT,
@Descripcion VARCHAR(250),
@Ubicacion VARCHAR(250),
@Estado BIT

AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY

       UPDATE Departamentos
       SET
       Descripcion=@Descripcion,
       Ubicacion=@Ubicacion,
       Estado=@Estado
       WHERE 
           Id_Departamento=@Id_Departamento

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
GO
PRINT N'Actualización completada.';


GO
