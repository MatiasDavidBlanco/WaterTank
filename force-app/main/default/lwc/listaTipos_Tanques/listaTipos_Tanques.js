import { LightningElement, wire, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation'; 
import getAllTiposDeTanque from "@salesforce/apex/tiposDeTanquesService.getAllTiposDeTanque";

export default class ListaTipos_Tanques extends LightningElement {
    @api TipoDeTanque;
    @wire(getAllTiposDeTanque) ListaTiposTanques;
    

    navigateToRecordViewPage(e) {
        console.log("Button clicked");
        console.log(this.ListaTiposTanques.data[0].Id);
       

        const recordId = e.target.dataset.id;
        console.log("Button clicked with record ID:", recordId);

        const event = new CustomEvent('verdetalles', {
            detail: {
                recordId: recordId
            }
        });
        this.dispatchEvent(event);

        // View a custom object record.
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId:  this.recordId,
                objectApiName: 'Tipo_de_Tanque__c', // objectApiName is optional
                actionName: 'view'
            }
        });
    }




}
