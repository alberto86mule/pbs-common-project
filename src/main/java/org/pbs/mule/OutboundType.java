package org.mhra.mule;

public enum OutboundType {
	 FILE,
	 SFTP,
	 REST,  // Both HTTP and HTTPS
	 QUEUE, // It could be JMS or Anypoint MQ
	 LDAP,  // Any directory call
	 JDBC,	// Any relational database call
	 SOAP 	// both HTTP and HTTPS based SOAP
}
