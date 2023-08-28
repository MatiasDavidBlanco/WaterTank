import {LightningElement, track} from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import { createRecord } from 'lightning/uiRecordApi';
import PARSER from '@salesforce/resourceUrl/PapaParse';
import TANQUE_INDUSTRIAL__C_OBJECT from '@salesforce/schema/Tanque_Industrial__c';
import TIPO_DE_TANQUE__C_FIELD from '@salesforce/schema/Tanque_Industrial__c.Tipo_de_Tanque__c';
import NUMERO_DE_SERIE__C_FIELD from '@salesforce/schema/Tanque_Industrial__c.Numero_de_Serie__c';
import ESTADO__C_FIELD from '@salesforce/schema/Tanque_Industrial__c.Estado__c';

export default class importTanquesIndustriales extends LightningElement {
    parserInitialized = false;
    loading = false;
    @track _results;
    @track _rows;
    
    get columns(){
        const columns = [
            { label: 'Tipo de Tanque', fieldName: 'TipodeTanque' },
            { label: 'Número de serie', fieldName: 'NumerodeSerie' },
            { label: 'Estado', fieldName: 'Estado' }
        ];
        if(this.results.length){
            columns.push({ label: 'Result',fieldName: 'result' });
        }
        return columns;
    }
    get rows(){
        if(this._rows){
            return this._rows.map((row, index) => {
                row.key = index;
                if(this.results[index]){
                    row.result = this.results[index].id || this.results[index].error;
                }
                return row;
            })
        }
        return [];
    }
    get results(){
        if(this._results){
            return this._results.map(r => {
                const result = {};
                result.success = r.status === 'fulfilled';
                result.id = result.success ? r.value.id : undefined;
                result.error = !result.success ? r.reason.body.message : undefined;
                return result;
            });
        }
        return [];
    }
    renderedCallback() {
        if(!this.parserInitialized){
            loadScript(this, PARSER)
                .then(() => {
                    this.parserInitialized = true;
                })
                .catch(error => console.error(error));
        }
    }
    handleInputChange(event){
        if(event.target.files.length > 0){
            const file = event.target.files[0];
            this.loading = true;
            Papa.parse(file, {
                quoteChar: '"',
                header: 'true',
                complete: (results) => {
                    this._rows = results.data;
                    this.loading = false;
                },
                error: (error) => {
                    console.error(error);
                    this.loading = false;
                }
            })
        }
    }

    createTanquesIndustriales() {
        const tanquesToCreate = this.rows.map(row => {
            const fields = {};
            fields[TIPO_DE_TANQUE__C_FIELD.fieldApiName] = row.TipodeTanque;
            fields[NUMERO_DE_SERIE__C_FIELD .fieldApiName] = row.NumerodeSerie;
            fields[ESTADO__C_FIELD .fieldApiName] = row.Estado;
            const recordInput = { apiName: TANQUE_INDUSTRIAL__C_OBJECT.objectApiName, fields };
    
            return createRecord(recordInput)
                .catch(error => {
                    console.error("Error creating record:", error);
                    throw error; // Rethrow the error to be caught in the Promise.allSettled
                });
        });
    
        if (tanquesToCreate.length) {
            this.loading = true;
            Promise.allSettled(tanquesToCreate)
                .then(results => this._results = results)
                .catch(error => console.error("Overall error:", error))
                .finally(() => this.loading = false);
        }
    }
    cancel(){
        this._rows = undefined;
        this._results = undefined;
    }
}