CREATE PROCEDURE [dbo].[Departamento_Get]
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

