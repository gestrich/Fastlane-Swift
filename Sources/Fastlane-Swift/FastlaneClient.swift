//
//  FastlaneClient.swift
//  Fastlane
//
//  Created by Bill Gestrich on 2/6/20.
//

import Foundation
import swift_utilities

public class FastlaneClient: NSObject {
    
    let username: String
    let password: String
    let team: String
    let resourcesDirectoryPath: String
    
    public init(username: String, password: String, team: String, resourcesDirectoryPath: String) {
        self.username = username
        self.password = password
        self.team = team
        self.resourcesDirectoryPath = resourcesDirectoryPath
    }
    
    public func iOSCertificates(profileName: String) throws -> [FastlaneCertificate] {
        
        let jsonData = try self.runFastLane(lane: "get_ios_certificates_lane", args: [profileName])
        
        let decoder = JSONDecoder()
        guard let certResult = try? decoder.decode(FastLaneCerticateFetchResult.self, from: jsonData) else {
            throw FastLaneClientError(reason: "Error decoding result")
        }
        
        if let error = certResult.error {
            throw FastLaneClientError(reason: error)
        }
        
        return certResult.result
    }
    
    public func iOSCertificates() throws -> [FastlaneCertificate] {

        let jsonData = try self.runFastLane(lane: "get_ios_certificates_lane", args: [])
        
        let decoder = JSONDecoder()
        guard let certResult = try? decoder.decode(FastLaneCerticateFetchResult.self, from: jsonData) else {
            throw FastLaneClientError(reason: "Error decoding result")
        }
        
        if let error = certResult.error {
            throw FastLaneClientError(reason: error)
        }

        return certResult.result
    }
    
    public func addAvailableIOSCertificates(profileName: String) throws -> [FastlaneCertificate] {

        let jsonData = try self.runFastLane(lane: "add_ios_certificates_lane", args: [profileName])
        
        let decoder = JSONDecoder()
        guard let certResult = try? decoder.decode(FastLaneCerticateFetchResult.self, from: jsonData) else {
            throw FastLaneClientError(reason: "Error decoding result")
        }
        
        if let error = certResult.error {
            throw FastLaneClientError(reason: error)
        }

        return certResult.result
    }
    
    public func getProfileResponse(profileName: String?) throws -> FastLaneProvisioningProfileResponse {

        let args = profileName != nil ? [profileName!] : [String]()
        let jsonData = try self.runFastLane(lane: "get_profiles_lane", args: args)
        
        let decoder = JSONDecoder()
        var profileResponse: FastLaneProvisioningProfileResponse
        do {
            profileResponse = try decoder.decode(FastLaneProvisioningProfileResponse.self, from: jsonData)
            if let error = profileResponse.error {
                throw FastLaneClientError(reason: error)
            }
        } catch let err {
            print(err)
            throw FastLaneClientError(reason: "Error decoding result")
        }

        return profileResponse
    }
    
    func runFastLane(lane: String, args:[String]) throws -> Data {
        
        let scriptPath = self.resourcesDirectoryPath.appending("/fastlaneScript.sh")
        
        let randomNum = Int.random(in: 0..<10000000000)
        let outputPath = "/tmp/fastlane-\(randomNum).json"
        let outputURL = URL(fileURLWithPath: outputPath)
        if FileManager.default.fileExists(atPath: outputPath){
            do {
                try FileManager.default.removeItem(atPath: outputPath)
            } catch let exc {
                print("Error deleting file \(exc)")
            }
        }
        var allArgs = ["/bin/bash", scriptPath, outputPath, self.username, self.password, self.team, lane]
        allArgs.append(contentsOf: args)
        let _ = shell(arguments: allArgs)
        
        guard let jsonData = try? Data(contentsOf: outputURL) else {
            try? FileManager.default.removeItem(atPath: outputPath)
            throw FastLaneClientError(reason: "Error decoding result")
        }
        
        do {
            try FileManager.default.removeItem(atPath: outputPath)
        } catch let exc {
            print("Error deleting file \(exc)")
        }
        
        return jsonData
    }
}


public struct FastLaneClientError : Error {
    let reason : String
}
