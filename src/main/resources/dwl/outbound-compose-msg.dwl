%dw 1.0
%output application/json
---
{
	 // This is needed for E2E transaction tracing - it is going to be very useful -
	 //  in log aggregator (like Splunk or ELK)
	 (transactionId: flowVars.transactionId) when flowVars.transactionId != null,	 
	
	 // Only applicable when the `flowVars.integrationPattern` is BATCH
	 // It tells us which record is being processed out of the batch the 
	 // application currently handling. This needs to be set manually
	 (batchRecordId: recordVars.batchRecordId) when recordVars.batchRecordId != null,	 
	
	 dateTimeStamp: now as :string { format: "yyyy-MM-dd'T'HH:mm:ssZ" },
	 
	 // From what type of pattern the log is being triggered.
	 //     HTTP - The logging is from a Synchronous call - which is almost all the time an API.
	 //     BATCH - The call is from a batch context
	 //     MESSAGING - The logging request is from a messaging context      
	 (integrationPattern: flowVars.integrationPattern) when flowVars.integrationPattern != null,  
	
	 // Required for all the outbound calls. It explain its source
	 // It will set to the current application name, source from property file. 
	 sourceApplication: p('api.application.name'), 
	
	 // Required for all the outbound calls. Signifies which system it is trying to contact to
	 (targetApplication: flowVars.target) when flowVars.target != null, 
	
	 // Which REST resource it is working with. Not required for non-api transactions
	 // It is only applicable when `flowVars.integrationPattern` is HTTP
	 (targetResource: flowVars.targetResource) when flowVars.targetResource != null,
	
	 // The type of outbound application dealing with
	 // 	FILE
	 //		SFTP
	 //		REST - Both HTTP and HTTPS
	 //		QUEUE - It could be JMS or Anypoint MQ
	 //		LDAP - Any directory call
	 //		JDBC - Any relational database call
	 //		SOAP - both HTTP and HTTPS based SOAP
	 (outboundType: flowVars.outboundType) when flowVars.outboundType != null,
	
	 // Current status of the processing
	 (outboundStatus: flowVars.outboundStatus) when flowVars.outboundStatus != null,
	
	 // In case of failure, provide proper error message
	 (errorMessage: flowVars.errorMessage) when flowVars.errorMessage != null,
	 
	 (returnedHttpStatusCode: inboundProperties['http.status']) when inboundProperties['http.status'] != null,
	
	 // In case error, more information could be provided here.
	 (errorDescription: flowVars.errorDescription) when flowVars.errorDescription != null
 
 }