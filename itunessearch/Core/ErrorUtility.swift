//
//  ErrorUtility.swift
//  itunessearch
//
//  Created by Admin on 21.06.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import Foundation

/// standard error utility for API calls
class ErrorUtility {
    
    static let instance = ErrorUtility();
    class func sharedInstance() -> ErrorUtility
    {
        return instance;
    }
    
    class func errorMessageFor(response: HTTPURLResponse?, error: NSError?)-> String
    {
        
        var errorCode: Int!
        
        if (response != nil)
        {
            errorCode = response!.statusCode
        }
        else
        {
            errorCode = error!.code;
        }
        
        if (errorCode == -1004)
        {
            return ErrorMessage.InternetIssue.rawValue
        }
        if errorCode == 204{
            return "\(errorCode!)"
        }
        if errorCode == 200 || errorCode == 201 {
            return "success"
        }
        return self.errorMessageFor(errorcode: errorCode)
    }
    
    
    class func errorMessageFor(errorcode: Int)-> String
    {
        var errorString = ""
        
        switch (errorcode) {
            
        case ErrorCode.GatewayTimeout.rawValue:
            errorString = ErrorMessage.GatewayTimeout.rawValue
            
        case ErrorCode.BadRequest.rawValue :
            errorString = ErrorMessage.BadRequest.rawValue
            
        case ErrorCode.CannotFindHost.rawValue :
            errorString = ErrorMessage.CannotFindHost.rawValue
            
        case ErrorCode.UnAuthorized.rawValue :
            errorString = ErrorMessage.UnAuthorized.rawValue
            
        case ErrorCode.Forbidden.rawValue :
            errorString = ErrorMessage.Forbidden.rawValue
            
        case ErrorCode.NotFound.rawValue :
            errorString = ErrorMessage.NotFound.rawValue
            
        case ErrorCode.ParameterMissing.rawValue :
            errorString = ErrorMessage.ParameterMissing.rawValue
            
        case ErrorCode.UserAlreadyExists.rawValue :
            errorString = ErrorMessage.UserAlreadyExists.rawValue
            
        case ErrorCode.NotModified.rawValue :
            errorString = ErrorMessage.NotModified.rawValue
            
        case ErrorCode.RequestStopped.rawValue :
            errorString = ErrorMessage.RequestStopped.rawValue
            
        case ErrorCode.NoInternetConnection.rawValue :
            errorString = ErrorMessage.InternetIssue.rawValue
            
        case ErrorCode.ServerError.rawValue :
            errorString = ErrorMessage.ServerError.rawValue
            
        case ErrorCode.NetworkConnectionLost.rawValue :
            errorString = ErrorMessage.NetworkConnectionLost.rawValue

        case ErrorCode.CannotConnectToHost.rawValue :
            errorString = ErrorMessage.CannotConnectToHost.rawValue
            
            
        default :
            errorString =  ErrorMessage.UnknownError.rawValue
        }
        return errorString;
    }
    
}

enum ErrorCode: Int
{
    case GatewayTimeout = 504
    case BadRequest = 400
    case UnAuthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case ParameterMissing = 406
    case UserAlreadyExists = 409
    case ServerError = 500
    case NotModified = 304
    case NoInternetConnection = -1009
    case CannotFindHost = -1003
    case CannotConnectToHost = -1004
    case NetworkConnectionLost = -1005
    case RequestStopped = -999
    case success = 200
    case Success = 201
    case Timeout = 440
}

enum ErrorMessage: String
{
    case GatewayTimeout = "Gateway Timeout"
    case BadRequest = "Bad Request"
    case CannotFindHost = "Cannot find host"
    case UnAuthorized = "UnAuthorized"
    case Forbidden = "Forbidden"
    case NotFound = "Not Fund"
    case ParameterMissing = "Parameter Missing"
    case UserAlreadyExists = "User already exists"
    case NotModified = "Not Modified"
    case RequestStopped = "Request Stopped"
    case InternetIssue = "Internet connection error"
    case ServerError = "Server error"
    case UnknownError = "Unknown Error, Please try later"
    case NetworkConnectionLost = "Network connection lost"
    case CannotConnectToHost = "Cannot Connect To Host"
    case TimeOut = "Session timeout"
}
