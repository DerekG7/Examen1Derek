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

