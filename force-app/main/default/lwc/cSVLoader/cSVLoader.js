import { LightningElement,track } from 'lwc';
import cSVLoaderDatos from '@salesforce/apex/cSVLoaderService.cSVLoaderDatos';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class CSVLoader extends LightningElement {

    get acceptedFormats() {
        return ['.csv'];
       }

    @track contentDocumentId;
    @track recordCount;

    uploadFileHandler( event ) {
        const uploadedFiles = event.detail.files;

        // obtener el nombre del archivo
        console.log('file name es:-'+uploadedFiles[0].name);

        // obtener id document
        console.log('document id es:-'+uploadedFiles[0].documentId);

        this.contentDocumentId=uploadedFiles[0].documentId;
        
        cSVLoaderDatos({ contentDocumentId : this.contentDocumentId })
        .then((result)=>{
          this.recordCount=result;
  
          const event = new ShowToastEvent({
          title: 'Success',
          message:
            this.recordCount+' Tanques Industriales records inserted Successfully.',
           variant:'success',
           mode:'dismissible'
           });
           this.dispatchEvent(event);
         })
        .catch((error)=>{
           this.error = error;
           const event=new ShowToastEvent({
              title:'Error',
              variant:'error',
              message:'Error en la creación de los registros',
              mode:'dismissible'
           })
           this.dispatchEvent(event);
        })

    }
    
}