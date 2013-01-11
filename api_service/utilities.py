import logging
log = logging.getLogger(__name__)

def remove_unwanted_keyvalue(d):
    original_dict = d
    for key in original_dict.keys():
        if key == '_sa_instance_state':
            del original_dict[key]
            
    return original_dict
    
def method_not_supported_message(method):
    error_message = "HTTP error 405 %s method not supported"%method  
    log.info(error_message)
    return error_message