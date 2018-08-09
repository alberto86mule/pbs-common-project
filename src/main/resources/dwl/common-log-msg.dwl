%dw 1.0
%output application/json
---
{
	 // This is needed for E2E transaction tracing - it is going to be very useful -
	 //  in log aggregator (like Splunk or ELK)
	 (transactionId: flowVars.transactionId) when flowVars.transactionId != null,
	 
	 // This is a very important piece of audit information which could be 
	 // logged to track which client is actually making this call
	 (clientId: flowVars.clientId) when flowVars.clientId != null,
	
	 // Only applicable when the `flowVars.integrationPattern` is BATCH
	 //   It tells us which record is being processed out of the batch the 
	 // application currently handling. This needs to be set manually
	 (batchRecordId: recordVars.batchRecordId) when recordVars.batchRecordId != null,
	
	 // This is the name of the application
	 application: p('api.application.name'),
	
	 dateTimeStamp: now as :string { format: "yyyy-MM-dd'T'HH:mm:ssZ" },
	
	 // From what type of pattern the log is being triggered.
	 //     HTTP - The logging is from a Synchronous call - which is almost all the time an API.
	 //     BATCH - The call is from a batch context
	 //     MESSAGING - The logging request is from a messaging context      
	 (integrationPattern: flowVars.integrationPattern) when flowVars.integrationPattern != null,  
	
	 // Which Rest resource it is working with. Not required for non-api transactions
	 // It is only applicable when `flowVars.integrationPattern` is SYNC
	 (uri: flowVars.resource) when flowVars.resource != null,

	 // Current stage of the processing
	 (processingStage: flowVars.processingStage) when flowVars.processingStage != null,
	 
	 // Current status of the transaction
	 (transactionStatus: flowVars.transactionStatus) when flowVars.transactionStatus != null,
	 
	 
	 (httpStatusCode: outboundProperties['http.status']) when outboundProperties['http.status'] != null,
	
	 // In case of failure, provide proper error message
	 (errorMessage: flowVars.errorMessage) when flowVars.errorMessage != null,
	
	 // In case error, more information could be provided here.
	 (errorDescription: flowVars.errorDescription) when flowVars.errorDescription != null
 
 }