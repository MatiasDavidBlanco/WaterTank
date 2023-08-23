import { LightningElement, wire, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation'; 
import getAllTiposDeTanque from "@salesforce/apex/tiposDeTanquesService.getAllTiposDeTanque";

export default class ListaTipos_Tanques extends NavigationMixin (LightningElement) {
    //@api TipoDeTanque;
    @wire(getAllTiposDeTanque) ListaTiposTanques;
    

    navigateToRecordViewPage(event) {
        const recordId = event.currentTarget.dataset.id;
        console.log(recordId);
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId:  recordId,
                objectApiName: 'Tipo_de_Tanque__c', // objectApiName is optional
                actionName: 'view'
            }
        });
    }
}

