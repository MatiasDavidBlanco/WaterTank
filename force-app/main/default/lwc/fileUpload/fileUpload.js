import { LightningElement,track } from 'lwc';
import loadCSVData from '@salesforce/apex/FileUploadController.loadCSVData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class FileUpload extends LightningElement {

    // Getter for accepted file formats
    get acceptedFormats() {
        return ['.csv'];
       }

    // Tracking variables to hold document ID and record count
    @track contentDocumentId;
    @track recordCount;

    // Handling the file upload event
    uploadFileHandler( event ) {
        const uploadedFiles = event.detail.files;
        //console.log('file name:-'+uploadedFiles[0].name);
        //console.log('document id:-'+uploadedFiles[0].documentId);

        this.contentDocumentId=uploadedFiles[0].documentId;

        // Calling the Apex method to load CSV data using the content document ID
        loadCSVData({ contentDocumentId : this.contentDocumentId })
        .then((result)=>{
          this.recordCount=result;

          // Creating a success toast notification
          const event = new ShowToastEvent({
          title: 'Success',
          message:
            this.recordCount+' Tanques industriales insertados con éxito.', // CUSTOM LABEL
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
              message:'Error en la creación de registros',
              mode:'dismissible'
           })
           this.dispatchEvent(event);
           console.log(error.getMessage());
        })

    }
    
}