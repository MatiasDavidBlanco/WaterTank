import { LightningElement, wire, api } from 'lwc';
import getAllTiposDeTanque from "@salesforce/apex/tiposDeTanquesService.getAllTiposDeTanque";

export default class ListaTipos_Tanques extends LightningElement {
    @wire(getAllTiposDeTanque) ListaTiposTanques;
    @api TipoDeTanque;

    navigateToRecordViewPage() {
        // View a custom object record.
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.TipoDeTanque.Id,
                objectApiName: 'Tipo_de_Tanque__c', // objectApiName is optional
                actionName: 'view'
            }
        });
    }



}
