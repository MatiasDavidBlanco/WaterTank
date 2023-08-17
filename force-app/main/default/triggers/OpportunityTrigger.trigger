// /* Good trigger practices:
// 1. One trigger for one object
// 2. Naming convention ex: ContactTrigger 
// 3. Handler class for the trigger ex: ContactTrigger_Handler.myMethod(Trigger.New)
//     trigger ContactTrigger on Contact (before insert, after insert) {
//         if(Trigger.isInsert){
//             ......
//         }
//         if(Trigger.isUpdate){
//             ......
//         }
//     }
// 4. NO DML or SOQL inside for loops
// 5. Use custom label to activate/deactivate your triggers
//  */

// trigger OpportunityTrigger on Opportunity (before insert){
//     if(Trigger.isInsert){
//         OpportunityTrigger_Handler.seleccionarTanque(Trigger.New);
//     }
// }
