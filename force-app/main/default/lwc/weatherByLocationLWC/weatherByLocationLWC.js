import { LightningElement, api, wire, track } from 'lwc';
import getWeather from '@salesforce/apex/WeatherByLocationController.getWeather';
import { updateRecord } from 'lightning/uiRecordApi';
import ID_FIELD from "@salesforce/schema/Account.Id";
import AccountCurrentWeather__c from "@salesforce/schema/Account.AccountCurrentWeather__c";

export default class WeatherByLocationLWC extends LightningElement {
    @api
    recordId;
    @track weatherResponse;
    @track error;
    @track weather_img;

    @wire(getWeather, {accId: '$recordId'}) 
    wireAccountRecord({error, data}){
        console.log(data);
        if(data){
            this.weatherResponse = JSON.parse(data);
            this.updateAccount();
            this.error = undefined;
        }else{
            this.error = error;
            this.weatherResponse = undefined;
        }
    }

    get weatherDescription(){
        return this.weatherResponse?.current?.weather?.[0]?.description || "";
    }

    get accountAddress(){
        return this.weatherResponse?.address || "";
    }

    updateAccount(){
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[AccountCurrentWeather__c.fieldApiName] = this.weatherDescription;
        const recordInput = { fields };
        updateRecord(recordInput);
    }
}