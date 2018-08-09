package org.mhra.mule;


import org.apache.log4j.Level;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CustomLogger {
	private static Logger _logger = LoggerFactory.getLogger("");
	
	public static void log(String msg, 
					String category, 
					Level level) {
		if(Level.INFO.equals(level)) {
			_logger.info(category + ": " + msg);
		}
		else if(Level.DEBUG.equals(level)) {
			_logger.debug(category + ": " + msg);
		}
		else if(Level.ERROR.equals(level)) {
			_logger.error(category + ": " + msg);
		}
		else if(Level.TRACE.equals(level)) {
			_logger.trace(category + ": " + msg);
		}
		else if(Level.WARN.equals(level)) {
			_logger.warn(category + ": " + msg);
		}
		else {
			_logger.info(category + ": " + msg);
		}
	}
	
	public static void log(String msg, 
					String category, 
					Level level, 
					Throwable exception) {
		if(Level.INFO.equals(level)) {
			_logger.info(category + ": " + msg, exception);
		}
		else if(Level.DEBUG.equals(level)) {
			_logger.debug(category + ": " + msg, exception);
		}
		else if(Level.ERROR.equals(level)) {
			_logger.error(category + ": " + msg, exception);
		}
		else if(Level.TRACE.equals(level)) {
			_logger.trace(category + ": " + msg, exception);
		}
		else if(Level.WARN.equals(level)) {
			_logger.warn(category + ": " + msg, exception);
		}
		else {
			_logger.info(category + ": " + msg, exception);
		}
	}

}
