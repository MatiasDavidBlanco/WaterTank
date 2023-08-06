import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class TipoDeTanqueCard extends LightningElement {
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