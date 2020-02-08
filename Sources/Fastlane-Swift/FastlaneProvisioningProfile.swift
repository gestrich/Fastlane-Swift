//
//  FastlaneProvisioningProfile.swift
//  Fastlane
//
//  Created by Bill Gestrich on 2/8/20.
//

import Foundation

public class FastlaneProvisioningProfile: Codable {
    
    public var id: String
    public var uuid: String
    public var expires: String?
    public var distribution_method: String?
    public var name: String?
    public var status: String?
    public var type: String?
    public var version: String?
    public var platform: String?
    public var sub_platform: String?
    public var managing_app: String?
    public var certificates: [FastlaneCertificate]?
    
    public func pendingCertificates(availableCertificates: [FastlaneCertificate]) -> [FastlaneCertificate]{
        if let profileCerts = certificates {
            return Array(Set(availableCertificates).subtracting(profileCerts))    
        } else {
            return availableCertificates
        }
    }

}

public class FastLaneProvisioningProfileResponse: Codable {
    public var profiles: [FastlaneProvisioningProfile]?
    public var availableCertificates: [FastlaneCertificate]?
    public var error: String?
    
}
