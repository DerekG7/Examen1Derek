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
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE,
                DISABLE_BROKER 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367)) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creando Tabla [dbo].[Departamentos]...';


GO
CREATE TABLE [dbo].[Departamentos] (
    [Id_Departamento] INT           IDENTITY (1, 1) NOT NULL,
    [Descripcion]     VARCHAR (250) NOT NULL,
    [Ubicacion]       VARCHAR (250) NOT NULL,
    [Estado]          BIT           NOT NULL,
    CONSTRAINT [PK_Departamento] PRIMARY KEY CLUSTERED ([Id_Departamento] ASC)
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creando Tabla [dbo].[Puestos]...';


GO
CREATE TABLE [dbo].[Puestos] (
    [Id_Puesto] INT           IDENTITY (1, 1) NOT NULL,
    [Nombre]    VARCHAR (250) NOT NULL,
    [Salario]   INT           NULL,
    [Estado]    BIT           NOT NULL,
    CONSTRAINT [PK_Puesto] PRIMARY KEY CLUSTERED ([Id_Puesto] ASC)
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creando Tabla [dbo].[Titulos]...';


GO
CREATE TABLE [dbo].[Titulos] (
    [Id_Titulo]   INT           IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (250) NOT NULL,
    [Estado]      BIT           NOT NULL,
    CONSTRAINT [PK_Titulo] PRIMARY KEY CLUSTERED ([Id_Titulo] ASC)
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creando Procedimiento [dbo].[Departamento_Delete]...';


GO
CREATE PROCEDURE [dbo].[Departamento_Delete]
@IdDepartamento INT
AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY
     
     DELETE FROM Departamentos
     WHERE
         Id_Departamento=@IdDepartamento

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
PRINT N'Creando Procedimiento [dbo].[Departamento_Get]...';


GO
CREATE PROCEDURE [dbo].[Departamento_Get]
	@IdDepartamento INT= null

AS
BEGIN
  SET NOCOUNT ON

SELECT 
		Id_Departamento,
		Descripcion,
		Ubicacion,
		Estado
FROM Departamentos
WHERE (@IdDepartamento IS NULL OR Id_Departamento=@IdDepartamento)

END
GO
PRINT N'Creando Procedimiento [dbo].[Departamento_Insert]...';


GO
CREATE PROCEDURE [dbo].[Departamento_Insert]
@Descripcion VARCHAR(250),
@Ubicacion VARCHAR(250),
@Estado BIT
AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY
       INSERT INTO Departamentos
       ( Descripcion,Ubicacion, Estado)
       VALUES
       (@Descripcion,@Ubicacion, @Estado)


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
PRINT N'Creando Procedimiento [dbo].[Departamento_Update]...';


GO
create PROCEDURE [dbo].[Departamento_Update]
@IdDepartamento INT,
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
           Id_Departamento=@IdDepartamento

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
PRINT N'Creando Procedimiento [dbo].[Puestos_Delete]...';


GO
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
GO
PRINT N'Creando Procedimiento [dbo].[Puestos_Get]...';


GO
CREATE PROCEDURE [dbo].[Puestos_Get]
	@Id_Puesto INT= null

AS
BEGIN
  SET NOCOUNT ON

SELECT 
		Id_Puesto,
		Nombre,
		Salario,
		Estado
FROM Puestos
WHERE (@Id_Puesto IS NULL OR Id_Puesto=@Id_Puesto)

END
GO
PRINT N'Creando Procedimiento [dbo].[Puestos_Insert]...';


GO
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
GO
PRINT N'Creando Procedimiento [dbo].[Puestos_Update]...';


GO
CREATE PROCEDURE dbo.Puestos_Update
	@Id_Puesto INT,
	@Nombre VARCHAR(250),
    @Salario INT,
	@Estado BIT
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY

	UPDATE dbo.Puestos SET
	 Id_Puesto=@Id_Puesto,
	 Nombre=@Nombre,
	 Salario=@Salario,
	 Estado=@Estado
	
	WHERE Id_Puesto=@Id_Puesto

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
GO
PRINT N'Creando Procedimiento [dbo].[Titulos_Delete]...';


GO
CREATE PROCEDURE [dbo].[Titulos_Delete]
@Id_Titulo INT
AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY
     
     DELETE FROM Titulos
     WHERE
         Id_Titulo=@Id_Titulo

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
PRINT N'Creando Procedimiento [dbo].[Titulos_Get]...';


GO
CREATE PROCEDURE [dbo].[Titulos_Get]
	@Id_Titulo INT= null

AS
BEGIN
  SET NOCOUNT ON

SELECT 
		Id_Titulo,
		Descripcion,
		Estado
FROM Titulos
WHERE (@Id_Titulo IS NULL OR Id_Titulo=@Id_Titulo)

END
GO
PRINT N'Creando Procedimiento [dbo].[Titulos_Insert]...';


GO
CREATE PROCEDURE dbo.Titulos_Insert
    
	@Descripcion varchar(250),	
	@Estado BIT
	
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY

		
		INSERT INTO dbo.Titulos
		(
	    Descripcion
	    , Estado 		
		)
		VALUES
		( 
		   @Descripcion  
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
GO
PRINT N'Creando Procedimiento [dbo].[Titulos_Update]...';


GO
create PROCEDURE [dbo].[Titulos_Update]
@Id_Titulo INT,
@Descripcion VARCHAR(250),
@Estado BIT

AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY

       UPDATE Titulos
       SET
       Descripcion=@Descripcion,
       Estado=@Estado
       WHERE 
           Id_Titulo=@Id_Titulo

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
