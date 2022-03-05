"use strict";
var InstitutoEdit;
(function (InstitutoEdit) {
    var Formulario = new Vue({
        data: {
            Formulario: "#FormEdit"
        },
        mounted: function () {
            CreateValidator(this.Formulario);
        }
    });
    Formulario.$mount("#AppEdit");
})(InstitutoEdit || (InstitutoEdit = {}));
//# sourceMappingURL=Edit.js.map