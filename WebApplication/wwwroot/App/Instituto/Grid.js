"use strict";
var InstitutoGrid;
(function (InstitutoGrid) {
    if (MensajeApp != "") {
        Toast.fire({
            icon: "success", title: MensajeApp
        });
    }
    function OnClickEliminar(id) {
        ComfirmAlert("Desea eliminar el registro?", "Eliminar", "warning", "#3085d6", "#d33")
            .then(function (result) {
            if (result.isConfirmed) {
                window.location.href = "Instituto/Grid?handler=Eliminar&id=" + id;
            }
        });
    }
    InstitutoGrid.OnClickEliminar = OnClickEliminar;
    $("#GridView").DataTable();
})(InstitutoGrid || (InstitutoGrid = {}));
//# sourceMappingURL=Grid.js.map