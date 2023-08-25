import { LightningElement, wire, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation'; 
import getFilteredTiposDeTanque from "@salesforce/apex/tiposDeTanquesService.getFilteredTiposDeTanque";

export default class ListaTipos_Tanques extends NavigationMixin (LightningElement) {
    //@api TipoDeTanque;

    //PROPERTIES. GETTERS & SETTERS
    searchText= '';


    // LIFECICLE HOOKS


    //WIRE
    @wire(getFilteredTiposDeTanque,{ searchText : '$searchText' }) ListaTiposTanques;
    //searchText : '$searchText' Con este parámetro dinámico le digo al @wire que cuando hayan cambios traiga nuevos valores


    // METHODS

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

    handleInputChange(event){
        const searchTextAux = event.detail.value;
        if(searchTextAux.length >= 2 || searchTextAux === '' ){
            this.searchText = searchTextAux;
        }
    }
}